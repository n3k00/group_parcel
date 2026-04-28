import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/receipt_strings.dart';
import '../../../../core/constants/voucher_layout.dart';
import '../../../../core/layout/app_responsive.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/enums/payment_status.dart';
import '../../../../data/models/parcel.dart';
import '../../../../shared/models/app_setup_config.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/section_card.dart';
import '../../../voucher/presentation/widgets/voucher_card.dart';
import '../constants/receipt_settings_dimens.dart';
import '../providers/settings_provider.dart';

class ReceiptSettingsScreen extends ConsumerStatefulWidget {
  const ReceiptSettingsScreen({super.key});

  static const routeName = '/settings/receipt';

  @override
  ConsumerState<ReceiptSettingsScreen> createState() =>
      _ReceiptSettingsScreenState();
}

class _ReceiptSettingsScreenState extends ConsumerState<ReceiptSettingsScreen> {
  AppSetupConfig? _draft;

  @override
  Widget build(BuildContext context) {
    final setupAsync = ref.watch(settingsSetupProvider);

    return AppScaffold(
      title: AppStrings.receiptSettingsTitle,
      body: setupAsync.when(
        data: (setup) {
          _draft ??= setup;
          final draft = _draft!;
          final sampleParcel = ParcelModel.create(
            trackingId: ReceiptStrings.sampleTrackingId,
            fromTown: ReceiptStrings.sampleFromTown,
            toTown: ReceiptStrings.sampleToTown,
            cityCode: 'TGI',
            accountCode: 'A1',
            senderName: ReceiptStrings.sampleSenderName,
            senderPhone: ReceiptStrings.sampleSenderPhone,
            receiverName: ReceiptStrings.sampleReceiverName,
            receiverPhone: ReceiptStrings.sampleReceiverPhone,
            parcelType: ReceiptStrings.sampleParcelType,
            numberOfParcels: 255,
            totalCharges: 5586,
            paymentStatus: PaymentStatus.unpaid,
            cashAdvance: 5,
            now: DateTime(2026, 3, 19, 18, 23),
          );

          return LayoutBuilder(
            builder: (context, constraints) {
              final isExpanded = constraints.maxWidth >= AppBreakpoints.medium;
              final contentWidth = AppResponsive.centeredContentWidth(
                context,
                horizontalPadding: AppSpacing.lg,
              );

              final controlCards = [
                _SettingsSection(
                  title: AppStrings.headerFontSizeTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SliderField(
                        label: AppStrings.titleLabel,
                        value: draft.businessNameFontSize,
                        min: ReceiptSettingsDimens.titleFontMin,
                        max: ReceiptSettingsDimens.titleFontMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(businessNameFontSize: value);
                        }),
                      ),
                      _SliderField(
                        label: AppStrings.subtitleLabel,
                        value: draft.businessSubtitleFontSize,
                        min: ReceiptSettingsDimens.subtitleFontMin,
                        max: ReceiptSettingsDimens.subtitleFontMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(
                            businessSubtitleFontSize: value,
                          );
                        }),
                      ),
                      _SliderField(
                        label: AppStrings.addressLabel,
                        value: draft.businessAddressFontSize,
                        min: ReceiptSettingsDimens.addressFontMin,
                        max: ReceiptSettingsDimens.addressFontMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(
                            businessAddressFontSize: value,
                          );
                        }),
                      ),
                      _SliderField(
                        label: AppStrings.phoneLabel,
                        value: draft.businessPhoneFontSize,
                        min: ReceiptSettingsDimens.phoneFontMin,
                        max: ReceiptSettingsDimens.phoneFontMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(businessPhoneFontSize: value);
                        }),
                      ),
                    ],
                  ),
                ),
                _SettingsSection(
                  title: AppStrings.bodyFontSizeTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SliderField(
                        label: AppStrings.labelLabel,
                        value: draft.receiptLabelFontSize,
                        min: ReceiptSettingsDimens.labelFontMin,
                        max: ReceiptSettingsDimens.labelFontMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(receiptLabelFontSize: value);
                        }),
                      ),
                      _SliderField(
                        label: AppStrings.valueLabel,
                        value: draft.receiptValueFontSize,
                        min: ReceiptSettingsDimens.valueFontMin,
                        max: ReceiptSettingsDimens.valueFontMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(receiptValueFontSize: value);
                        }),
                      ),
                    ],
                  ),
                ),
                _SettingsSection(
                  title: AppStrings.receiptPaddingTitle,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SliderField(
                        label: AppStrings.topLabel,
                        value: draft.receiptPaddingTop,
                        min: ReceiptSettingsDimens.receiptTopPaddingMin,
                        max: ReceiptSettingsDimens.receiptTopPaddingMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(receiptPaddingTop: value);
                        }),
                      ),
                      _SliderField(
                        label: AppStrings.horizontalLabel,
                        value: draft.receiptPaddingLeft,
                        min: ReceiptSettingsDimens.receiptHorizontalPaddingMin,
                        max: ReceiptSettingsDimens.receiptHorizontalPaddingMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(
                            receiptPaddingLeft: value,
                            receiptPaddingRight: value,
                          );
                        }),
                      ),
                      _SliderField(
                        label: AppStrings.bottomLabel,
                        value: draft.receiptPaddingBottom,
                        min: ReceiptSettingsDimens.receiptBottomPaddingMin,
                        max: ReceiptSettingsDimens.receiptBottomPaddingMax,
                        onChanged: (value) => setState(() {
                          _draft = draft.copyWith(receiptPaddingBottom: value);
                        }),
                      ),
                    ],
                  ),
                ),
              ];

              return Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: contentWidth,
                  child: ListView(
                    padding: AppSpacing.screenPadding,
                    children: [
                      _SettingsSection(
                        title: AppStrings.livePreviewTitle,
                        child: LayoutBuilder(
                          builder: (context, previewConstraints) {
                            final previewWidth = math.min(
                              previewConstraints.maxWidth,
                              VoucherLayout.previewPaperWidth,
                            );
                            return Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: previewWidth),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topCenter,
                                  child: VoucherCard(
                                    parcel: sampleParcel,
                                    qrPayload: ReceiptStrings.sampleQrPayload,
                                    setup: draft,
                                    isPrintable: true,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if (isExpanded)
                        Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.md,
                          children: controlCards
                              .map(
                                (card) => SizedBox(
                                  width: (contentWidth - AppSpacing.md) / 2,
                                  child: card,
                                ),
                              )
                              .toList(),
                        )
                      else
                        ...controlCards.expand(
                          (card) => [card, const SizedBox(height: AppSpacing.md)],
                        ),
                      const SizedBox(height: AppSpacing.md),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final messenger = ScaffoldMessenger.of(context);
                            await ref
                                .read(settingsSetupProvider.notifier)
                                .saveSetup(draft);
                            if (!mounted) {
                              return;
                            }
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text(AppStrings.receiptSettingsSaved),
                              ),
                            );
                          },
                          child: const Text(AppStrings.saveReceiptSettings),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: AppLoading.new,
        error: (error, _) => AppErrorView(message: error.toString()),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.sm),
            child,
          ],
        ),
      ),
    );
  }
}

class _SliderField extends StatelessWidget {
  const _SliderField({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(min, max).toDouble();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyles.label)),
              Text(clampedValue.toStringAsFixed(0), style: AppTextStyles.body),
            ],
          ),
          Slider(
            value: clampedValue,
            min: min,
            max: max,
            divisions: (max - min).round(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
