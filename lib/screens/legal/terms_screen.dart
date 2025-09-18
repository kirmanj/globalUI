import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final lorem = 'Please read these terms carefully before using our services. If you do not agree with any part of these terms, you may not use our application.\n\n';
    return SectionScaffold(
      title: 'Terms & Conditions',
      children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(('Introduction\n\n' + lorem*8 + 'Important Notice\n\n' + lorem*2), style: Theme.of(context).textTheme.bodyMedium))),
      ],
    );
  }
}
