import 'package:flutter/material.dart';
import '../common/form_section.dart';
import '../../widgets/atoms.dart';

class ContractAgentSection extends StatelessWidget {
  const ContractAgentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Contract & Agent',
      fields: const [
        AppTextField(label: 'Estimated Price/Salary', hint: 'e.g., \$90,000'),
        AppTextField(label: 'Country', hint: 'Select Country'),
        AppTextField(label: 'Agent Name', hint: 'Enter agent name'),
      ],
    );
  }
}
