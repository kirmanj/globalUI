// lib/widgets/wizard_ui.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart'; // AppGradients, AppPalette
import 'atoms.dart'; // PrimaryButton (or replace with your own button)

/// Public metadata model for steps (no underscore = not library-private)
class StepMeta {
  final String label;
  final IconData icon;
  const StepMeta(this.label, this.icon);
}

/* ======================== HEADER ======================== */

class WizardHeader extends StatelessWidget {
  const WizardHeader({
    super.key,
    required this.title,
    required this.steps,
    required this.done,
    required this.open,
    required this.progress,
    required this.onTapStep,
  });

  final String title;
  final List<StepMeta> steps;
  final List<bool> done;
  final int open;
  final double progress;
  final ValueChanged<int> onTapStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Your Profile',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.15),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text('Add photo', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(height: 8, child: ProgressBar(value: progress)),
          const SizedBox(height: 10),

          // Top step pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            child: Row(
              children: List.generate(steps.length, (i) {
                final isOpen = i == open;
                final isDone = done[i];
                final locked = i > done.lastIndexWhere((x) => x) + 1;

                return Padding(
                  padding: EdgeInsets.only(
                    right: i == steps.length - 1 ? 0 : 8,
                  ),
                  child: InkWell(
                    onTap: locked ? null : () => onTapStep(i),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isOpen
                                ? Colors.white.withOpacity(0.16)
                                : Colors.white.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isDone
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.35),
                          width: isOpen ? 1.4 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isDone ? Icons.check_circle_rounded : steps[i].icon,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            steps[i].label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (locked) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.lock_rounded,
                              size: 16,
                              color: Colors.white70,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

/* ======================== STEP CARD ======================== */

class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
    required this.index,
    required this.meta,
    required this.open,
    required this.done,
    required this.locked,
    required this.child,
    required this.onContinue,
    required this.onToggle,
    required this.canContinue,
    this.lockedHint,
    this.continueLabel = 'Save & Continue',
    this.trailing,
  });

  final int index;
  final StepMeta meta;
  final bool open;
  final bool done;
  final bool locked;
  final Widget child;
  final VoidCallback onContinue;
  final VoidCallback onToggle;
  final bool canContinue;
  final String? lockedHint;
  final String continueLabel;

  /// Optional widget on the right side of the header (e.g., help icon)
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(16);

    final header = InkWell(
      onTap: locked ? null : onToggle,
      borderRadius: radius,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: radius,
          border: Border.all(
            color:
                open
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant,
            width: open ? 1.5 : 1,
          ),
          boxShadow:
              open
                  ? [
                    BoxShadow(
                      color: AppPalette.gradientEnd.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 12),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primary,
              ),
              child: Icon(
                done ? Icons.check_rounded : meta.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                meta.label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (trailing != null) trailing!,
            if (locked)
              Row(
                children: [
                  const Icon(Icons.lock_rounded, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    lockedHint ?? 'Locked',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              )
            else
              Icon(
                open
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
              ),
          ],
        ),
      ),
    );

    final body = AnimatedCrossFade(
      crossFadeState:
          open ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 180),
      firstChild: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: radius,
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            const SizedBox(height: 12),
            PrimaryButton(
              label: continueLabel,
              onPressed: canContinue ? onContinue : null,
            ),
          ],
        ),
      ),
      secondChild: const SizedBox(height: 8),
    );

    return Opacity(
      opacity: locked ? 0.55 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(children: [header, body]),
      ),
    );
  }
}

/* ======================== MINI TRACKERS ======================== */

class MiniStepTracker extends StatelessWidget {
  const MiniStepTracker({
    super.key,
    required this.total,
    required this.done,
    required this.current,
  });

  final int total;
  final List<bool> done;
  final int current;

  @override
  Widget build(BuildContext context) {
    final completed = done.where((e) => e).length;
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⚽ ', style: TextStyle(fontSize: 12)),
                Text(
                  '$completed/$total',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              children: List.generate(total, (i) {
                final isDone = done[i];
                final isCurrent = i == current;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isDone || isCurrent ? AppGradients.primary : null,
                    color: isDone || isCurrent ? null : Colors.white,
                    border: Border.all(
                      color:
                          isDone || isCurrent
                              ? Colors.transparent
                              : Colors.black26,
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      isDone ? '✓' : '${i + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            (isDone || isCurrent)
                                ? Colors.white
                                : Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniTrackerRail extends StatelessWidget {
  const MiniTrackerRail({
    super.key,
    required this.total,
    required this.done,
    required this.current,
    required this.onTapStep,
    this.scale = 0.80,
  });

  final int total;
  final List<bool> done;
  final int current;
  final ValueChanged<int> onTapStep;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completed = done.where((e) => e).length;

    final dotSize = 22.0 * scale;
    final connectorW = 2.0 * scale;
    final connectorH = 14.0 * scale;
    final connectorMargin = 4.0 * scale;
    final padV = 12.0 * scale;
    final padH = 10.0 * scale;
    final radius = 16.0 * scale;
    final borderW = 1.0 * scale;
    final shadowBlur = 14.0 * scale;
    final shadowDy = 8.0 * scale;
    final fontSize = dotSize * 0.6;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 12.0 * scale),
        Container(
          padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
              width: borderW,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: shadowBlur,
                offset: Offset(0, shadowDy),
              ),
            ],
          ),
          child: Column(
            children: List.generate(total * 2 - 1, (i) {
              if (i.isOdd) {
                final segIndex = (i ~/ 2);
                final filled = segIndex < completed - 1;
                return Container(
                  width: connectorW,
                  height: connectorH,
                  margin: EdgeInsets.symmetric(vertical: connectorMargin),
                  decoration: BoxDecoration(
                    color:
                        filled
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant.withOpacity(.6),
                    borderRadius: BorderRadius.circular(connectorW / 2),
                  ),
                );
              } else {
                final stepIndex = (i ~/ 2);
                final isDone = done[stepIndex];
                final isCurrent = stepIndex == current;
                final locked = stepIndex > done.lastIndexWhere((x) => x) + 1;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0 * scale),
                  child: InkWell(
                    onTap: locked ? null : () => onTapStep(stepIndex),
                    borderRadius: BorderRadius.circular(999),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: dotSize,
                      height: dotSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            (isDone || isCurrent) ? AppGradients.primary : null,
                        color:
                            (isDone || isCurrent)
                                ? null
                                : theme.colorScheme.surface,
                        border: Border.all(
                          color:
                              (isDone || isCurrent)
                                  ? Colors.transparent
                                  : theme.colorScheme.outlineVariant,
                          width: borderW,
                        ),
                      ),
                      child: Text(
                        isDone ? '✓' : '${stepIndex + 1}',
                        style: TextStyle(
                          fontSize: fontSize,
                          color:
                              (isDone || isCurrent)
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}

/* ======================== SMALL UI HELPERS ======================== */

class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme.labelLarge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(label, style: t), const SizedBox(height: 8), child],
    );
  }
}

class EmojiDropdown<T> extends StatelessWidget {
  const EmojiDropdown({
    super.key,
    required this.label,
    required this.items,
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
    return LabeledField(
      label: label,
      child: DropdownButtonFormField<T>(
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
            items
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e.$3,
                    child: Row(
                      children: [
                        Text(e.$1, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(e.$2)),
                      ],
                    ),
                  ),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class Segmented<T> extends StatelessWidget {
  const Segmented({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final List<(String, String, T)> options;
  final T? value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: label,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            options.map((o) {
              final selected = value == o.$3;
              return ChoiceChip(
                selected: selected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(o.$1), const SizedBox(width: 6), Text(o.$2)],
                ),
                onSelected: (_) => onChanged(o.$3),
              );
            }).toList(),
      ),
    );
  }
}

class MultiChip<T> extends StatefulWidget {
  const MultiChip({
    super.key,
    required this.label,
    required this.options,
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
    return LabeledField(
      label: widget.label,
      child: Wrap(
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
                  children: [Text(o.$1), const SizedBox(width: 6), Text(o.$2)],
                ),
              );
            }).toList(),
      ),
    );
  }
}

class NumberWheelField extends StatefulWidget {
  const NumberWheelField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 300,
  });

  final String label;
  final int value;
  final int min, max;
  final ValueChanged<int> onChanged;

  @override
  State<NumberWheelField> createState() => _NumberWheelFieldState();
}

class _NumberWheelFieldState extends State<NumberWheelField> {
  late int _current;
  late final PageController _pc;

  int get _initialPage =>
      (widget.value - widget.min).clamp(0, widget.max - widget.min);

  @override
  void initState() {
    super.initState();
    _current = widget.value;
    _pc = PageController(initialPage: _initialPage, viewportFraction: 0.22);
  }

  @override
  void didUpdateWidget(covariant NumberWheelField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _current) {
      _current = widget.value;
      _pc.jumpToPage(_initialPage);
    }
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Container(
          height: 64,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: radius,
          ),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _pc,
                builder: (context, _) {
                  final page =
                      _pc.hasClients
                          ? _pc.page ?? _initialPage.toDouble()
                          : _initialPage.toDouble();
                  return PageView.builder(
                    controller: _pc,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.max - widget.min + 1,
                    onPageChanged: (idx) {
                      final val = widget.min + idx;
                      if (val != _current) {
                        setState(() => _current = val);
                        widget.onChanged(val);
                      }
                    },
                    itemBuilder: (context, idx) {
                      final num = widget.min + idx;
                      final dist = (idx - page).abs();
                      final scale = (1.0 - (dist * 0.25)).clamp(0.8, 1.0);
                      final opacity = (1.0 - (dist * 0.6)).clamp(0.3, 1.0);

                      return Center(
                        child: Opacity(
                          opacity: opacity,
                          child: Transform.scale(
                            scale: scale,
                            child: Text(
                              '$num',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (_) => Colors.white,
                    ),
                  ),
                  icon: const Icon(CupertinoIcons.chevron_left),
                  onPressed: () {
                    final p = (_pc.page ?? _initialPage.toDouble()).round();
                    if (p > 0) {
                      _pc.previousPage(
                        duration: const Duration(milliseconds: 160),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.chevron_right),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (_) => Colors.white,
                    ),
                  ),
                  onPressed: () {
                    final p = (_pc.page ?? _initialPage.toDouble()).round();
                    final last = widget.max - widget.min;
                    if (p < last) {
                      _pc.nextPage(
                        duration: const Duration(milliseconds: 160),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
    final radius = BorderRadius.circular(12);
    return LabeledField(
      label: label,
      child: InkWell(
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
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value == null
                      ? 'DD/MM/YYYY'
                      : '${value!.day}/${value!.month}/${value!.year}',
                ),
              ),
              const Icon(Icons.calendar_today_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.value, this.trackOpacity = .25});
  final double value; // 0..1
  final double trackOpacity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: LayoutBuilder(
        builder: (ctx, cons) {
          final w = cons.maxWidth * value.clamp(0, 1);
          return Stack(
            children: [
              Container(color: Colors.white.withOpacity(trackOpacity)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: w,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
