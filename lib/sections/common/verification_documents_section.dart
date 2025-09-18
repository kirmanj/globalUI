import 'package:flutter/material.dart';
import 'form_section.dart';
import '../../widgets/atoms.dart';

class VerificationDocumentsSection extends StatelessWidget {
  const VerificationDocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Verification Documents',
      fields: const [
        AppTextField(label: 'National Youth ID', hint: 'Upload file (PDF, JPG, PNG)'),
        AppTextField(label: 'Anti-Doping Clearance', hint: 'Upload file (PDF, JPG, PNG)'),
      ],
    );
  }
}
