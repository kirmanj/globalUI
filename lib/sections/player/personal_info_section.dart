import 'package:flutter/material.dart';
import '../common/form_section.dart';
import '../../widgets/atoms.dart';

class PlayerPersonalInfoSection extends StatelessWidget {
  const PlayerPersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Personal Information',
      fields: const [
        AppTextField(label: 'Full Name', hint: 'Enter Your Full Name'),
        AppTextField(label: 'Age', hint: '25', keyboardType: TextInputType.number),
        AppTextField(label: 'Date of Birth', hint: 'DD/MM/YYYY'),
        AppTextField(label: 'Gender', hint: 'Male / Female / Other'),
        AppTextField(label: 'Nationality', hint: 'Select country'),
        AppTextField(label: 'Languages Spoken', hint: 'Select languages...'),
      ],
    );
  }
}
