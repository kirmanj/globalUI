import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../sections/common/form_section.dart';
import '../../sections/common/highlight_videos_section.dart';
import '../../sections/common/verification_documents_section.dart';

class CampProfileWizard extends StatelessWidget {
  const CampProfileWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Create Your Profile — Sport Camp',
      children: const [
        _ContactPerson(),
        _CampInformation(),
        _CampingServices(),
        HighlightVideosSection(),
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

class _ContactPerson extends StatelessWidget {
  const _ContactPerson();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Contact Person',
      fields: const [
        Text('Full Name'),
        SizedBox(height: 8),
        Text('Position'),
        SizedBox(height: 8),
        Text('Email Address'),
        SizedBox(height: 8),
        Text('Phone Number'),
      ],
    );
  }
}

class _CampInformation extends StatelessWidget {
  const _CampInformation();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Sport Camping Information',
      fields: const [
        Text('Sport Camping Name'),
        SizedBox(height: 8),
        Text('Duration (e.g., June-July)'),
        SizedBox(height: 8),
        Text('Primary Location'),
        SizedBox(height: 8),
        Text('Sport Focus'),
      ],
    );
  }
}

class _CampingServices extends StatelessWidget {
  const _CampingServices();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Camping Services',
      fields: const [
        Text('Services'),
        SizedBox(height: 8),
        Text('Includes'),
      ],
    );
  }
}
