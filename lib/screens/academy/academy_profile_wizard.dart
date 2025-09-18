import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../sections/common/form_section.dart';
import '../../sections/common/highlight_videos_section.dart';
import '../../sections/common/verification_documents_section.dart';

class AcademyProfileWizard extends StatelessWidget {
  const AcademyProfileWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Create Your Profile — Sport Academy',
      children: const [
        _ContactPerson(),
        _AcademyInformation(),
        _Achievements(),
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

class _AcademyInformation extends StatelessWidget {
  const _AcademyInformation();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Sport Academy Information',
      fields: const [
        Text('Sport Academy Name'),
        SizedBox(height: 8),
        Text('Primary Location'),
        SizedBox(height: 8),
        Text('Gender Availabilities (Male / Female / Both)'),
        SizedBox(height: 8),
        Text('Sports Offered'),
        SizedBox(height: 8),
        Text('Age Groups'),
        SizedBox(height: 8),
        Text('Facilities'),
        SizedBox(height: 8),
        Text('Coaching Staff'),
      ],
    );
  }
}

class _Achievements extends StatelessWidget {
  const _Achievements();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Sport Academy Achievements',
      fields: const [
        Text('Awards / Notable Achievements'),
      ],
    );
  }
}
