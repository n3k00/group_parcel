import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/parcel_strings.dart';
import '../../../../core/constants/receipt_strings.dart';
import '../../../../core/layout/app_responsive.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_input_decoration.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/enums/payment_status.dart';
import '../constants/parcel_form_dimens.dart';
import '../providers/parcel_form_provider.dart';

class ParcelFormView extends ConsumerStatefulWidget {
  const ParcelFormView({super.key});

  @override
  ConsumerState<ParcelFormView> createState() => _ParcelFormViewState();
}

class _ParcelFormViewState extends ConsumerState<ParcelFormView> {
  late final ProviderSubscription<AsyncValue<ParcelFormState>>
  _formSubscription;

  @override
  void initState() {
    super.initState();
    _formSubscription = ref.listenManual<AsyncValue<ParcelFormState>>(
      parcelFormProvider,
      (previous, next) {
        final previousMessage = _errorMessageOf(previous);
        final message = _errorMessageOf(next);
        if (!mounted || message == null || message.isEmpty) {
          return;
        }
        if (message == previousMessage) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        ref.read(parcelFormProvider.notifier).clearErrorMessage();
      },
    );
  }

  @override
  void dispose() {
    _formSubscription.close();
    super.dispose();
  }

  String? _errorMessageOf(AsyncValue<ParcelFormState>? value) {
    if (value is AsyncData<ParcelFormState>) {
      return value.value.errorMessage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ref = this.ref;
    final formAsync = ref.watch(parcelFormProvider);
    final controller = ref.read(parcelFormProvider.notifier);

    return formAsync.when(
      data: (form) => LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < AppBreakpoints.compact;
          final formGap = isCompact ? AppSpacing.md : AppSpacing.lg;

          return KeyedSubtree(
            key: ValueKey(form.formVersion),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FormSection(
                  child: _AdaptiveTwoColumn(
                    isCompact: isCompact,
                    left: _TownDropdown(
                      value: form.fromTown.isEmpty ? null : form.fromTown,
                      towns: form.sourceTownOptions
                          .map((town) => town.townName)
                          .toList(),
                      label: ParcelStrings.fromTownLabel,
                      hint: ParcelStrings.fromTownHint,
                      icon: Icons.location_on_outlined,
                      errorText: form.fieldErrors['fromTown'],
                      onChanged: controller.updateFromTown,
                    ),
                    right: _TownDropdown(
                      value: form.toTown.isEmpty ? null : form.toTown,
                      towns: form.destinationTownOptions
                          .map((town) => town.townName)
                          .toList(),
                      label: ParcelStrings.toTownLabel,
                      hint: ParcelStrings.toTownHint,
                      icon: Icons.flag_outlined,
                      errorText: form.fieldErrors['toTown'],
                      onChanged: controller.updateToTown,
                    ),
                  ),
                ),
                SizedBox(height: formGap),
                _FormSection(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: form.senderName,
                        onChanged: controller.updateSenderName,
                        decoration: AppInputDecoration.basic(
                          label: ParcelStrings.senderNameLabel,
                          hint: ParcelStrings.senderNameHint,
                          prefixIcon: const Icon(Icons.person_outline),
                        ).copyWith(errorText: form.fieldErrors['senderName']),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextFormField(
                        initialValue: form.senderPhone,
                        onChanged: controller.updateSenderPhone,
                        keyboardType: TextInputType.phone,
                        decoration: AppInputDecoration.basic(
                          label: ParcelStrings.senderPhoneLabel,
                          hint: ParcelStrings.senderPhoneHint,
                          prefixIcon: const Icon(Icons.call_outlined),
                        ).copyWith(errorText: form.fieldErrors['senderPhone']),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextFormField(
                        initialValue: form.receiverName,
                        onChanged: controller.updateReceiverName,
                        decoration: AppInputDecoration.basic(
                          label: ParcelStrings.receiverNameLabel,
                          hint: ParcelStrings.receiverNameHint,
                          prefixIcon: const Icon(Icons.person_2_outlined),
                        ).copyWith(errorText: form.fieldErrors['receiverName']),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextFormField(
                        initialValue: form.receiverPhone,
                        onChanged: controller.updateReceiverPhone,
                        keyboardType: TextInputType.phone,
                        decoration: AppInputDecoration.basic(
                          label: ParcelStrings.receiverPhoneLabel,
                          hint: ParcelStrings.receiverPhoneHint,
                          prefixIcon: const Icon(Icons.phone_in_talk_outlined),
                        ).copyWith(errorText: form.fieldErrors['receiverPhone']),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: formGap),
                _FormSection(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: form.parcelType,
                        onChanged: controller.updateParcelType,
                        decoration: AppInputDecoration.basic(
                          label: ParcelStrings.parcelTypeLabel,
                          hint: ParcelStrings.parcelTypeHint,
                          prefixIcon: const Icon(Icons.widgets_outlined),
                        ).copyWith(errorText: form.fieldErrors['parcelType']),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _AdaptiveTwoColumn(
                        isCompact: isCompact,
                        left: TextFormField(
                          initialValue: form.numberOfParcelsText,
                          keyboardType: TextInputType.number,
                          onChanged: controller.updateNumberOfParcels,
                          decoration: AppInputDecoration.basic(
                            label: ParcelStrings.numberOfParcelsLabel,
                            hint: ParcelStrings.numberOfParcelsHint,
                            prefixIcon: const Icon(
                              Icons.format_list_numbered_rounded,
                            ),
                          ).copyWith(
                            errorText: form.fieldErrors['numberOfParcels'],
                          ),
                        ),
                        right: TextFormField(
                          initialValue: form.totalCharges == 0
                              ? ''
                              : form.totalCharges.toStringAsFixed(
                                  form.totalCharges.truncateToDouble() ==
                                          form.totalCharges
                                      ? 0
                                      : 2,
                                ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (value) {
                            controller.updateTotalCharges(
                              double.tryParse(value) ?? 0,
                            );
                          },
                          decoration: AppInputDecoration.basic(
                            label: ParcelStrings.totalChargesLabel,
                            hint: ParcelStrings.totalChargesHint,
                            prefixIcon: const Icon(Icons.attach_money_rounded),
                          ).copyWith(
                            errorText: form.fieldErrors['totalCharges'],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _AdaptiveTwoColumn(
                        isCompact: isCompact,
                        left: _PaymentStatusField(
                          value: form.paymentStatus,
                          onChanged: controller.updatePaymentStatus,
                        ),
                        right: TextFormField(
                          initialValue: form.cashAdvance == 0
                              ? ''
                              : form.cashAdvance.toStringAsFixed(
                                  form.cashAdvance.truncateToDouble() ==
                                          form.cashAdvance
                                      ? 0
                                      : 2,
                                ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (value) {
                            controller.updateCashAdvance(
                              double.tryParse(value) ?? 0,
                            );
                          },
                          decoration: AppInputDecoration.basic(
                            label: ParcelStrings.cashAdvanceLabel,
                            hint: ParcelStrings.cashAdvanceHint,
                            prefixIcon: const Icon(
                              Icons.money_off_csred_outlined,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextFormField(
                        initialValue: form.remark,
                        onChanged: controller.updateRemark,
                        maxLines: 3,
                        decoration: AppInputDecoration.basic(
                          label: ParcelStrings.noteLabel,
                          hint: ParcelStrings.noteHint,
                          prefixIcon: const Icon(Icons.sticky_note_2_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: formGap),
                _FormSection(
                  child: _ParcelImageField(
                    imagePath: form.parcelImagePath,
                    onPickImage: (source) {
                      controller.pickParcelImage(source: source);
                    },
                    onClearImage: controller.clearParcelImage,
                    height: isCompact
                        ? ParcelFormDimens.compactImageHeight
                        : ParcelFormDimens.expandedImageHeight,
                  ),
                ),
                const SizedBox(height: ParcelFormDimens.bottomActionClearance),
              ],
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.extraLarge,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: AppDimens.cardShadowBlur,
            offset: Offset(0, AppDimens.cardShadowOffsetY),
          ),
        ],
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );
  }
}

class _ParcelImageField extends StatelessWidget {
  const _ParcelImageField({
    required this.imagePath,
    required this.onPickImage,
    required this.onClearImage,
    required this.height,
  });

  final String? imagePath;
  final ValueChanged<ImageSource> onPickImage;
  final VoidCallback onClearImage;
  final double height;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    final imageFile = hasImage ? File(imagePath!) : null;

    return InkWell(
      borderRadius: AppRadius.medium,
      onTap: hasImage ? () => _showImagePreview(context) : () => _chooseImageSource(context),
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppRadius.medium,
          border: Border.all(color: AppColors.inputBorder),
        ),
        clipBehavior: Clip.antiAlias,
        child: hasImage && imageFile != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    errorBuilder: (context, error, stackTrace) =>
                        const _ImagePlaceholder(),
                  ),
                  _buildImageActions(context),
                ],
              )
            : const _ImagePlaceholder(),
      ),
    );
  }

  Widget _buildImageActions(BuildContext context) {
    return Positioned(
      top: AppSpacing.sm,
      right: AppSpacing.sm,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ImageActionButton(
            icon: Icons.edit_outlined,
            onTap: () => _chooseImageSource(context),
          ),
          const SizedBox(width: AppSpacing.xs),
          _ImageActionButton(
            icon: Icons.delete_outline_rounded,
            onTap: onClearImage,
          ),
        ],
      ),
    );
  }

  Future<void> _chooseImageSource(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text(ParcelStrings.takePhotoTitle),
                subtitle: const Text(ParcelStrings.takePhotoSubtitle),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text(ParcelStrings.chooseFromGalleryTitle),
                subtitle: const Text(ParcelStrings.chooseFromGallerySubtitle),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      onPickImage(source);
    }
  }

  Future<void> _showImagePreview(BuildContext context) async {
    if (imagePath == null) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              InteractiveViewer(
                child: Center(
                  child: Image.file(File(imagePath!), fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: AppSpacing.lg,
                right: AppSpacing.lg,
                child: IconButton.filledTonal(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppSpacing.cardPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo_outlined,
            size: AppDimens.iconXl,
            color: AppColors.iconSecondary,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            ParcelStrings.chooseParcelImageTitle,
            style: AppTextStyles.subtitle,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            ParcelStrings.chooseParcelImageHint,
            style: AppTextStyles.bodyMuted,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ImageActionButton extends StatelessWidget {
  const _ImageActionButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      borderRadius: AppRadius.roundedPill,
      child: InkWell(
        borderRadius: AppRadius.roundedPill,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Icon(icon, color: Colors.white, size: AppDimens.iconSm),
        ),
      ),
    );
  }
}

class _TownDropdown extends StatelessWidget {
  const _TownDropdown({
    required this.value,
    required this.towns,
    required this.label,
    required this.hint,
    required this.icon,
    this.errorText,
    required this.onChanged,
  });

  final String? value;
  final List<String> towns;
  final String label;
  final String hint;
  final IconData icon;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppRadius.medium,
      onTap: () => _openTownPicker(context),
      child: InputDecorator(
        isEmpty: value == null || value!.isEmpty,
        decoration: AppInputDecoration.basic(
          label: label,
          hint: hint,
          prefixIcon: Icon(icon),
        ).copyWith(
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          errorText: errorText,
        ),
        child: Text(
          value?.isNotEmpty == true ? value! : hint,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: value?.isNotEmpty == true
              ? AppTextStyles.body
              : AppTextStyles.bodyMuted,
        ),
      ),
    );
  }

  Future<void> _openTownPicker(BuildContext context) async {
    final selectedTown = await _showPickerSheet<String>(
      context,
      title: label,
      selectedValue: value,
      options: towns,
      itemLabelBuilder: (town) => town,
    );

    if (selectedTown != null) {
      onChanged(selectedTown);
    }
  }
}

class _PaymentStatusField extends StatelessWidget {
  const _PaymentStatusField({
    required this.value,
    required this.onChanged,
  });

  final PaymentStatus value;
  final ValueChanged<PaymentStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppRadius.medium,
      onTap: () => _openPicker(context),
      child: InputDecorator(
        decoration: AppInputDecoration.basic(
          label: ParcelStrings.paymentStatusTitle,
          hint: ParcelStrings.paymentStatusHint,
          prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
        ).copyWith(
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        child: Text(_labelFor(value), style: AppTextStyles.body),
      ),
    );
  }

  Future<void> _openPicker(BuildContext context) async {
    final selected = await _showPickerSheet<PaymentStatus>(
      context,
      title: ParcelStrings.paymentStatusTitle,
      selectedValue: value,
      options: PaymentStatus.values,
      itemLabelBuilder: _labelFor,
    );

    if (selected != null) {
      onChanged(selected);
    }
  }

  static String _labelFor(PaymentStatus status) {
    return status.receiptLabel;
  }
}

Future<T?> _showPickerSheet<T>(
  BuildContext context, {
  required String title,
  required T? selectedValue,
  required List<T> options,
  required String Function(T option) itemLabelBuilder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
    ),
    builder: (context) {
      final maxSheetWidth = AppResponsive.centeredContentWidth(
        context,
        horizontalPadding: AppSpacing.lg,
      );

      return SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxSheetWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.subtitle),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(ParcelStrings.selectOneOption,
                          style: AppTextStyles.bodyMuted),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: options.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.xs),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return _PickerTile<T>(
                        option: option,
                        selected: option == selectedValue,
                        itemLabelBuilder: itemLabelBuilder,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _PickerTile<T> extends StatelessWidget {
  const _PickerTile({
    required this.option,
    required this.selected,
    required this.itemLabelBuilder,
  });

  final T option;
  final bool selected;
  final String Function(T option) itemLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.sectionBackground : Colors.transparent,
      borderRadius: AppRadius.medium,
      child: ListTile(
        dense: true,
        minTileHeight: AppDimens.listTileMinHeight,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.medium,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        title: Text(
          itemLabelBuilder(option),
          style: selected ? AppTextStyles.label : AppTextStyles.body,
        ),
        trailing: selected
            ? const Icon(
                Icons.check_circle_rounded,
                color: AppColors.secondary,
              )
            : null,
        onTap: () => Navigator.of(context).pop(option),
      ),
    );
  }
}

class _AdaptiveTwoColumn extends StatelessWidget {
  const _AdaptiveTwoColumn({
    required this.isCompact,
    required this.left,
    required this.right,
  });

  final bool isCompact;
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Column(
        children: [
          left,
          const SizedBox(height: AppSpacing.md),
          right,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: right),
      ],
    );
  }
}

