import 'package:flutter/material.dart';
import 'package:globalsportsmarket/screens/player/widget/inputs.dart';

class InjuryHistoryStep extends StatefulWidget {
  const InjuryHistoryStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<InjuryHistoryStep> createState() => _InjuryHistoryStepState();
}

class _InjuryHistoryStepState extends State<InjuryHistoryStep> {
  final _items = <_InjuryItem>[];

  bool get _complete => true; // optional
  void _notify() => widget.onCompleteChanged(_complete);

  void _add() => setState(() => _items.add(_InjuryItem()));
  void _remove(int i) => setState(() => _items.removeAt(i));

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
              'Injury History',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Add injuries if applicable',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),

            for (int i = 0; i < _items.length; i++) ...[
              _InjuryRow(item: _items[i], onRemove: () => _remove(i)),
              const SizedBox(height: 12),
            ],

            OutlinedButton.icon(
              onPressed: _add,
              icon: const Text('➕'),
              label: const Text('Add Injury'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InjuryItem {
  String? type;
  DateTime? date;
  int weeks = 0;
}

class _InjuryRow extends StatefulWidget {
  const _InjuryRow({required this.item, required this.onRemove});
  final _InjuryItem item;
  final VoidCallback onRemove;

  @override
  State<_InjuryRow> createState() => _InjuryRowState();
}

class _InjuryRowState extends State<_InjuryRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EmojiDropdown<String>(
          label: 'Injury Type',
          value: widget.item.type,
          items: const [
            ('🦵', 'ACL Tear', 'acl'),
            ('🦵', 'Hamstring', 'ham'),
            ('🦶', 'Ankle', 'ankle'),
            ('🦴', 'Fracture', 'fracture'),
          ],
          onChanged: (v) => setState(() => widget.item.type = v),
        ),
        const SizedBox(height: 8),
        DateField(
          label: 'Date',
          value: widget.item.date,
          onPick: (v) => setState(() => widget.item.date = v),
        ),
        const SizedBox(height: 8),
        NumberStepper(
          label: 'Recovery (weeks)',
          value: widget.item.weeks,
          onChanged: (v) => setState(() => widget.item.weeks = v),
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: widget.onRemove,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Remove'),
          ),
        ),
      ],
    );
  }
}
