import 'package:flutter/material.dart';
import 'atoms.dart';

class PricePlanCard extends StatelessWidget {
  const PricePlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    this.highlight = false,
    this.buttonLabel = 'Choose Plan',
  });

  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool highlight;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: highlight ? theme.colorScheme.primaryContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(width: 6),
                Text('/$period', style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 12),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 18),
                      const SizedBox(width: 8),
                      Expanded(child: Text(f)),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            PrimaryButton(label: buttonLabel, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
