import 'package:flutter/material.dart';
import 'package:globalsportsmarket/screens/player/widget/inputs.dart';

class ContractAgentStep extends StatefulWidget {
  const ContractAgentStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<ContractAgentStep> createState() => _ContractAgentStepState();
}

class _ContractAgentStepState extends State<ContractAgentStep> {
  final _priceCtrl = TextEditingController();
  String? _country;
  String? _contactMode; // direct / agent

  bool get _complete => _country != null && _contactMode != null;
  void _notify() => widget.onCompleteChanged(_complete);

  @override
  void initState() {
    super.initState();
    _priceCtrl.addListener(_notify);
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    super.dispose();
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
              'Contract & Agent',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Estimated Price/Salary',
                hintText: 'e.g., 90000',
              ),
            ),
            const SizedBox(height: 12),

            EmojiDropdown<String>(
              label: 'Country',
              value: _country,
              items: const [
                ('🇮🇶', 'Iraq', 'IQ'),
                ('🇸🇦', 'Saudi Arabia', 'SA'),
                ('🇹🇷', 'Turkey', 'TR'),
                ('🇬🇧', 'United Kingdom', 'GB'),
              ],
              onChanged: (v) {
                setState(() => _country = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),

            Segmented<String>(
              label: 'Contact Allowed',
              value: _contactMode,
              options: const [
                ('📞', 'Direct', 'direct'),
                ('🧑‍💼', 'Via Agent', 'agent'),
              ],
              onChanged: (v) {
                setState(() => _contactMode = v);
                _notify();
              },
            ),
          ],
        ),
      ),
    );
  }
}
