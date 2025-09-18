import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';

class ProfileEmptyScreen extends StatelessWidget {
  const ProfileEmptyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'Profile',
      children: const [
        SizedBox(height: 24),
        Text('No profile yet', textAlign: TextAlign.center),
        SizedBox(height: 8),
        Text("Create account to start connect with friends, you'll see them here", textAlign: TextAlign.center),
      ],
      footer: Center(child: PrimaryButton(label: 'Create account')),
    );
  }
}
