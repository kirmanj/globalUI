import 'package:flutter/material.dart';

class SearchBarField extends StatelessWidget {
  const SearchBarField({super.key, this.hint = 'Search...', this.icon = Icons.search});
  final String hint; final IconData icon;
  @override
  Widget build(BuildContext context) => TextField(decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon)));
}

class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.value});
  final double value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: theme.colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star_rounded, size: 16), const SizedBox(width: 4), Text(value.toStringAsFixed(1))]),
    );
  }
}

class AvatarTile extends StatelessWidget {
  const AvatarTile({super.key, required this.title, this.subtitle, this.trailing, this.onTap, this.badge, this.asset = 'assets/img_1.png'});
  final String title; final String? subtitle; final Widget? trailing; final VoidCallback? onTap; final Widget? badge; final String asset;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: Container(width: 56, height: 56, color: theme.colorScheme.surfaceVariant)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant))],
        ])),
        if (badge != null) ...[badge!, const SizedBox(width: 8)],
        if (trailing != null) trailing!,
      ])),
    ));
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.label, required this.value});
  final String label; final String value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(children: [Expanded(child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant))), Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600))]);
  }
}

class TagChip extends StatelessWidget {
  const TagChip(this.text, {super.key, this.icon});
  final String text; final IconData? icon;
  @override
  Widget build(BuildContext context) => Chip(label: Text(text), avatar: icon != null ? Icon(icon, size: 16) : null);
}

class BannerCard extends StatelessWidget {
  const BannerCard({super.key, required this.title, required this.subtitle, this.ctaText, this.onPressed});
  final String title; final String subtitle; final String? ctaText; final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(color: theme.colorScheme.primaryContainer, child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(subtitle, style: theme.textTheme.bodyMedium),
      ])),
      if (ctaText != null) FilledButton(onPressed: onPressed, child: Text(ctaText!)),
    ])));
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.index, required this.onTap});
  final int index; final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: index,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Message'),
        NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Favorites'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
      ],
      onDestinationSelected: onTap,
    );
  }
}
