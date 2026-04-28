import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../data/models/enums/payment_status.dart';
import '../../../../data/models/town.dart';
import '../../../../providers/parcel_repository_provider.dart';

final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return ImagePickerService();
});

class ParcelFormState {
  const ParcelFormState({
    required this.sourceTownOptions,
    required this.destinationTownOptions,
    required this.fromTown,
    required this.toTown,
    this.fromTownCityCode = '',
    this.formVersion = 0,
    this.senderName = '',
    this.senderPhone = '',
    this.receiverName = '',
    this.receiverPhone = '',
    this.parcelType = '',
    this.numberOfParcels = 0,
    this.totalCharges = 0,
    this.paymentStatus = PaymentStatus.unpaid,
    this.cashAdvance = 0,
    this.parcelImagePath,
    this.remark = '',
    this.isSaving = false,
    this.errorMessage,
    String? numberOfParcelsText,
    Map<String, String>? fieldErrors,
    String? printerWarning,
  }) : _fieldErrors = fieldErrors,
       _numberOfParcelsText = numberOfParcelsText,
       _printerWarning = printerWarning;

  final List<TownModel> sourceTownOptions;
  final List<TownModel> destinationTownOptions;
  final String fromTown;
  final String toTown;
  final String fromTownCityCode;
  final int formVersion;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final String parcelType;
  final String? _numberOfParcelsText;
  final int numberOfParcels;
  final double totalCharges;
  final PaymentStatus paymentStatus;
  final double cashAdvance;
  final String? parcelImagePath;
  final String remark;
  final bool isSaving;
  final String? errorMessage;
  final Map<String, String>? _fieldErrors;
  final String? _printerWarning;

  Map<String, String> get fieldErrors => _fieldErrors ?? const {};

  String get numberOfParcelsText => _numberOfParcelsText ?? '';

  String? get printerWarning => _printerWarning;

  ParcelFormState copyWith({
    List<TownModel>? sourceTownOptions,
    List<TownModel>? destinationTownOptions,
    String? fromTown,
    String? toTown,
    String? fromTownCityCode,
    int? formVersion,
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    String? parcelType,
    String? numberOfParcelsText,
    int? numberOfParcels,
    double? totalCharges,
    PaymentStatus? paymentStatus,
    double? cashAdvance,
    String? parcelImagePath,
    bool clearParcelImagePath = false,
    String? remark,
    bool? isSaving,
    String? errorMessage,
    bool clearErrorMessage = false,
    Map<String, String>? fieldErrors,
    bool clearFieldErrors = false,
    String? printerWarning,
    bool clearPrinterWarning = false,
  }) {
    return ParcelFormState(
      sourceTownOptions: sourceTownOptions ?? this.sourceTownOptions,
      destinationTownOptions:
          destinationTownOptions ?? this.destinationTownOptions,
      fromTown: fromTown ?? this.fromTown,
      toTown: toTown ?? this.toTown,
      fromTownCityCode: fromTownCityCode ?? this.fromTownCityCode,
      formVersion: formVersion ?? this.formVersion,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      parcelType: parcelType ?? this.parcelType,
      numberOfParcelsText: numberOfParcelsText ?? this.numberOfParcelsText,
      numberOfParcels: numberOfParcels ?? this.numberOfParcels,
      totalCharges: totalCharges ?? this.totalCharges,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      cashAdvance: cashAdvance ?? this.cashAdvance,
      parcelImagePath: clearParcelImagePath
          ? null
          : parcelImagePath ?? this.parcelImagePath,
      remark: remark ?? this.remark,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
      fieldErrors: clearFieldErrors
          ? const {}
          : fieldErrors ?? this.fieldErrors,
      printerWarning: clearPrinterWarning
          ? null
          : printerWarning ?? this.printerWarning,
    );
  }
}

class ParcelFormValidationResult {
  const ParcelFormValidationResult({
    required this.isValid,
    this.printerWarning,
  });

  final bool isValid;
  final String? printerWarning;
}

class ParcelFormNotifier extends AsyncNotifier<ParcelFormState> {
  int _formVersion = 0;

  @override
  Future<ParcelFormState> build() => _createInitialState();

  Future<ParcelFormState> _createInitialState() async {
    final townRepository = ref.read(townRepositoryProvider);
    final settingsRepository = await ref.read(settingsRepositoryProvider.future);
    final sourceTowns = await townRepository.getSourceTowns();
    final destinationTowns = await townRepository.getDestinationTowns();
    final defaultSourceTownName = await settingsRepository
        .getDefaultSourceTownName();
    final selectedSourceTown = sourceTowns.firstWhere(
      (town) => town.townName == defaultSourceTownName,
      orElse: () => sourceTowns.isEmpty
          ? const TownModel(townName: '', type: TownType.source)
          : sourceTowns.first,
    );
    final fromTown = selectedSourceTown.townName;
    final fromTownCityCode = selectedSourceTown.cityCode ?? '';
    final toTown = destinationTowns
        .firstWhere(
          (town) => town.townName != fromTown,
          orElse: () => destinationTowns.isEmpty
              ? const TownModel(townName: '', type: TownType.destination)
              : destinationTowns.first,
        )
        .townName;

    return ParcelFormState(
      sourceTownOptions: sourceTowns,
      destinationTownOptions: destinationTowns,
      fromTown: fromTown,
      toTown: toTown,
      fromTownCityCode: fromTownCityCode,
      formVersion: _formVersion,
    );
  }

  void _update(ParcelFormState Function(ParcelFormState state) updater) {
    final current = state.value;
    if (current == null) {
      return;
    }

    state = AsyncData(updater(current));
  }

  void updateFromTown(String value) {
    final selectedTown = state.value?.sourceTownOptions.firstWhere(
      (town) => town.townName == value.trim(),
      orElse: () => const TownModel(townName: '', type: TownType.source),
    );
    _update(
      (form) => form.copyWith(
        fromTown: value.trim(),
        fromTownCityCode: selectedTown?.cityCode ?? '',
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('fromTown')
          ..remove('toTown'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateToTown(String value) {
    _update(
      (form) => form.copyWith(
        toTown: value.trim(),
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('fromTown')
          ..remove('toTown'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateSenderName(String value) {
    _update(
      (form) => form.copyWith(
        senderName: value.trimLeft(),
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('senderName'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateSenderPhone(String value) {
    _update(
      (form) => form.copyWith(
        senderPhone: value.trim(),
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('senderPhone'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateReceiverName(String value) {
    _update(
      (form) => form.copyWith(
        receiverName: value.trimLeft(),
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('receiverName'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateReceiverPhone(String value) {
    _update(
      (form) => form.copyWith(
        receiverPhone: value.trim(),
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('receiverPhone'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateParcelType(String value) {
    _update(
      (form) => form.copyWith(
        parcelType: value.trim(),
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('parcelType'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateNumberOfParcels(String value) {
    final parsedValue = int.tryParse(value.trim()) ?? 0;
    _update(
      (form) => form.copyWith(
        numberOfParcelsText: value,
        numberOfParcels: parsedValue < 0 ? 0 : parsedValue,
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('numberOfParcels'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updateTotalCharges(double value) {
    _update(
      (form) => form.copyWith(
        totalCharges: value < 0 ? 0 : value,
        fieldErrors: Map<String, String>.from(form.fieldErrors)
          ..remove('totalCharges'),
        clearPrinterWarning: true,
      ),
    );
  }

  void updatePaymentStatus(PaymentStatus value) {
    _update((form) => form.copyWith(paymentStatus: value));
  }

  void updateCashAdvance(double value) {
    _update(
      (form) => form.copyWith(
        cashAdvance: value < 0 ? 0 : value,
        clearPrinterWarning: true,
      ),
    );
  }

  void updateRemark(String value) {
    _update((form) => form.copyWith(remark: value, clearPrinterWarning: true));
  }

  Future<void> pickParcelImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      final existingPath = state.value?.parcelImagePath;
      final path = await ref
          .read(imagePickerServiceProvider)
          .pickAndStoreImagePath(
            source: source,
            previousPath: existingPath,
          );
      if (path == null) {
        return;
      }

      _update(
        (form) => form.copyWith(
          parcelImagePath: path,
          clearErrorMessage: true,
        ),
      );
    } on Exception {
      final message = source == ImageSource.camera
          ? 'Could not open the camera. Check camera permission and try again.'
          : 'Could not pick an image from the gallery. Please try again.';
      _update((form) => form.copyWith(errorMessage: message));
    }
  }

  void clearErrorMessage() {
    _update((form) => form.copyWith(clearErrorMessage: true));
  }

  void clearParcelImage() {
    final existingPath = state.value?.parcelImagePath;
    if (existingPath != null && existingPath.isNotEmpty) {
      unawaited(
        ref.read(imagePickerServiceProvider).deleteStoredImage(existingPath),
      );
    }
    _update((form) => form.copyWith(clearParcelImagePath: true));
  }

  ParcelFormValidationResult validateForPreview({
    required bool isPrinterConnected,
  }) {
    final current = state.value;
    if (current == null) {
      return const ParcelFormValidationResult(isValid: false);
    }

    final errors = <String, String>{};

    if (current.fromTown.isEmpty) {
      errors['fromTown'] = 'Select from town.';
    } else if (current.fromTownCityCode.isEmpty) {
      errors['fromTown'] = 'Selected source town is missing a city code.';
    }
    if (current.toTown.isEmpty) {
      errors['toTown'] = 'Select to town.';
    }
    if (current.fromTown.isNotEmpty &&
        current.toTown.isNotEmpty &&
        current.fromTown == current.toTown) {
      errors['fromTown'] = 'From and To towns cannot be the same.';
      errors['toTown'] = 'From and To towns cannot be the same.';
    }
    if (current.senderName.trim().isEmpty) {
      errors['senderName'] = 'Enter sender name.';
    }
    if (current.senderPhone.trim().isEmpty) {
      errors['senderPhone'] = 'Enter sender phone.';
    }
    if (current.receiverName.trim().isEmpty) {
      errors['receiverName'] = 'Enter receiver name.';
    }
    if (current.receiverPhone.trim().isEmpty) {
      errors['receiverPhone'] = 'Enter receiver phone.';
    }
    if (current.parcelType.trim().isEmpty) {
      errors['parcelType'] = 'Enter parcel type.';
    }
    if (current.numberOfParcelsText.trim().isEmpty ||
        current.numberOfParcels < 1) {
      errors['numberOfParcels'] = 'Enter parcel count.';
    }
    if (current.totalCharges <= 0) {
      errors['totalCharges'] = 'Enter total charges.';
    }

    final printerWarning = isPrinterConnected
        ? null
        : 'Connect a Bluetooth printer before continuing.';

    _update(
      (form) => form.copyWith(
        fieldErrors: errors,
        printerWarning: printerWarning,
        clearErrorMessage: true,
      ),
    );

    return ParcelFormValidationResult(
      isValid: errors.isEmpty && isPrinterConnected,
      printerWarning: printerWarning,
    );
  }

  Future<void> reset() async {
    _formVersion++;
    state = const AsyncLoading();
    state = AsyncData(await _createInitialState());
  }
}

final parcelFormProvider =
    AsyncNotifierProvider<ParcelFormNotifier, ParcelFormState>(
      ParcelFormNotifier.new,
    );
