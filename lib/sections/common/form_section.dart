import 'package:flutter/material.dart';
import '../../widgets/atoms.dart';
import '../../widgets/atoms.dart' show PrimaryButton, SecondaryButton;

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    required this.title,
    required this.fields,
    this.subtitle,
    this.onSave,
    this.onCancel,
    this.actionLabel = 'Save & Continue',
  });

  final String title;
  final String? subtitle;
  final List<Widget> fields;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            ],
            const SizedBox(height: 16),
            ...[for (final f in fields) ...[f, const SizedBox(height: 12)]],
            const SizedBox(height: 8),
            Row(
              children: [
                SecondaryButton(label: 'Cancel', onPressed: onCancel),
                const SizedBox(width: 12),
                Expanded(child: PrimaryButton(label: actionLabel, onPressed: onSave)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
