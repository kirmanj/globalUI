import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionScaffold(
      title: 'App Settings',
      children: [
        Card(child: SwitchListTile(title: const Text('Push Notifications'), value: true, onChanged: (_){ })),
        Card(child: SwitchListTile(title: const Text('Vibration'), value: false, onChanged: (_){ })),
        Card(child: SwitchListTile(title: const Text('Sound'), value: true, onChanged: (_){ })),
        const SizedBox(height: 12),
        Card(child: ListTile(title: const Text('Theme'), trailing: const Text('Light'))),
        Card(child: ListTile(title: const Text('Language'), trailing: const Text('English'))),
        const SizedBox(height: 12),
        Card(child: ListTile(title: const Text('Privacy Settings'))),
        Card(child: ListTile(title: const Text('Payment Method'))),
        Card(child: ListTile(title: const Text('Clear Cache'))),
        const SizedBox(height: 12),
        Card(child: ListTile(title: const Text('About App'), subtitle: const Text('Version 2.1.3'))),
        Card(child: ListTile(title: const Text('Terms & Conditions'), onTap: () => Navigator.pushNamed(context, '/terms'))),
        const SizedBox(height: 12),
        Card(child: ListTile(title: const Text('Delete Account'), textColor: theme.colorScheme.error)),
      ],
    );
  }
}
