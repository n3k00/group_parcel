import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/parcel_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../providers/printer_provider.dart';
import '../../../sync/presentation/providers/sync_provider.dart';
import '../../../voucher/presentation/models/voucher_preview_args.dart';
import '../../../voucher/presentation/screens/voucher_preview_screen.dart';
import '../providers/parcel_form_provider.dart';

class ParcelNextActionButton extends ConsumerWidget {
  const ParcelNextActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formAsync = ref.watch(parcelFormProvider);
    final printerState = ref.watch(printerStateProvider);
    final syncState = ref.watch(syncProvider);
    final hasCompletedInitialSyncAsync = ref.watch(
      hasCompletedInitialSyncProvider,
    );
    final width = math.max(
      0.0,
      MediaQuery.sizeOf(context).width - (AppSpacing.lg * 2),
    );

    return formAsync.when(
      data: (form) {
        final hasCompletedInitialSync = hasCompletedInitialSyncAsync.maybeWhen(
          data: (value) => value,
          orElse: () => false,
        );
        final isCheckingInitialSync = hasCompletedInitialSyncAsync.isLoading;
        final isBlockedForInitialSync =
            !hasCompletedInitialSync && syncState.isRunning;

        return SizedBox(
          width: width,
          child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(58),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
            ),
            onPressed: isCheckingInitialSync || isBlockedForInitialSync
                ? null
                : () {
                    if (!hasCompletedInitialSync) {
                      unawaited(ref.read(syncProvider.notifier).syncNow());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(ParcelStrings.firstSyncRequiredMessage),
                        ),
                      );
                      return;
                    }

                    final result = ref
                        .read(parcelFormProvider.notifier)
                        .validateForPreview(
                          isPrinterConnected: printerState.isConnected,
                        );

                    if (!result.isValid) {
                      final message =
                          result.printerWarning ??
                          ParcelStrings.fillRequiredFields;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                      return;
                    }

                    Navigator.of(context).pushNamed(
                      VoucherPreviewScreen.routeName,
                      arguments: VoucherPreviewArgs(form: form),
                    );
                  },
            child: Text(
              isBlockedForInitialSync
                  ? ParcelStrings.firstSyncInProgressMessage
                  : ParcelStrings.nextAction,
            ),
          ),
        );
      },
      loading: () => SizedBox(
        width: width,
        child: FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(58),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
          ),
          onPressed: null,
          child: const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (_, _) => SizedBox(
        width: width,
        child: FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(58),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
          ),
          onPressed: null,
          child: const Text(ParcelStrings.nextAction),
        ),
      ),
    );
  }
}
