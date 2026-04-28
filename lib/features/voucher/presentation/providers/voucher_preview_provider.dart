import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/tracking_id_service.dart';
import '../../../../data/models/parcel.dart';
import '../../../../providers/parcel_repository_provider.dart';
import '../../../../shared/models/app_setup_config.dart';
import '../models/voucher_preview_args.dart';

final trackingIdServiceProvider = Provider<TrackingIdService>((ref) {
  return const TrackingIdService();
});

class VoucherPreviewData {
  const VoucherPreviewData({
    required this.parcel,
    required this.qrPayload,
    required this.setup,
  });

  final ParcelModel parcel;
  final String qrPayload;
  final AppSetupConfig setup;
}

final voucherPreviewProvider = FutureProvider.autoDispose
    .family<VoucherPreviewData, VoucherPreviewArgs>((ref, args) async {
      final settingsRepository = await ref.read(
        settingsRepositoryProvider.future,
      );
      final setup = await settingsRepository.getAppSetup();
      final townRepository = ref.read(townRepositoryProvider);
      final repository = ref.read(parcelRepositoryProvider);
      final now = DateTime.now();
      final sourceTown = args.form.fromTownCityCode.isNotEmpty
          ? null
          : await townRepository.getSourceTownByName(args.form.fromTown);
      final sourceCityCode = args.form.fromTownCityCode.isNotEmpty
          ? args.form.fromTownCityCode
          : sourceTown?.cityCode;
      if (sourceCityCode == null || sourceCityCode.isEmpty) {
        throw StateError('Selected source town is missing a city code.');
      }
      final runningNumber = await repository.countParcelsCreatedOnForCounter(
            now,
            sourceCityCode,
            setup.accountCode,
          ) +
          1;

      final trackingId = ref
          .read(trackingIdServiceProvider)
          .generate(
            cityCode: sourceCityCode,
            accountCode: setup.accountCode,
            now: now,
            runningNumber: runningNumber,
          );

      final parcel = ParcelModel.create(
        trackingId: trackingId,
        fromTown: args.form.fromTown,
        toTown: args.form.toTown,
        cityCode: sourceCityCode,
        accountCode: setup.accountCode,
        senderName: args.form.senderName,
        senderPhone: args.form.senderPhone,
        receiverName: args.form.receiverName,
        receiverPhone: args.form.receiverPhone,
        parcelType: args.form.parcelType,
        numberOfParcels: args.form.numberOfParcels,
        totalCharges: args.form.totalCharges,
        paymentStatus: args.form.paymentStatus,
        cashAdvance: args.form.cashAdvance,
        parcelImagePath: args.form.parcelImagePath,
        remark: args.form.remark.isEmpty ? null : args.form.remark.trim(),
        now: now,
      );

      final qrPayload = ref
          .read(qrServiceProvider)
          .buildParcelPayload(
            trackingId: trackingId,
          );

      return VoucherPreviewData(
        parcel: parcel,
        qrPayload: qrPayload,
        setup: setup,
      );
    });

final voucherReprintPreviewProvider = FutureProvider.autoDispose
    .family<VoucherPreviewData, int>((ref, parcelId) async {
      final settingsRepository = await ref.read(
        settingsRepositoryProvider.future,
      );
      final setup = await settingsRepository.getAppSetup();
      final parcel = await ref
          .read(parcelRepositoryProvider)
          .getParcel(parcelId);
      if (parcel == null) {
        throw StateError('Parcel not found.');
      }

      final qrPayload = ref
          .read(qrServiceProvider)
          .buildParcelPayload(
            trackingId: parcel.trackingId,
          );

      return VoucherPreviewData(
        parcel: parcel,
        qrPayload: qrPayload,
        setup: setup,
      );
    });
