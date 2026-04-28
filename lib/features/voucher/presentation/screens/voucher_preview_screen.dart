import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/parcel_strings.dart';
import '../../../../core/constants/voucher_layout.dart';
import '../../../../core/layout/app_responsive.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../providers/parcel_repository_provider.dart';
import '../../../../providers/printer_provider.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../parcel/presentation/screens/home_screen.dart';
import '../../../parcel/presentation/providers/parcel_form_provider.dart';
import '../../../printing/presentation/screens/printer_connect_screen.dart';
import '../models/voucher_preview_args.dart';
import '../providers/voucher_preview_provider.dart';
import '../widgets/parcel_image_preview_card.dart';
import '../widgets/voucher_card.dart';

class VoucherPreviewScreen extends ConsumerStatefulWidget {
  const VoucherPreviewScreen({super.key, required this.args});

  static const routeName = '/voucher/preview';

  final VoucherPreviewArgs args;

  @override
  ConsumerState<VoucherPreviewScreen> createState() =>
      _VoucherPreviewScreenState();
}

class _VoucherPreviewScreenState extends ConsumerState<VoucherPreviewScreen> {
  final GlobalKey _printBoundaryKey = GlobalKey();
  bool _isSaving = false;

  Future<void> _handlePrintAndSave(VoucherPreviewData preview) async {
    if (_isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final printerNotifier = ref.read(printerStateProvider.notifier);
    final printerState = ref.read(printerStateProvider);

    try {
      if (!printerState.isConnected) {
        await Navigator.of(context).pushNamed(PrinterConnectScreen.routeName);
        if (!mounted || !ref.read(printerStateProvider).isConnected) {
          return;
        }
      }

      final parcelId = await ref
          .read(parcelRepositoryProvider)
          .createParcel(preview.parcel);
      if (!mounted) {
        return;
      }

      final imageBytes = await ref
          .read(printServiceProvider)
          .captureWidgetAsPng(_printBoundaryKey);
      final success = await printerNotifier.printImageBytes(imageBytes);

      if (!mounted) {
        return;
      }

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(printerStateProvider).errorMessage ??
                  'Parcel #$parcelId ${ParcelStrings.reprintFromHistoryMessage}',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Parcel #$parcelId ${ParcelStrings.printedAndSavedMessage}',
            ),
          ),
        );
      }

      await ref.read(parcelFormProvider.notifier).reset();
      if (!mounted) {
        return;
      }
      Navigator.of(context).popUntil((route) {
        return route.settings.name == HomeScreen.routeName || route.isFirst;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_messageForSaveError(error))),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  String _messageForSaveError(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('unique') && message.contains('tracking_id')) {
      return ParcelStrings.duplicateTrackingIdMessage;
    }
    if (message.contains('number_of_parcels')) {
      return ParcelStrings.invalidParcelCountMessage;
    }
    if (message.contains('total_charges')) {
      return ParcelStrings.invalidTotalChargesMessage;
    }
    if (message.contains('cash_advance')) {
      return ParcelStrings.invalidCashAdvanceMessage;
    }
    return ParcelStrings.parcelSaveFailedMessage;
  }

  @override
  Widget build(BuildContext context) {
    final previewAsync = ref.watch(voucherPreviewProvider(widget.args));
    final printerState = ref.watch(printerStateProvider);
    final isProcessing =
        previewAsync.isLoading || printerState.isBusy || _isSaving;

    return AppScaffold(
      title: ParcelStrings.voucherPreviewTitle,
      isBlocking: _isSaving || printerState.isBusy,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          final buttonWidth = math.min(
            AppResponsive.centeredContentWidth(
              context,
              horizontalPadding: AppSpacing.lg,
            ),
            720.0,
          );
          return SizedBox(
            width: buttonWidth,
            child: FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(58),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
              ),
              onPressed: isProcessing
                  ? null
                  : () {
                      final preview = previewAsync.asData?.value;
                      if (preview != null) {
                        _handlePrintAndSave(preview);
                      }
                    },
              child: const Text(ParcelStrings.printAndSaveAction),
            ),
          );
        },
      ),
      body: previewAsync.when(
        data: (preview) => LayoutBuilder(
          builder: (context, constraints) {
            final previewWidth = math.min(
              AppResponsive.centeredContentWidth(
                context,
                horizontalPadding: AppSpacing.lg,
              ),
              VoucherLayout.previewPaperWidth,
            );
            return ListView(
              padding: AppSpacing.screenPadding,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: previewWidth,
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                      child: RepaintBoundary(
                        key: _printBoundaryKey,
                        child: VoucherCard(
                          parcel: preview.parcel,
                          qrPayload: preview.qrPayload,
                          setup: preview.setup,
                          isPrintable: true,
                        ),
                      ),
                    ),
                  ),
                ),
                if ((preview.parcel.parcelImagePath ?? '').isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  ParcelImagePreviewCard(
                    imagePath: preview.parcel.parcelImagePath!,
                  ),
                ],
                const SizedBox(height: 104),
              ],
            );
          },
        ),
        loading: () => const Padding(
          padding: AppSpacing.screenPadding,
          child: AppLoading(),
        ),
        error: (error, _) => Padding(
          padding: AppSpacing.screenPadding,
          child: AppErrorView(message: error.toString()),
        ),
      ),
    );
  }
}
