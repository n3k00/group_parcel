import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/section_card.dart';

class ParcelImagePreviewCard extends StatelessWidget {
  const ParcelImagePreviewCard({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Parcel Image', style: AppTextStyles.title),
            const SizedBox(height: AppSpacing.sm),
            InkWell(
              onTap: () => _showImagePreview(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Color(0xFFF2F4F7),
                        child: Center(
                          child: Text(
                            'Image unavailable',
                            style: AppTextStyles.bodyMuted,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Tap to view full image',
              style: AppTextStyles.bodyMuted,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showImagePreview(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              InteractiveViewer(
                child: Center(
                  child: Image.file(File(imagePath), fit: BoxFit.contain),
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
