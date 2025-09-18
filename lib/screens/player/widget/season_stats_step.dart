import 'package:flutter/material.dart';
import 'package:globalsportsmarket/screens/player/widget/inputs.dart';

class SeasonStatsStep extends StatefulWidget {
  const SeasonStatsStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<SeasonStatsStep> createState() => _SeasonStatsStepState();
}

class _SeasonStatsStepState extends State<SeasonStatsStep> {
  int matches = 0, goals = 0, assists = 0, yellow = 0, red = 0;
  bool get _complete => matches >= 0; // always allowed
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
              'Season Stats',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            NumberStepper(
              label: 'Matches Played',
              value: matches,
              onChanged: (v) {
                setState(() => matches = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),
            NumberStepper(
              label: 'Goals Scored',
              value: goals,
              onChanged: (v) {
                setState(() => goals = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),
            NumberStepper(
              label: 'Assists',
              value: assists,
              onChanged: (v) {
                setState(() => assists = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),
            NumberStepper(
              label: 'Yellow Cards',
              value: yellow,
              onChanged: (v) {
                setState(() => yellow = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),
            NumberStepper(
              label: 'Red Cards',
              value: red,
              onChanged: (v) {
                setState(() => red = v);
                _notify();
              },
            ),
          ],
        ),
      ),
    );
  }
}
