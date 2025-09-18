import 'package:flutter/material.dart';
import 'package:globalsportsmarket/screens/player/widget/inputs.dart';

class FootballInfoStep extends StatefulWidget {
  const FootballInfoStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<FootballInfoStep> createState() => _FootballInfoStepState();
}

class _FootballInfoStepState extends State<FootballInfoStep> {
  Set<String> _positions = {};
  String? _foot;
  int _height = 175;
  int _weight = 70;

  bool get _complete =>
      _positions.isNotEmpty && _foot != null && _height > 0 && _weight > 0;
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
              'Football Information',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            MultiChip<String>(
              label: 'Preferred Positions',
              options: const [
                ('🎯', 'Striker', 'ST'),
                ('🪽', 'Left Wing', 'LW'),
                ('🪽', 'Right Wing', 'RW'),
                ('🧠', 'Attacking Mid', 'CAM'),
                ('🛡️', 'Defensive Mid', 'CDM'),
                ('🪨', 'Center Back', 'CB'),
                ('🧤', 'Goalkeeper', 'GK'),
              ],
              onChanged: (v) {
                setState(() => _positions = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),

            Segmented<String>(
              label: 'Preferred Foot',
              value: _foot,
              options: const [
                ('🦶', 'Left', 'L'),
                ('🦶', 'Right', 'R'),
                ('🦶', 'Both', 'B'),
              ],
              onChanged: (v) {
                setState(() => _foot = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),

            NumberStepper(
              label: 'Height (cm)',
              value: _height,
              onChanged: (v) {
                setState(() => _height = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),
            NumberStepper(
              label: 'Weight (kg)',
              value: _weight,
              onChanged: (v) {
                setState(() => _weight = v);
                _notify();
              },
            ),
          ],
        ),
      ),
    );
  }
}
