import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../theme/app_theme.dart'; // AppGradients, AppPalette
import 'package:flutter/cupertino.dart';

class PlayerProfileWizard extends StatefulWidget {
  const PlayerProfileWizard({super.key});
  @override
  State<PlayerProfileWizard> createState() => _PlayerProfileWizardState();
}

class _PlayerProfileWizardState extends State<PlayerProfileWizard> {
  final _scroll = ScrollController();

  // 8 steps
  final _steps = const [
    _StepMeta('Personal', Icons.account_circle_rounded),
    _StepMeta('Football', Icons.sports_soccer_rounded),
    _StepMeta('Contract', Icons.attach_money_rounded),
    _StepMeta('Stats', Icons.bar_chart_rounded),
    _StepMeta('Injuries', Icons.medical_services_rounded),
    _StepMeta('Achievements', Icons.emoji_events_rounded),
    _StepMeta('Videos', Icons.video_library_rounded),
    _StepMeta('Verification', Icons.verified_user_rounded),
  ];

  int _open = 0;
  final List<bool> _done = List<bool>.filled(8, false);
  final List<bool> _valid = List<bool>.filled(8, false);

  void _setValid(int i, bool v) => setState(() => _valid[i] = v);

  // Count finished steps + count current open step if it's valid
  double get _progress {
    final completed = _done.where((e) => e).length;
    final currentCredit = (!_done[_open] && _valid[_open]) ? 1 : 0;
    return (completed + currentCredit) / _steps.length;
  }

  void _markDoneAndOpenNext() {
    setState(() {
      _done[_open] = true;
      if (_open < _steps.length - 1) _open++;
    });
    _setValid(_open, _valid[_open]);
    // scroll to the newly opened card
    Future.delayed(const Duration(milliseconds: 120), () {
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }
  // hide rail when all steps are done

  @override
  Widget build(BuildContext context) {
    final showRail = _progress < 1.0;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // makes the first child fill the stack

        children: [
          SectionScaffold(
            title: 'Create Your Profile',
            footer: Row(
              children: [
                OutlinedButton(onPressed: () {}, child: Text("Save Draft")),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: _done.every((e) => e) ? 'Finish' : 'Save & Continue',
                    onPressed:
                        _done.every((e) => e) ? () {} : _markDoneAndOpenNext,
                  ),
                ),
              ],
            ),
            children: [
              _WizardHeader(
                title: 'Enter your football details',
                steps: _steps,
                done: _done,
                open: _open,
                progress: _progress,
                onTapStep: (i) {
                  // allow going back; forward steps stay locked until previous complete
                  if (i <= _done.lastIndexWhere((x) => x) + 1) {
                    setState(() => _open = i);
                  }
                },
              ),
              const SizedBox(height: 12),

              // Accordion cards
              LayoutBuilder(
                builder: (context, constraints) {
                  // show rail on wide screens
                  return SingleChildScrollView(
                    controller: _scroll,
                    child: Column(
                      children: [
                        // 1 Personal
                        _StepCard(
                          index: 0,
                          meta: _steps[0],
                          open: _open == 0,
                          done: _done[0],
                          locked: false,
                          canContinue: _valid[0],
                          child: _PersonalForm(
                            onValidChanged: (ok) => _setValid(0, ok),
                          ),
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = 0),
                        ),
                        // 2 Football
                        _StepCard(
                          index: 1,
                          meta: _steps[1],
                          open: _open == 1,
                          done: _done[1],
                          locked: !_done[0],
                          lockedHint: 'Complete personal info to unlock',
                          child: _FootballForm(onValidChanged: (ok) {}),
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = 1),
                          canContinue: _valid[0],
                        ),
                        // 3 Contract
                        _StepCard(
                          index: 2,
                          meta: _steps[2],
                          open: _open == 2,
                          done: _done[2],
                          locked: !_done[1],
                          child: _ContractForm(onValidChanged: (ok) {}),
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = 2),
                          canContinue: _valid[0],
                        ),
                        // 4 Stats
                        _StepCard(
                          index: 3,
                          meta: _steps[3],
                          open: _open == 3,
                          done: _done[3],
                          locked: !_done[2],
                          child: _StatsForm(onValidChanged: (ok) {}),
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = 3),
                          canContinue: _valid[0],
                        ),
                        // 5 Injuries
                        _StepCard(
                          index: 4,
                          meta: _steps[4],
                          open: _open == 4,
                          done: _done[4],
                          locked: !_done[3],
                          child: _InjuriesForm(onValidChanged: (ok) {}),
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = 4),
                          canContinue: _valid[0],
                        ),
                        // 6 Achievements
                        _StepCard(
                          index: 5,
                          meta: _steps[5],
                          open: _open == 5,
                          done: _done[5],
                          locked: !_done[4],
                          child: _AchievementsForm(onValidChanged: (ok) {}),
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = 5),
                          canContinue: _valid[0],
                        ),
                        // 7 Videos
                        _StepCard(
                          index: 6,
                          meta: _steps[6],
                          open: _open == 6,
                          done: _done[6],
                          locked: !_done[5],
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = 6),
                          canContinue: _valid[0],
                          child: _VideosForm(onValidChanged: (ok) {}),
                        ),
                        // 8 Verification
                        _StepCard(
                          index: 7,
                          meta: _steps[7],
                          open: _open == 7,
                          done: _done[7],
                          locked: !_done[6],
                          child: _VerificationForm(onValidChanged: (ok) {}),
                          onContinue: () {
                            setState(() => _done[7] = true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile submitted'),
                              ),
                            );
                          },
                          onToggle: () => setState(() => _open = 7),
                          canContinue: _valid[0],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 25,
            right: 0,
            child: SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder:
                      (child, anim) => FadeTransition(
                        opacity: anim,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: .95,
                            end: 1,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                  child:
                      showRail
                          ? Padding(
                            key: const ValueKey('rail-visible'),
                            padding: const EdgeInsets.only(top: 12, right: 12),
                            child: _MiniTrackerRail(
                              total: _steps.length,
                              done: _done,
                              current: _open,
                              onTapStep: (i) {
                                final canOpen =
                                    i <= _done.lastIndexWhere((x) => x) + 1;
                                if (canOpen) setState(() => _open = i);
                              },
                            ),
                          )
                          : const SizedBox.shrink(key: ValueKey('rail-hidden')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ======================== HEADER ======================== */

class _WizardHeader extends StatelessWidget {
  const _WizardHeader({
    required this.title,
    required this.steps,
    required this.done,
    required this.open,
    required this.progress,
    required this.onTapStep,
  });

  final String title;
  final List<_StepMeta> steps;
  final List<bool> done;
  final int open;
  final double progress;
  final ValueChanged<int> onTapStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Your Profile',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 12),

          // avatar placeholder
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.15),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text('Add photo', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // progress bar
          SizedBox(height: 8, child: _ProgressBar(value: progress)),

          const SizedBox(height: 10),

          // top nav of steps
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            child: Row(
              children: List.generate(steps.length, (i) {
                final isOpen = i == open;
                final isDone = done[i];
                final locked = i > done.lastIndexWhere((x) => x) + 1;

                return Padding(
                  padding: EdgeInsets.only(
                    right: i == steps.length - 1 ? 0 : 8,
                  ),
                  child: InkWell(
                    onTap: locked ? null : () => onTapStep(i),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isOpen
                                ? Colors.white.withOpacity(0.16)
                                : Colors.white.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              isDone
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.35),
                          width: isOpen ? 1.4 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isDone ? Icons.check_circle_rounded : steps[i].icon,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            steps[i].label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (locked) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.lock_rounded,
                              size: 16,
                              color: Colors.white70,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStepTracker extends StatelessWidget {
  const _MiniStepTracker({
    required this.total,
    required this.done,
    required this.current,
  });

  final int total;
  final List<bool> done;
  final int current;

  @override
  Widget build(BuildContext context) {
    final completed = done.where((e) => e).length;
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1) counter
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⚽ ', style: TextStyle(fontSize: 12)),
                Text(
                  '$completed/$total',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // 2) row of numbered circles
            Wrap(
              spacing: 6,
              children: List.generate(total, (i) {
                final isDone = done[i];
                final isCurrent = i == current;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isDone || isCurrent ? AppGradients.primary : null,
                    color: isDone || isCurrent ? null : Colors.white,
                    border: Border.all(
                      color:
                          isDone || isCurrent
                              ? Colors.transparent
                              : Colors.black26,
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      isDone ? '✓' : '${i + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            isDone || isCurrent ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/* ======================== STEP CARD ======================== */

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.index,
    required this.meta,
    required this.open,
    required this.done,
    required this.locked,
    required this.child,
    required this.onContinue,
    required this.onToggle,
    this.lockedHint,
    required this.canContinue,
  });

  final int index;
  final bool canContinue;

  final _StepMeta meta;
  final bool open;
  final bool done;
  final bool locked;
  final Widget child;
  final VoidCallback onContinue;
  final VoidCallback onToggle;
  final String? lockedHint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(16);

    final header = InkWell(
      onTap: locked ? null : onToggle,
      borderRadius: radius,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: radius,
          border: Border.all(
            color:
                open
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant,
            width: open ? 1.5 : 1,
          ),
          boxShadow:
              open
                  ? [
                    BoxShadow(
                      color: AppPalette.gradientEnd.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 12),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primary,
              ),
              child: Icon(
                done ? Icons.check_rounded : meta.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                meta.label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (locked)
              Row(
                children: [
                  const Icon(Icons.lock_rounded, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    lockedHint ?? 'Locked',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              )
            else
              Icon(
                open
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
              ),
          ],
        ),
      ),
    );

    final body = AnimatedCrossFade(
      crossFadeState:
          open ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 180),
      firstChild: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: radius,
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Save & Continue',
              onPressed: canContinue ? onContinue : null,
            ),
          ],
        ),
      ),
      secondChild: const SizedBox(height: 8),
    );

    return Opacity(
      opacity: locked ? 0.55 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(children: [header, body]),
      ),
    );
  }
}

/* ======================== STEP FORMS (LIGHTWEIGHT) ======================== */

class _PersonalForm extends StatefulWidget {
  const _PersonalForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<_PersonalForm> {
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
        _LabeledField(
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
              child: _LabeledField(
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
              child: _DateField(
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
        _Segmented<String>(
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
        _EmojiDropdown<String>(
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
        _MultiChip<String>(
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

class _FootballForm extends StatefulWidget {
  const _FootballForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_FootballForm> createState() => _FootballFormState();
}

class _FootballFormState extends State<_FootballForm> {
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
        _MultiChip<String>(
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
        _Segmented<String>(
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
          max: 300, // easy to slide to 100+
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
          max: 200, // easy to slide to 100+
          onChanged: (v) {
            setState(() => _weight = v);
            _notify();
          },
        ),
      ],
    );
  }
}

class _ContractForm extends StatefulWidget {
  const _ContractForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_ContractForm> createState() => _ContractFormState();
}

class _ContractFormState extends State<_ContractForm> {
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
        _LabeledField(
          label: 'Estimated Price / Salary',
          child: TextField(
            controller: _salary,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'e.g., 90000'),
          ),
        ),
        const SizedBox(height: 10),
        _EmojiDropdown<String>(
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
        _Segmented<String>(
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

class _StatsForm extends StatefulWidget {
  const _StatsForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_StatsForm> createState() => _StatsFormState();
}

class _StatsFormState extends State<_StatsForm> {
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
          max: 500, // easy to slide to 100+
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
          max: 500, // easy to slide to 100+
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
          max: 500, // easy to slide to 100+
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
          max: 300, // easy to slide to 100+
          onChanged: (v) {
            setState(() => yellow = v);
            _notify();
          },
        ),

        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Red Cards 🟥',
          value: yellow,
          min: 0,
          max: 300, // easy to slide to 100+
          onChanged: (v) {
            setState(() => yellow = v);
            _notify();
          },
        ),
      ],
    );
  }
}

class _InjuriesForm extends StatefulWidget {
  const _InjuriesForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_InjuriesForm> createState() => _InjuriesFormState();
}

class _InjuriesFormState extends State<_InjuriesForm> {
  final items = <_InjuryItem>[];
  void _notify() => widget.onValidChanged(true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          _EmojiDropdown<String>(
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
          _DateField(
            label: 'Date',
            value: items[i].date,
            onPick: (d) => setState(() => items[i].date = d),
          ),
          const SizedBox(height: 8),

          NumberWheelField(
            label: 'Recovery (weeks)',
            value: items[i].weeks,
            min: 0,
            max: 500, // easy to slide to 100+
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

class _AchievementsForm extends StatefulWidget {
  const _AchievementsForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_AchievementsForm> createState() => _AchievementsFormState();
}

class _AchievementsFormState extends State<_AchievementsForm> {
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
          max: 500, // easy to slide to 100+
          onChanged: (v) {
            setState(() => trophies = v);
            _notify();
          },
        ),
        const SizedBox(height: 10),
        _LabeledField(
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
              if (t.isNotEmpty)
                setState(() {
                  _awards.add(t);
                  _awardCtrl.clear();
                });
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

class _VideosForm extends StatefulWidget {
  const _VideosForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_VideosForm> createState() => _VideosFormState();
}

class _VideosFormState extends State<_VideosForm> {
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
        _LabeledField(
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
        _LabeledField(
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

class _VerificationForm extends StatefulWidget {
  const _VerificationForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<_VerificationForm> {
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

/* ======================== SMALL UI HELPERS ======================== */

class _StepMeta {
  final String label;
  final IconData icon;
  const _StepMeta(this.label, this.icon);
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme.labelLarge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(label, style: t), const SizedBox(height: 8), child],
    );
  }
}

class _EmojiDropdown<T> extends StatelessWidget {
  const _EmojiDropdown({
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final List<(String, String, T)> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return _LabeledField(
      label: label,
      child: DropdownButtonFormField<T>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: OutlineInputBorder(borderRadius: radius),
        ),
        items:
            items
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e.$3,
                    child: Row(
                      children: [
                        Text(e.$1, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(e.$2)),
                      ],
                    ),
                  ),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _Segmented<T> extends StatelessWidget {
  const _Segmented({
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final List<(String, String, T)> options;
  final T? value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return _LabeledField(
      label: label,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            options.map((o) {
              final selected = value == o.$3;
              return ChoiceChip(
                selected: selected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(o.$1), const SizedBox(width: 6), Text(o.$2)],
                ),
                onSelected: (_) => onChanged(o.$3),
              );
            }).toList(),
      ),
    );
  }
}

class _MultiChip<T> extends StatefulWidget {
  const _MultiChip({
    required this.label,
    required this.options,
    this.initial = const {},
    required this.onChanged,
  });
  final String label;
  final List<(String, String, T)> options;
  final Set<T> initial;
  final ValueChanged<Set<T>> onChanged;

  @override
  State<_MultiChip<T>> createState() => _MultiChipState<T>();
}

class _MultiChipState<T> extends State<_MultiChip<T>> {
  late Set<T> _sel = {...widget.initial};
  @override
  Widget build(BuildContext context) {
    return _LabeledField(
      label: widget.label,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            widget.options.map((o) {
              final selected = _sel.contains(o.$3);
              return FilterChip(
                selected: selected,
                onSelected: (v) {
                  setState(() => v ? _sel.add(o.$3) : _sel.remove(o.$3));
                  widget.onChanged(_sel);
                },
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(o.$1), const SizedBox(width: 6), Text(o.$2)],
                ),
              );
            }).toList(),
      ),
    );
  }
}

class NumberWheelField extends StatefulWidget {
  const NumberWheelField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 300,
  });

  final String label;
  final int value;
  final int min, max;
  final ValueChanged<int> onChanged;

  @override
  State<NumberWheelField> createState() => _NumberWheelFieldState();
}

class _NumberWheelFieldState extends State<NumberWheelField> {
  late int _current;
  late final PageController _pc;

  int get _initialPage =>
      (widget.value - widget.min).clamp(0, widget.max - widget.min);

  @override
  void initState() {
    super.initState();
    _current = widget.value;
    _pc = PageController(
      initialPage: _initialPage,
      viewportFraction: 0.22, // show ~4–5 values at once
    );
  }

  @override
  void didUpdateWidget(covariant NumberWheelField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _current) {
      _current = widget.value;
      _pc.jumpToPage(_initialPage);
    }
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Container(
          height: 64,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: radius,
          ),
          child: Stack(
            children: [
              // horizontal wheel
              AnimatedBuilder(
                animation: _pc,
                builder: (context, _) {
                  final page =
                      _pc.hasClients
                          ? _pc.page ?? _initialPage.toDouble()
                          : _initialPage.toDouble();
                  return PageView.builder(
                    controller: _pc,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.max - widget.min + 1,
                    onPageChanged: (idx) {
                      final val = widget.min + idx;
                      if (val != _current) {
                        setState(() => _current = val);
                        widget.onChanged(val);
                      }
                    },
                    itemBuilder: (context, idx) {
                      final num = widget.min + idx;
                      final dist = (idx - page).abs();
                      final scale = (1.0 - (dist * 0.25)).clamp(0.8, 1.0);
                      final opacity = (1.0 - (dist * 0.6)).clamp(0.3, 1.0);

                      return Center(
                        child: Opacity(
                          opacity: opacity,
                          child: Transform.scale(
                            scale: scale,
                            child: Text(
                              '$num',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              // center indicator + chevrons
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>((
                      states,
                    ) {
                      return Colors.white;
                    }),
                  ),
                  icon: const Icon(CupertinoIcons.chevron_left),
                  onPressed: () {
                    final p = (_pc.page ?? _initialPage.toDouble()).round();
                    if (p > 0) {
                      _pc.previousPage(
                        duration: const Duration(milliseconds: 160),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.chevron_right),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>((
                      states,
                    ) {
                      return Colors.white;
                    }),
                  ),
                  onPressed: () {
                    final p = (_pc.page ?? _initialPage.toDouble()).round();
                    final last = widget.max - widget.min;
                    if (p < last) {
                      _pc.nextPage(
                        duration: const Duration(milliseconds: 160),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onPick,
  });
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onPick;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return _LabeledField(
      label: label,
      child: InkWell(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime(now.year - 18, 1, 1),
            firstDate: DateTime(1960),
            lastDate: DateTime(now.year - 5),
          );
          onPick(picked);
        },
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            borderRadius: radius,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value == null
                      ? 'DD/MM/YYYY'
                      : '${value!.day}/${value!.month}/${value!.year}',
                ),
              ),
              const Icon(Icons.calendar_today_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _InjuryItem {
  String? type;
  DateTime? date;
  int weeks = 0;
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value, this.trackOpacity = .25});
  final double value; // 0..1
  final double trackOpacity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: LayoutBuilder(
        builder: (ctx, cons) {
          final w = cons.maxWidth * value.clamp(0, 1);
          return Stack(
            children: [
              // track
              Container(color: Colors.white.withOpacity(trackOpacity)),
              // animated fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: w,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =========== Mini Tracker ==============
class _MiniTrackerRail extends StatelessWidget {
  const _MiniTrackerRail({
    required this.total,
    required this.done,
    required this.current,
    required this.onTapStep,
    this.scale = 0.80, // 100% - 35% = 65%
  });

  final int total;
  final List<bool> done;
  final int current;
  final ValueChanged<int> onTapStep;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completed = done.where((e) => e).length;

    // scaled metrics
    final dotSize = 22.0 * scale; // 22 -> ~14.3
    final connectorW = 2.0 * scale; // 2  -> ~1.3
    final connectorH = 14.0 * scale; // 14 -> ~9.1
    final connectorMargin = 4.0 * scale; // 4  -> ~2.6
    final padV = 12.0 * scale; // 12 -> ~7.8
    final padH = 10.0 * scale; // 10 -> ~6.5
    final radius = 16.0 * scale; // 16 -> ~10.4
    final borderW = 1.0 * scale; // 1  -> ~0.65
    final shadowBlur = 14.0 * scale; // 14 -> ~9.1
    final shadowDy = 8.0 * scale; // 8  -> ~5.2
    final fontSize = dotSize * 0.6; // scales with circle

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 12.0 * scale),

        // Rail
        Container(
          padding: EdgeInsets.symmetric(vertical: padV, horizontal: padH),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
              width: borderW,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: shadowBlur,
                offset: Offset(0, shadowDy),
              ),
            ],
          ),
          child: Column(
            children: List.generate(total * 2 - 1, (i) {
              if (i.isOdd) {
                // connector
                final segIndex = (i ~/ 2);
                final filled = segIndex < completed - 1;
                return Container(
                  width: connectorW,
                  height: connectorH,
                  margin: EdgeInsets.symmetric(vertical: connectorMargin),
                  decoration: BoxDecoration(
                    color:
                        filled
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant.withOpacity(.6),
                    borderRadius: BorderRadius.circular(connectorW / 2),
                  ),
                );
              } else {
                // step dot
                final stepIndex = (i ~/ 2);
                final isDone = done[stepIndex];
                final isCurrent = stepIndex == current;
                final locked = stepIndex > done.lastIndexWhere((x) => x) + 1;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0 * scale),
                  child: InkWell(
                    onTap: locked ? null : () => onTapStep(stepIndex),
                    borderRadius: BorderRadius.circular(999),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: dotSize,
                      height: dotSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            (isDone || isCurrent) ? AppGradients.primary : null,
                        color:
                            (isDone || isCurrent)
                                ? null
                                : theme.colorScheme.surface,
                        border: Border.all(
                          color:
                              (isDone || isCurrent)
                                  ? Colors.transparent
                                  : theme.colorScheme.outlineVariant,
                          width: borderW,
                        ),
                      ),
                      child: Text(
                        isDone ? '✓' : '${stepIndex + 1}',
                        style: TextStyle(
                          fontSize: fontSize,
                          color:
                              (isDone || isCurrent)
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}
