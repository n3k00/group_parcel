import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/parcel_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../providers/printer_provider.dart';
import '../../../voucher/presentation/models/voucher_preview_args.dart';
import '../../../voucher/presentation/screens/voucher_preview_screen.dart';
import '../providers/parcel_form_provider.dart';

class ParcelNextActionButton extends ConsumerWidget {
  const ParcelNextActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formAsync = ref.watch(parcelFormProvider);
    final printerState = ref.watch(printerStateProvider);
    final width = math.max(
      0.0,
      MediaQuery.sizeOf(context).width - (AppSpacing.lg * 2),
    );

    return formAsync.when(
      data: (form) => SizedBox(
        width: width,
        child: FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(58),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
          ),
          onPressed: () {
            final result = ref
                .read(parcelFormProvider.notifier)
                .validateForPreview(
                  isPrinterConnected: printerState.isConnected,
                );

            if (!result.isValid) {
              final message =
                  result.printerWarning ?? ParcelStrings.fillRequiredFields;
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
          child: const Text(ParcelStrings.nextAction),
        ),
      ),
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
