import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../theme/app_theme.dart'; // AppPalette, AppGradients

class ChooseProfileScreen extends StatefulWidget {
  const ChooseProfileScreen({super.key});

  @override
  State<ChooseProfileScreen> createState() => _ChooseProfileScreenState();
}

class _ChooseProfileScreenState extends State<ChooseProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  String? _selected; // e.g. "Football Player"
  String _activeGroup = 'Players';

  final Map<String, List<String>> _categories = const {
    'Players': [
      '⚽ Football Player',
      '🏀 Basketball Player',
      '🏐 Volleyball Player',
      '🤾 Handball Player',
      '🥅 Futsal Player',
    ],
    'Agent': ['🤝 Main Agent', '🧑‍🤝‍🧑 Sub-Agent'],
    'Staff': ['🧑‍🏫 Coach', '🩺 Physiotherapist'],
    'Organizations': [
      '🏬 Sports Store',
      '🏟️ Sports Club',
      '⛺ Sport Camp',
      '🏫 Sport Academy',
    ],
  };

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this)..addListener(() {
      final groups = _categories.keys.toList();
      setState(() {
        _activeGroup = groups[_tab.index];
        _selected = null; // reset selection when switching tab
      });
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Choose Your Profile',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
            label: _selected == null ? 'Select an option' : 'Continue',
            onPressed:
                _selected == null
                    ? null
                    : () {
                      // derive a route name from the active top tab
                      final key = _activeGroup.toLowerCase();
                      final route = '/${key.replaceAll(' ', '')}Wizard';
                      Navigator.pushNamed(context, route);
                    },
          ),
        ],
      ),
      children: [
        // Brand banner / subtitle
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: const BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: const Text(
            'Select the profile type that best describes you',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),

        // Top nav (tabs)
        _TopNavTabs(controller: _tab),

        const SizedBox(height: 12),

        // Tab content (chips)
        SizedBox(
          height: 340, // lets content breathe; grows with Wrap
          child: TabBarView(
            controller: _tab,
            physics: const BouncingScrollPhysics(),
            children:
                _categories.keys.map((group) {
                  final items = _categories[group]!;
                  return _ChipsGrid(
                    items: items,
                    selected: _selected,
                    onSelect: (v) => setState(() => _selected = v),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Top navigation styled to match the PDF (bold labels + gradient indicator).
class _TopNavTabs extends StatelessWidget {
  const _TopNavTabs({required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        tabAlignment: TabAlignment.start, // needs Flutter 3.10+

        unselectedLabelStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: Colors.white70),
        labelColor: Colors.white,
        unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
        indicator: const _GradientRoundedIndicator(),
        tabs: const [
          Tab(text: '  Players '),
          Tab(text: '  Agent '),
          Tab(text: '  Staff '),
          Tab(text: '  Organizations '),
        ],
      ),
    );
  }
}

/// Gradient rounded pill under active tab
class _GradientRoundedIndicator extends Decoration {
  const _GradientRoundedIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientRoundedPainter();
  }
}

class _GradientRoundedPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final rect = offset & cfg.size!;
    final r = RRect.fromRectAndRadius(
      Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height),
      const Radius.circular(10),
    );
    final paint =
        Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFF010669), Color(0xFF012DF0)],
          ).createShader(r.outerRect);
    canvas.drawRRect(r, paint);
  }
}

/// Responsive chip grid using gradient rings and selected fill.
class _ChipsGrid extends StatelessWidget {
  const _ChipsGrid({
    required this.items,
    required this.selected,
    required this.onSelect,
  });

  final List<String> items;
  final String? selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final gap = (w * 0.012).clamp(8.0, 16.0);

        return SingleChildScrollView(
          padding: EdgeInsets.all(gap),
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final item in items)
                _GradientChoiceChip(
                  label: item,
                  selected: selected == item,
                  onTap: () => onSelect(item),
                  textStyle: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Brand-styled chip
class _GradientChoiceChip extends StatelessWidget {
  const _GradientChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.textStyle,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);

    final bg = Colors.white;
    final border = Border.all(
      color:
          selected
              ? AppPalette.gradientEnd
              : Theme.of(context).colorScheme.outlineVariant,
      width: selected ? 1.6 : 1,
    );

    return InkWell(
      borderRadius: radius,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: border,
          boxShadow:
              selected
                  ? [
                    BoxShadow(
                      color: AppPalette.gradientEnd.withOpacity(0.12),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ]
                  : null,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: (textStyle ?? const TextStyle()).copyWith(
                  color:
                      selected
                          ? AppPalette.gradientEnd
                          : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
