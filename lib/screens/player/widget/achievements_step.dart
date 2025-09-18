import 'package:flutter/material.dart';
import 'package:globalsportsmarket/screens/player/widget/inputs.dart';

class AchievementsStep extends StatefulWidget {
  const AchievementsStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<AchievementsStep> createState() => _AchievementsStepState();
}

class _AchievementsStepState extends State<AchievementsStep> {
  int trophies = 0;
  final _awards = <String>[];
  final _awardCtrl = TextEditingController();

  bool get _complete => true;
  void _notify() => widget.onCompleteChanged(_complete);

  void _addAward() {
    final t = _awardCtrl.text.trim();
    if (t.isNotEmpty)
      setState(() {
        _awards.add(t);
        _awardCtrl.clear();
      });
  }

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
              'Career Achievements',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            NumberStepper(
              label: 'Total Trophies',
              value: trophies,
              onChanged: (v) => setState(() => trophies = v),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _awardCtrl,
              decoration: const InputDecoration(
                labelText: 'Add Award (optional)',
                hintText: 'e.g., Golden Boot 2023',
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                onPressed: _addAward,
                icon: const Text('🏆'),
                label: const Text('Add'),
              ),
            ),
            const SizedBox(height: 8),

            if (_awards.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    _awards.map((a) => Chip(label: Text('🏆 $a'))).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
