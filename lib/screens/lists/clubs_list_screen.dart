import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/ui_blocks.dart';

class ClubsListScreen extends StatelessWidget {
  const ClubsListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final clubs = const [
      ['City FC', 'Football Club', 4.8], ['Eagles', 'Basketball Club', 4.7], ['Phoenix Tennis', 'Tennis Club', 4.9],
      ['Sharks', 'Swimming Club', 4.6], ['Tornadoes', 'Volleyball Club', 4.5], ['Lions Rugby', 'Rugby Club', 4.7],
      ['United FC', 'Football Club', 4.8], ['Hawks', 'Basketball Club', 4.6],
    ];
    return SectionScaffold(
      title: 'Sports Clubs',
      children: [
        const SearchBarField(hint: 'Search for clubs...'),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: const [TagChip('All'), TagChip('Football'), TagChip('Basketball'), TagChip('Tennis')]),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.6, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: clubs.length,
          itemBuilder: (context, i) {
            final c = clubs[i];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(12)))),
                  const SizedBox(height: 8),
                  Text(c[0] as String, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  Text(c[1] as String, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 6),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    RatingBadge(value: (c[2] as num).toDouble()),
                    FilledButton(onPressed: (){}, child: const Text('Join')),
                  ]),
                ]),
              ),
            );
          },
        ),
      ],
    );
  }
}
