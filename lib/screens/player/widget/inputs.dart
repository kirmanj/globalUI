import 'package:flutter/material.dart';

/// Single-select “segmented” control using ChoiceChips (low typing).
class Segmented<T> extends StatelessWidget {
  const Segmented({
    super.key,
    required this.label,
    required this.options, // [(emoji, text, value)]
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<(String, String, T)> options;
  final T? value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              options.map((o) {
                final selected = value == o.$3;
                return ChoiceChip(
                  selected: selected,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(o.$1),
                      const SizedBox(width: 6),
                      Text(o.$2),
                    ],
                  ),
                  onSelected: (_) => onChanged(o.$3),
                );
              }).toList(),
        ),
      ],
    );
  }
}

/// Multi-select chips (with emojis).
class MultiChip<T> extends StatefulWidget {
  const MultiChip({
    super.key,
    required this.label,
    required this.options, // [(emoji, text, value)]
    this.initial = const {},
    required this.onChanged,
  });

  final String label;
  final List<(String, String, T)> options;
  final Set<T> initial;
  final ValueChanged<Set<T>> onChanged;

  @override
  State<MultiChip<T>> createState() => _MultiChipState<T>();
}

class _MultiChipState<T> extends State<MultiChip<T>> {
  late Set<T> _sel = {...widget.initial};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              widget.options.map((o) {
                final selected = _sel.contains(o.$3);
                return FilterChip(
                  selected: selected,
                  onSelected: (v) {
                    setState(() => v ? _sel.add(o.$3) : _sel.remove(o.$3));
                    widget.onChanged(_sel);
                  },
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(o.$1),
                      const SizedBox(width: 6),
                      Text(o.$2),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

/// Emoji dropdown (flag/sport icons + text).
class EmojiDropdown<T> extends StatelessWidget {
  const EmojiDropdown({
    super.key,
    required this.label,
    required this.items, // [(emoji, text, value)]
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<(String, String, T)> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: radius),
          ),
          items:
              items.map((e) {
                return DropdownMenuItem<T>(
                  value: e.$3,
                  child: Row(
                    children: [
                      Text(e.$1, style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(e.$2)),
                    ],
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

/// Stepper for integers (stats, counts).
class NumberStepper extends StatelessWidget {
  const NumberStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 999,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final int min, max;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: value > min ? () => onChanged(value - 1) : null,
                icon: const Icon(Icons.remove_rounded),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '$value',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: value < max ? () => onChanged(value + 1) : null,
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Date picker field (DD/MM/YYYY).
class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onPick,
  });
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onPick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(12);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final now = DateTime.now();
            final picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime(now.year - 18, 1, 1),
              firstDate: DateTime(1960),
              lastDate: DateTime(now.year - 5),
            );
            onPick(picked);
          },
          borderRadius: radius,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              borderRadius: radius,
            ),
            child: Text(
              value == null
                  ? 'Select date'
                  : '${value!.day}/${value!.month}/${value!.year}',
            ),
          ),
        ),
      ],
    );
  }
}
