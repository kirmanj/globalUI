import 'package:flutter/material.dart';
import '../common/form_section.dart';
import '../../widgets/atoms.dart';

class SeasonStatsSection extends StatelessWidget {
  const SeasonStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Season Stats',
      fields: const [
        AppTextField(label: 'Matches Played', hint: '0', keyboardType: TextInputType.number),
        AppTextField(label: 'Goals Scored', hint: '0', keyboardType: TextInputType.number),
        AppTextField(label: 'Assists', hint: '0', keyboardType: TextInputType.number),
        AppTextField(label: 'Yellow Cards', hint: '0', keyboardType: TextInputType.number),
        AppTextField(label: 'Red Cards', hint: '0', keyboardType: TextInputType.number),
      ],
    );
  }
}
