import 'package:flutter/material.dart';
import 'form_section.dart';
import '../../widgets/atoms.dart';

class CareerAchievementsSection extends StatelessWidget {
  const CareerAchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Career Achievements',
      fields: const [
        AppTextField(label: 'Total Trophies', hint: '3', keyboardType: TextInputType.number),
        AppTextField(label: 'Notable Awards', hint: 'Golden Boot 2023'),
        AppTextField(label: 'Previous Clubs', hint: 'Club name and years (e.g., 2018-2022)'),
        AppTextField(label: 'Other Achievements', hint: 'Add any other notable achievements'),
      ],
    );
  }
}
