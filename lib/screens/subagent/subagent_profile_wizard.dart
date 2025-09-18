import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../sections/common/form_section.dart';
import '../../sections/common/verification_documents_section.dart';

class SubAgentProfileWizard extends StatelessWidget {
  const SubAgentProfileWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Create Your Profile — Sub-Agent',
      children: const [
        _PersonalInfo(),
        _SportsOperations(),
        VerificationDocumentsSection(),
      ],
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SecondaryButton(label: 'Save as Draft'),
          PrimaryButton(label: 'Submit Profile'),
        ],
      ),
    );
  }
}

class _PersonalInfo extends StatelessWidget {
  const _PersonalInfo();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Personal Information',
      fields: const [
        Text('Full Name'),
        SizedBox(height: 8),
        Text('Date of Birth'),
        SizedBox(height: 8),
        Text('Gender'),
        SizedBox(height: 8),
        Text('Nationality'),
        SizedBox(height: 8),
        Text('Years of Experience'),
        SizedBox(height: 8),
        Text('Languages Spoken'),
      ],
    );
  }
}

class _SportsOperations extends StatelessWidget {
  const _SportsOperations();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Sports Operations & Services',
      fields: const [
        Text('Sports (Select your sports)'),
      ],
    );
  }
}
