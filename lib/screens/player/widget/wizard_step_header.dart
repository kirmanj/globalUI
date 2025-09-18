import 'package:flutter/material.dart';
import '../../../../../theme/app_theme.dart';

class WizardStepHeader extends StatelessWidget {
  const WizardStepHeader({
    super.key,
    required this.stepText,
    required this.tabs,
    required this.activeIndex,
    required this.progress,
    this.onTapTab,
  });

  final String stepText;
  final List<String> tabs;
  final int activeIndex;
  final double progress;
  final ValueChanged<int>? onTapTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pct = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top line + percent
        Row(
          children: [
            Text(
              stepText,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Text('$pct%', style: theme.textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: 8),

        // Gradient progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: 8,
            child: Stack(
              children: [
                Container(color: theme.colorScheme.surfaceVariant),
                FractionallySizedBox(
                  widthFactor: progress.clamp(0, 1),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(gradient: AppGradients.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Step pills (tap to navigate back / revisit)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (int i = 0; i < tabs.length; i++)
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: onTapTab == null ? null : () => onTapTab!(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color:
                        i == activeIndex
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color:
                          i == activeIndex
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant,
                      width: i == activeIndex ? 1.5 : 1,
                    ),
                  ),
                  child: Text(
                    tabs[i],
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
