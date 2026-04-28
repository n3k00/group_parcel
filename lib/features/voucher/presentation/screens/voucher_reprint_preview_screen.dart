import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/voucher_layout.dart';
import '../../../../core/layout/app_responsive.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../providers/printer_provider.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../parcel/presentation/screens/parcel_list_screen.dart';
import '../../../printing/presentation/screens/printer_connect_screen.dart';
import '../providers/voucher_preview_provider.dart';
import '../widgets/parcel_image_preview_card.dart';
import '../widgets/voucher_card.dart';

class VoucherReprintPreviewScreen extends ConsumerStatefulWidget {
  const VoucherReprintPreviewScreen({super.key, required this.parcelId});

  static const routeName = '/voucher/reprint';

  final int parcelId;

  @override
  ConsumerState<VoucherReprintPreviewScreen> createState() =>
      _VoucherReprintPreviewScreenState();
}

class _VoucherReprintPreviewScreenState
    extends ConsumerState<VoucherReprintPreviewScreen> {
  final GlobalKey _printBoundaryKey = GlobalKey();
  bool _isReprinting = false;

  Future<void> _handleReprint(VoucherPreviewData preview) async {
    if (_isReprinting) {
      return;
    }

    setState(() {
      _isReprinting = true;
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
                  'Voucher print failed.',
            ),
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Voucher reprinted successfully.'),
        ),
      );
      Navigator.of(context).popUntil((route) {
        return route.settings.name == ParcelListScreen.routeName || route.isFirst;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isReprinting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final previewAsync = ref.watch(
      voucherReprintPreviewProvider(widget.parcelId),
    );
    final printerState = ref.watch(printerStateProvider);
    final isProcessing =
        previewAsync.isLoading || printerState.isBusy || _isReprinting;

    return AppScaffold(
      title: 'Reprint Voucher',
      isBlocking: _isReprinting || printerState.isBusy,
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
                        _handleReprint(preview);
                      }
                    },
              child: const Text('Reprint'),
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
                if (printerState.errorMessage != null &&
                    printerState.lastPrintableImageBytes != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  OutlinedButton(
                    onPressed: isProcessing
                        ? null
                        : () => ref
                              .read(printerStateProvider.notifier)
                              .retryLastPrint(),
                    child: const Text('Retry Print'),
                  ),
                ],
                if (printerState.lastPrintableImageBytes != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: isProcessing
                        ? null
                        : () => ref
                              .read(printerStateProvider.notifier)
                              .reprintLastVoucher(),
                    child: const Text('Reprint Last Voucher'),
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
