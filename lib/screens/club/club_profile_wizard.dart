import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../sections/common/form_section.dart';
import '../../sections/common/highlight_videos_section.dart';
import '../../sections/common/verification_documents_section.dart';

class ClubProfileWizard extends StatelessWidget {
  const ClubProfileWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Create Your Profile — Sports Club',
      children: const [
        _ContactPerson(),
        _ClubInformation(),
        _TalentOperations(),
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

class _ClubInformation extends StatelessWidget {
  const _ClubInformation();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Club Information',
      fields: const [
        Text('Club Name'),
        SizedBox(height: 8),
        Text('Club Type'),
        SizedBox(height: 8),
        Text('Primary Location'),
        SizedBox(height: 8),
        Text('City'),
        SizedBox(height: 8),
        Text('Years in operation'),
      ],
    );
  }
}

class _TalentOperations extends StatelessWidget {
  const _TalentOperations();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Talent Operations',
      fields: const [
        Text('Currently Looking For'),
        SizedBox(height: 8),
        Text('Training Facility Features'),
        SizedBox(height: 8),
        Text('Youth Trials'),
      ],
    );
  }
}
