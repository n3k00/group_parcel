import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_mobile/core/constants/parcel_strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:group_mobile/core/theme/app_theme.dart';
import 'package:group_mobile/data/models/enums/payment_status.dart';
import 'package:group_mobile/data/models/town.dart';
import 'package:group_mobile/features/parcel/presentation/providers/parcel_form_provider.dart';
import 'package:group_mobile/features/parcel/presentation/widgets/parcel_form_view.dart';

const _testFormState = ParcelFormState(
  sourceTownOptions: [
    TownModel(townName: 'Taunggyi', type: TownType.source, cityCode: 'TGI'),
  ],
  destinationTownOptions: [
    TownModel(townName: 'Kalaw', type: TownType.destination),
  ],
  fromTown: 'Taunggyi',
  toTown: 'Kalaw',
  fromTownCityCode: 'TGI',
  senderName: 'Ko Aung',
  senderPhone: '0912345678',
  receiverName: 'Ma Su',
  receiverPhone: '0998765432',
  parcelType: 'Box',
  numberOfParcels: 1,
  totalCharges: 5000,
  paymentStatus: PaymentStatus.unpaid,
  cashAdvance: 0,
  remark: '',
  numberOfParcelsText: '1',
);

ImageSource? _pickedSource;
String? _nextErrorMessage;

class _TestParcelFormNotifier extends ParcelFormNotifier {
  @override
  Future<ParcelFormState> build() async => _testFormState;

  @override
  Future<void> pickParcelImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    _pickedSource = source;
    if (_nextErrorMessage == null) {
      return;
    }

    state = AsyncData(
      state.requireValue.copyWith(errorMessage: _nextErrorMessage),
    );
  }

  @override
  void clearErrorMessage() {
    state = AsyncData(state.requireValue.copyWith(clearErrorMessage: true));
  }
}

Widget _buildFormApp() {
  return ProviderScope(
    overrides: [
      parcelFormProvider.overrideWith(_TestParcelFormNotifier.new),
    ],
    child: MaterialApp(
      theme: AppTheme.light(),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: ParcelFormView(),
        ),
      ),
    ),
  );
}

void main() {
  setUp(() {
    _pickedSource = null;
    _nextErrorMessage = null;
  });

  testWidgets('shows image source chooser for parcel image', (tester) async {
    await tester.pumpWidget(_buildFormApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text(ParcelStrings.chooseParcelImageTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(ParcelStrings.chooseParcelImageTitle));
    await tester.pumpAndSettle();

    expect(find.text(ParcelStrings.takePhotoTitle), findsOneWidget);
    expect(find.text(ParcelStrings.chooseFromGalleryTitle), findsOneWidget);
  });

  testWidgets('shows snackbar when image picker reports an error', (
    tester,
  ) async {
    _nextErrorMessage =
        'Could not open the camera. Check camera permission and try again.';

    await tester.pumpWidget(_buildFormApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text(ParcelStrings.chooseParcelImageTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(ParcelStrings.chooseParcelImageTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(ParcelStrings.takePhotoTitle));
    await tester.pump();
    await tester.pump();

    expect(find.text(_nextErrorMessage!), findsOneWidget);
    expect(_pickedSource, ImageSource.camera);
  });
}
