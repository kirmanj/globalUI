import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../sections/common/form_section.dart';
import '../../sections/common/highlight_videos_section.dart';

class StoreProfileWizard extends StatelessWidget {
  const StoreProfileWizard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Create Your Profile — Sports Store',
      children: const [
        _ContactPerson(),
        _BusinessInformation(),
        HighlightVideosSection(),
        _AddItems(),
        _BusinessContact(),
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

class _BusinessInformation extends StatelessWidget {
  const _BusinessInformation();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Business Information',
      fields: const [
        Text('Business Name'),
        SizedBox(height: 8),
        Text('Business Type'),
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

class _AddItems extends StatelessWidget {
  const _AddItems();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Add Your Items',
      fields: const [
        Text('Upload Item Photo'),
        SizedBox(height: 8),
        Text('Name Of Your Item'),
        SizedBox(height: 8),
        Text('Price Of Your Item'),
      ],
    );
  }
}

class _BusinessContact extends StatelessWidget {
  const _BusinessContact();

  @override
  Widget build(BuildContext context) {
    return FormSection(
      title: 'Business Contact',
      fields: const [
        Text('Email Address Of Your Business'),
        SizedBox(height: 8),
        Text('Phone Number Of Your Business'),
        SizedBox(height: 8),
        Text('Shipping: Select the region'),
        SizedBox(height: 8),
        Text('Website Link'),
      ],
    );
  }
}
