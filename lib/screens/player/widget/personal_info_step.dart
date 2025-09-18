import 'package:flutter/material.dart';
import 'package:globalsportsmarket/screens/player/widget/inputs.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key, required this.onCompleteChanged});
  final ValueChanged<bool> onCompleteChanged;

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final _nameCtrl = TextEditingController();
  String? _gender;
  DateTime? _dob;
  String? _nationality;
  Set<String> _langs = {};

  bool get _complete =>
      _nameCtrl.text.trim().isNotEmpty &&
      _gender != null &&
      _dob != null &&
      _nationality != null &&
      _langs.isNotEmpty;

  void _notify() => widget.onCompleteChanged(_complete);

  @override
  void initState() {
    super.initState();
    _nameCtrl.addListener(_notify);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notify());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Personal Information',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),

            // Minimal typing: only name is free text
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
              ),
            ),
            const SizedBox(height: 12),

            Segmented<String>(
              label: 'Gender',
              value: _gender,
              options: const [
                ('👨', 'Male', 'male'),
                ('👩', 'Female', 'female'),
                ('⚧️', 'Other', 'other'),
              ],
              onChanged: (v) {
                setState(() => _gender = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),

            DateField(
              label: 'Date of Birth',
              value: _dob,
              onPick: (v) {
                setState(() => _dob = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),

            EmojiDropdown<String>(
              label: 'Nationality',
              value: _nationality,
              items: const [
                ('🇬🇧', 'United Kingdom', 'GB'),
                ('🇺🇸', 'United States', 'US'),
                ('🇮🇶', 'Iraq', 'IQ'),
                ('🇸🇦', 'Saudi Arabia', 'SA'),
                ('🇪🇬', 'Egypt', 'EG'),
              ],
              onChanged: (v) {
                setState(() => _nationality = v);
                _notify();
              },
            ),
            const SizedBox(height: 12),

            MultiChip<String>(
              label: 'Languages Spoken',
              options: const [
                ('🇬🇧', 'English', 'en'),
                ('🇪🇸', 'Spanish', 'es'),
                ('🇫🇷', 'French', 'fr'),
                ('🇦🇪', 'Arabic', 'ar'),
                ('🇩🇪', 'German', 'de'),
              ],
              onChanged: (set) {
                setState(() => _langs = set);
                _notify();
              },
            ),
          ],
        ),
      ),
    );
  }
}
