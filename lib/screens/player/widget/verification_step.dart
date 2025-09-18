import 'package:flutter/material.dart';

class VerificationStep extends StatefulWidget {
  const VerificationStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<VerificationStep> createState() => _VerificationStepState();
}

class _VerificationStepState extends State<VerificationStep> {
  bool confirm = false;
  bool get _complete => confirm;
  void _notify() => widget.onCompleteChanged(_complete);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notify());
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Verification Documents',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.badge_outlined),
              label: const Text('Upload National Youth ID'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.health_and_safety_outlined),
              label: const Text('Upload Anti-Doping Clearance'),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: confirm,
                  onChanged: (v) => setState(() => confirm = v ?? false),
                ),
                const Expanded(
                  child: Text('I confirm all information is accurate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
