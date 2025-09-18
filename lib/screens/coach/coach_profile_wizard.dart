import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../sections/common/form_section.dart';
import '../../sections/common/career_achievements_section.dart';
import '../../sections/common/highlight_videos_section.dart';
import '../../sections/common/verification_documents_section.dart';

class CoachProfileWizard extends StatelessWidget {
  const CoachProfileWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Create Your Profile — Coach',
      children: const [
        _CoachPersonalInfo(),
        _CertificationLicenses(),
        _CoachingExperience(),
        _NotableStudents(),
        CareerAchievementsSection(),
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

class _CoachPersonalInfo extends StatelessWidget {
  const _CoachPersonalInfo();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Personal Information',
      fields: const [
        Text('Full Name: Ahmed Khalid'),
        SizedBox(height: 8),
        Text('Age: 25'),
        SizedBox(height: 8),
        Text('Gender: Male'),
        SizedBox(height: 8),
        Text('Nationality: Select country'),
        SizedBox(height: 8),
        Text('Highest Education Level Completed: Select'),
        SizedBox(height: 8),
        Text('Academic Studies: Select'),
        SizedBox(height: 8),
        Text('Languages Spoken: English, Arabic, French'),
      ],
    );
  }
}

class _CertificationLicenses extends StatelessWidget {
  const _CertificationLicenses();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Certification & Licenses',
      fields: const [
        Text('Licenses Or Certification Name'),
        SizedBox(height: 8),
        Text('Issuing Organization'),
        SizedBox(height: 8),
        Text('Year Obtained (Year)'),
        SizedBox(height: 8),
        Text('Expiry Date (Year) (Optional)'),
        SizedBox(height: 8),
        Text('Upload document (PDF, JPG, PNG)'),
      ],
    );
  }
}

class _CoachingExperience extends StatelessWidget {
  const _CoachingExperience();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Coaching Experience',
      fields: const [
        Text('Years of Coaching Experience'),
        SizedBox(height: 8),
        Text('Current Club or Organization'),
        SizedBox(height: 8),
        Text('Age Groups'),
        SizedBox(height: 8),
        Text('Levels Coached'),
      ],
    );
  }
}

class _NotableStudents extends StatelessWidget {
  const _NotableStudents();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Notable Students',
      fields: const [
        Text('Student Name'),
        SizedBox(height: 8),
        Text('Achievement / Title'),
        SizedBox(height: 8),
        Text('Year or Time Period (Optional)'),
        SizedBox(height: 8),
        Text('Levels Coached'),
      ],
    );
  }
}
