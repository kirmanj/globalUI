import 'package:flutter/material.dart';
import '../common/form_section.dart';
import '../../widgets/atoms.dart';

class FootballInfoSection extends StatelessWidget {
  const FootballInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Football Information',
      subtitle: 'Select your preferred positions',
      fields: const [
        AppTextField(label: 'Preferred Positions', hint: 'Forward, Striker, Left Wing'),
        AppTextField(label: 'Preferred Foot', hint: 'Left / Right / Both'),
        AppTextField(label: 'Height (cm)', hint: 'Enter your height in cm', keyboardType: TextInputType.number),
        AppTextField(label: 'Weight (kg)', hint: 'Enter your weight in kg', keyboardType: TextInputType.number),
        AppTextField(label: 'Current Club (or Free Agent)', hint: 'Enter your current club name'),
        AppTextField(label: 'Playing Since (Year)', hint: 'Enter starting year', keyboardType: TextInputType.number),
      ],
    );
  }
}
