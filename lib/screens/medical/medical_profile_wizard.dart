import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../sections/common/form_section.dart';
import '../../sections/common/career_achievements_section.dart';
import '../../sections/common/highlight_videos_section.dart';
import '../../sections/common/verification_documents_section.dart';

class MedicalProfileWizard extends StatelessWidget {
  const MedicalProfileWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Create Your Profile — Medical',
      children: const [
        _MedicalPersonalInfo(),
        _CertificationLicenses(),
        _MedicalExperience(),
        _InjuryCaseStudies(),
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

class _MedicalPersonalInfo extends StatelessWidget {
  const _MedicalPersonalInfo();

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
        Text('Role: Select'),
        SizedBox(height: 8),
        Text('Affiliation: Enter Your Affiliation'),
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
        Text('Certification Name'),
        SizedBox(height: 8),
        Text('Issuing Organization'),
        SizedBox(height: 8),
        Text('Year Obtained'),
        SizedBox(height: 8),
        Text('Expiry Date (Optional)'),
        SizedBox(height: 8),
        Text('Upload document (PDF, JPG, PNG)'),
      ],
    );
  }
}

class _MedicalExperience extends StatelessWidget {
  const _MedicalExperience();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Medical Experience',
      fields: const [
        Text('Years of Medical Experience'),
        SizedBox(height: 8),
        Text('Current Club or Organization'),
        SizedBox(height: 8),
        Text('Age Groups'),
        SizedBox(height: 8),
        Text('Levels'),
      ],
    );
  }
}

class _InjuryCaseStudies extends StatelessWidget {
  const _InjuryCaseStudies();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Injury Case Studies',
      fields: const [
        Text('Case Study Name'),
        SizedBox(height: 8),
        Text('Title / Achievement'),
        SizedBox(height: 8),
        Text('Year or Time Period (Optional)'),
        SizedBox(height: 8),
        Text('Levels'),
      ],
    );
  }
}
