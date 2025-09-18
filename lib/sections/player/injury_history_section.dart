import 'package:flutter/material.dart';
import '../common/form_section.dart';
import '../../widgets/atoms.dart';

class InjuryHistorySection extends StatelessWidget {
  const InjuryHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Injury History',
      fields: const [
        AppTextField(label: 'Injury Type', hint: 'e.g., Ankle Sprain'),
        AppTextField(label: 'Date', hint: 'DD/MM/YYYY'),
        AppTextField(label: 'Recovery Period', hint: 'e.g., 8 weeks'),
      ],
    );
  }
}
