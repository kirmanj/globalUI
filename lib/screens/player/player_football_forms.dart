// lib/features/profile/forms/player_football_forms.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../widgets/wizard_ui.dart'; // LabeledField, EmojiDropdown, etc.

// ===== Personal =====
class PersonalForm extends StatefulWidget {
  const PersonalForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  final _name = TextEditingController();
  String? _gender;
  DateTime? _dob;
  String? _nation;
  final _langs = <String>{};

  @override
  void initState() {
    super.initState();
    _name.addListener(_validate);
  }

  void _validate() {
    final ok =
        _name.text.trim().isNotEmpty &&
        _gender != null &&
        _dob != null &&
        _nation != null &&
        _langs.isNotEmpty;
    widget.onValidChanged(ok);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(
          label: 'Full Name',
          child: TextField(
            controller: _name,
            decoration: const InputDecoration(hintText: 'Enter your full name'),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: LabeledField(
                label: 'Age',
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: '25'),
                  onChanged: (_) => _validate(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DateField(
                label: 'Date of Birth',
                value: _dob,
                onPick: (d) {
                  setState(() => _dob = d);
                  _validate();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
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
            _validate();
          },
        ),
        const SizedBox(height: 10),
        EmojiDropdown<String>(
          label: 'Nationality',
          value: _nation,
          items: const [
            ('🇬🇧', 'United Kingdom', 'GB'),
            ('🇺🇸', 'United States', 'US'),
            ('🇮🇶', 'Iraq', 'IQ'),
            ('🇸🇦', 'Saudi Arabia', 'SA'),
            ('🇪🇬', 'Egypt', 'EG'),
          ],
          onChanged: (v) {
            setState(() => _nation = v);
            _validate();
          },
        ),
        const SizedBox(height: 10),
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
            _langs
              ..clear()
              ..addAll(set);
            _validate();
          },
        ),
      ],
    );
  }
}

// ===== Football =====
class FootballForm extends StatefulWidget {
  const FootballForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<FootballForm> createState() => _FootballFormState();
}

class _FootballFormState extends State<FootballForm> {
  final _positions = <String>{};
  String? _foot;
  int _height = 175;
  int _weight = 70;

  void _notify() => widget.onValidChanged(
    _positions.isNotEmpty && _foot != null && _height > 0 && _weight > 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiChip<String>(
          label: 'Preferred Positions',
          options: const [
            ('🎯', 'Striker', 'ST'),
            ('🪽', 'Left Wing', 'LW'),
            ('🪽', 'Right Wing', 'RW'),
            ('🧠', 'Attacking Mid', 'CAM'),
            ('🛡️', 'Defensive Mid', 'CDM'),
            ('🪨', 'Center Back', 'CB'),
            ('🧤', 'Goalkeeper', 'GK'),
          ],
          onChanged: (s) {
            setState(() {
              _positions
                ..clear()
                ..addAll(s);
            });
            _notify();
          },
        ),
        const SizedBox(height: 10),
        Segmented<String>(
          label: 'Preferred Foot',
          value: _foot,
          options: const [
            ('🦶', 'Left', 'L'),
            ('🦶', 'Right', 'R'),
            ('🦶', 'Both', 'B'),
          ],
          onChanged: (v) {
            setState(() => _foot = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Height (cm)',
          value: _height,
          min: 0,
          max: 300,
          onChanged: (v) {
            setState(() => _height = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Weight (kg)',
          value: _weight,
          min: 0,
          max: 200,
          onChanged: (v) {
            setState(() => _weight = v);
            _notify();
          },
        ),
      ],
    );
  }
}

// ===== Contract =====
class ContractForm extends StatefulWidget {
  const ContractForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<ContractForm> createState() => _ContractFormState();
}

class _ContractFormState extends State<ContractForm> {
  String? _country, _contactMode;
  final _salary = TextEditingController();

  void _notify() =>
      widget.onValidChanged(_country != null && _contactMode != null);

  @override
  void initState() {
    super.initState();
    _salary.addListener(_notify);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(
          label: 'Estimated Price / Salary',
          child: TextField(
            controller: _salary,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'e.g., 90000'),
          ),
        ),
        const SizedBox(height: 10),
        EmojiDropdown<String>(
          label: 'Country',
          value: _country,
          items: const [
            ('🇮🇶', 'Iraq', 'IQ'),
            ('🇸🇦', 'Saudi Arabia', 'SA'),
            ('🇹🇷', 'Turkey', 'TR'),
            ('🇬🇧', 'United Kingdom', 'GB'),
          ],
          onChanged: (v) {
            setState(() => _country = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        Segmented<String>(
          label: 'Contact Allowed',
          value: _contactMode,
          options: const [
            ('📞', 'Direct', 'direct'),
            ('🧑‍💼', 'Via Agent', 'agent'),
          ],
          onChanged: (v) {
            setState(() => _contactMode = v);
            _notify();
          },
        ),
      ],
    );
  }
}

// ===== Stats =====
class StatsForm extends StatefulWidget {
  const StatsForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<StatsForm> createState() => _StatsFormState();
}

class _StatsFormState extends State<StatsForm> {
  int matches = 0, goals = 0, assists = 0, yellow = 0, red = 0;
  void _notify() => widget.onValidChanged(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberWheelField(
          label: 'Matches Played',
          value: matches,
          min: 0,
          max: 500,
          onChanged: (v) {
            setState(() => matches = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Goals Scored ⚽',
          value: goals,
          min: 0,
          max: 500,
          onChanged: (v) {
            setState(() => goals = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Assists 🎯',
          value: assists,
          min: 0,
          max: 500,
          onChanged: (v) {
            setState(() => assists = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Yellow Cards 🟨',
          value: yellow,
          min: 0,
          max: 300,
          onChanged: (v) {
            setState(() => yellow = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Red Cards 🟥',
          value: red,
          min: 0,
          max: 300,
          onChanged: (v) {
            setState(() => red = v);
            _notify();
          },
        ),
      ],
    );
  }
}

// ===== Injuries =====
class InjuriesForm extends StatefulWidget {
  const InjuriesForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<InjuriesForm> createState() => _InjuriesFormState();
}

class _InjuriesFormState extends State<InjuriesForm> {
  final items = <_InjuryItem>[];
  void _notify() => widget.onValidChanged(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          EmojiDropdown<String>(
            label: 'Injury Type',
            value: items[i].type,
            items: const [
              ('🦵', 'ACL Tear', 'acl'),
              ('🦶', 'Ankle', 'ankle'),
              ('🦴', 'Fracture', 'fract'),
              ('🧠', 'Concussion', 'conc'),
            ],
            onChanged: (v) => setState(() => items[i].type = v),
          ),
          const SizedBox(height: 8),
          DateField(
            label: 'Date',
            value: items[i].date,
            onPick: (d) => setState(() => items[i].date = d),
          ),
          const SizedBox(height: 8),
          NumberWheelField(
            label: 'Recovery (weeks)',
            value: items[i].weeks,
            min: 0,
            max: 500,
            onChanged: (v) {
              setState(() => items[i].weeks = v);
              _notify();
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => setState(() => items.removeAt(i)),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Remove'),
            ),
          ),
          const SizedBox(height: 8),
        ],
        OutlinedButton.icon(
          onPressed: () => setState(() => items.add(_InjuryItem())),
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Injury'),
        ),
      ],
    );
  }
}

class _InjuryItem {
  String? type;
  DateTime? date;
  int weeks = 0;
}

// ===== Achievements =====
class AchievementsForm extends StatefulWidget {
  const AchievementsForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<AchievementsForm> createState() => _AchievementsFormState();
}

class _AchievementsFormState extends State<AchievementsForm> {
  int trophies = 0;
  final _awardCtrl = TextEditingController();
  final _awards = <String>[];
  void _notify() => widget.onValidChanged(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberWheelField(
          label: 'Total Trophies 🏆',
          value: trophies,
          min: 0,
          max: 500,
          onChanged: (v) {
            setState(() => trophies = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Add Award (optional)',
          child: TextField(
            controller: _awardCtrl,
            decoration: const InputDecoration(
              hintText: 'e.g., Golden Boot 2023',
            ),
          ),
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: () {
              final t = _awardCtrl.text.trim();
              if (t.isNotEmpty) {
                setState(() {
                  _awards.add(t);
                  _awardCtrl.clear();
                });
              }
            },
            icon: const Text('🏆'),
            label: const Text('Add'),
          ),
        ),
        const SizedBox(height: 6),
        if (_awards.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _awards.map((a) => Chip(label: Text('🏆 $a'))).toList(),
          ),
      ],
    );
  }
}

// ===== Videos =====
class VideosForm extends StatefulWidget {
  const VideosForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<VideosForm> createState() => _VideosFormState();
}

class _VideosFormState extends State<VideosForm> {
  final _title = TextEditingController();
  final _link = TextEditingController();
  void _notify() => widget.onValidChanged(
    _title.text.trim().isNotEmpty || _link.text.trim().isNotEmpty,
  );

  @override
  void initState() {
    super.initState();
    _title.addListener(_notify);
    _link.addListener(_notify);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(
          label: 'Video Title',
          child: TextField(
            controller: _title,
            decoration: const InputDecoration(hintText: 'Enter title'),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () {
            /* hook your file picker */
          },
          icon: const Icon(Icons.upload_file_rounded),
          label: const Text('Upload Video (MP4/MOV)'),
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Or Link',
          child: TextField(
            controller: _link,
            decoration: const InputDecoration(hintText: 'https://youtu.be/...'),
          ),
        ),
      ],
    );
  }
}

// ===== Verification =====
class VerificationForm extends StatefulWidget {
  const VerificationForm({super.key, required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  bool confirm = false;
  void _notify() => widget.onValidChanged(confirm);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.badge_outlined),
          label: const Text('Upload National Youth ID'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.health_and_safety_outlined),
          label: const Text('Upload Anti-Doping Clearance'),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: confirm,
              onChanged: (v) {
                setState(() => confirm = v ?? false);
                _notify();
              },
            ),
            const Expanded(
              child: Text('I confirm all information is accurate'),
            ),
          ],
        ),
      ],
    );
  }
}
