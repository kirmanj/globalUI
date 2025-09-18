import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:globalsportsmarket/screens/player/player_football_forms.dart'
    show
        PersonalForm,
        ContractForm,
        InjuriesForm,
        AchievementsForm,
        VideosForm,
        VerificationForm;

import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../theme/app_theme.dart';
import '../../widgets/wizard_ui.dart'; // StepMeta, WizardHeader, StepCard, MiniTrackerRail, Segmented, MultiChip, LabeledField, DateField, NumberWheelField

/* ============================================================
   UNIVERSAL PROFILE WIZARD
   - Step 0: Role & Sport selection (always first)
   - Remaining steps adapt to the chosen role/sport
   ============================================================ */

enum ProfileType {
  athlete,
  coach,
  physiotherapist,
  store,
  mainAgent,
  subAgent,
  club,
  academy,
  camp,
}

enum Sport {
  football,
  futsal,
  basketball,
  volleyball,
  handball,
  swimming,
  tennis,
}

class UniversalProfileWizard extends StatefulWidget {
  const UniversalProfileWizard({super.key});
  @override
  State<UniversalProfileWizard> createState() => _UniversalProfileWizardState();
}

class _UniversalProfileWizardState extends State<UniversalProfileWizard> {
  final _scroll = ScrollController();

  // Steps are mutable (not final) so we can rebuild them after the user chooses role/sport.
  late List<StepMeta> _steps;

  // Dynamic selection
  ProfileType? _type;
  Sport? _sport;

  // Step state
  int _open = 0;
  late List<bool> _done;
  late List<bool> _valid;

  @override
  void initState() {
    super.initState();
    // Start with just "Profile Type" step visible.
    _steps = [const StepMeta('Profile Type', Icons.account_tree_rounded)];
    _done = List<bool>.filled(_steps.length, false);
    _valid = List<bool>.filled(_steps.length, false);
  }

  // Recompute steps once role/sport changes.
  void _rebuildStepsForSelection() {
    final base = <StepMeta>[
      const StepMeta('Profile Type', Icons.account_tree_rounded),
    ];

    if (_type == null) {
      setState(() {
        _steps = base;
        _done = List<bool>.filled(_steps.length, false);
        _valid = List<bool>.filled(_steps.length, false);
        _open = 0;
      });
      return;
    }

    switch (_type!) {
      case ProfileType.athlete:
        base.addAll([
          const StepMeta('Personal', Icons.account_circle_rounded),
          _sportStepMetaFor(_sport),
          const StepMeta('Contract', Icons.attach_money_rounded),
          const StepMeta('Stats', Icons.bar_chart_rounded),
          const StepMeta('Injuries', Icons.medical_services_rounded),
          const StepMeta('Achievements', Icons.emoji_events_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.coach:
        base.addAll([
          const StepMeta('Personal', Icons.account_circle_rounded),
          const StepMeta('Coaching', Icons.school_rounded),
          const StepMeta('Licenses', Icons.badge_outlined),
          const StepMeta('Experience', Icons.timeline_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.physiotherapist:
        base.addAll([
          const StepMeta('Personal', Icons.account_circle_rounded),
          const StepMeta('Professional', Icons.healing_rounded),
          const StepMeta('Licenses', Icons.badge_outlined),
          const StepMeta('Case Studies', Icons.receipt_long_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.store:
        base.addAll([
          const StepMeta('Business', Icons.store_rounded),
          const StepMeta('Products & Services', Icons.shopping_bag_rounded),
          const StepMeta('Shipping', Icons.local_shipping_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.mainAgent:
        base.addAll([
          const StepMeta('Profile', Icons.person_pin_rounded),
          const StepMeta('Licensing / KYC', Icons.verified_rounded),
          const StepMeta('Portfolio', Icons.people_alt_rounded),
          const StepMeta('Services', Icons.handshake_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.subAgent:
        base.addAll([
          const StepMeta('Profile', Icons.person_pin_rounded),
          const StepMeta('Main Agent Link', Icons.link_rounded),
          const StepMeta('Portfolio', Icons.people_alt_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.club:
        base.addAll([
          const StepMeta('Club Info', Icons.sports_soccer_rounded),
          const StepMeta('Departments', Icons.category_rounded),
          const StepMeta('Divisions', Icons.groups_2_rounded),
          const StepMeta('Recruitment', Icons.search_rounded),
          const StepMeta('Facilities & Media', Icons.video_library_rounded),
          const StepMeta('Policies', Icons.policy_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.academy:
        base.addAll([
          const StepMeta('Academy Info', Icons.school_rounded),
          const StepMeta('Sports & Ages', Icons.escalator_warning_rounded),
          const StepMeta('Facilities', Icons.fitness_center_rounded),
          const StepMeta('Requirements', Icons.checklist_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;

      case ProfileType.camp:
        base.addAll([
          const StepMeta('Camp Info', Icons.terrain_rounded),
          const StepMeta('Schedule', Icons.calendar_today_rounded),
          const StepMeta('Sports & Services', Icons.sports_rounded),
          const StepMeta('Requirements', Icons.checklist_rounded),
          const StepMeta('Media', Icons.video_library_rounded),
          const StepMeta('Verification', Icons.verified_user_rounded),
        ]);
        break;
    }

    setState(() {
      _steps = base;
      _done = List<bool>.filled(_steps.length, false);
      _valid = List<bool>.filled(_steps.length, false);

      // ✅ step 0 validity mirrors the current selection
      _valid[0] =
          _type != null && (_type != ProfileType.athlete || _sport != null);

      // Optional UX: if step 0 valid, jump to step 1
      _open = 0;
      if (_valid[0] && _steps.length > 1) {
        _done[0] = true;
        _open = 1;
      }
    });
  }

  StepMeta _sportStepMetaFor(Sport? s) {
    switch (s) {
      case Sport.basketball:
        return const StepMeta('Basketball', Icons.sports_basketball_rounded);
      case Sport.volleyball:
        return const StepMeta('Volleyball', Icons.sports_volleyball_rounded);
      case Sport.handball:
        return const StepMeta('Handball', Icons.sports_handball_rounded);
      case Sport.futsal:
        return const StepMeta('Futsal', Icons.sports_soccer_rounded);
      case Sport.football:
        return const StepMeta('Football', Icons.sports_soccer_rounded);
      default:
        return const StepMeta('Sport', Icons.sports_rounded);
    }
  }

  void _setValid(int i, bool v) => setState(() => _valid[i] = v);

  double get _progress {
    if (_steps.isEmpty) return 0;
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
    Future.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final showRail = _progress < 1.0;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SectionScaffold(
            title: 'Create Your Profile',
            footer: Row(
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Save Draft"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label:
                        _done.isNotEmpty && _done.every((e) => e)
                            ? 'Finish'
                            : 'Save & Continue',
                    onPressed:
                        _done.isNotEmpty && _done.every((e) => e)
                            ? () {}
                            : _markDoneAndOpenNext,
                  ),
                ),
              ],
            ),
            children: [
              WizardHeader(
                title: _headerSubtitle(),
                steps: _steps,
                done: _done,
                open: _open,
                progress: _progress,
                onTapStep: (i) {
                  if (i <= _done.lastIndexWhere((x) => x) + 1) {
                    setState(() => _open = i);
                  }
                },
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, _) {
                  return SingleChildScrollView(
                    controller: _scroll,
                    child: Column(
                      children: List.generate(_steps.length, (i) {
                        final meta = _steps[i];
                        final open = _open == i;
                        final done = _done[i];
                        final locked = i > _done.lastIndexWhere((x) => x) + 1;

                        final child =
                            open
                                ? _buildStepBody(i, (ok) => _setValid(i, ok))
                                : const SizedBox.shrink();

                        return StepCard(
                          index: i,
                          meta: meta,
                          open: open,
                          done: done,
                          locked: locked,
                          lockedHint:
                              i == 1 &&
                                      _type == ProfileType.athlete &&
                                      _sport == null
                                  ? 'Pick sport to unlock'
                                  : 'Complete previous steps to unlock',
                          canContinue: _valid[i],
                          onContinue: _markDoneAndOpenNext,
                          onToggle: () => setState(() => _open = i),
                          child: child,
                        );
                      })..add(const SizedBox(height: 16)),
                    ),
                  );
                },
              ),
            ],
          ),

          // Mini progress rail
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
                            child: MiniTrackerRail(
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

  String _headerSubtitle() {
    if (_type == null)
      return 'Select your role and sport to personalize fields';
    final role = _labelForType(_type!);
    if (_type == ProfileType.athlete) {
      final s = _sport != null ? ' • ${_labelForSport(_sport!)}' : '';
      return '$role$s';
    }
    return role;
  }

  String _labelForType(ProfileType t) {
    switch (t) {
      case ProfileType.athlete:
        return 'Athlete';
      case ProfileType.coach:
        return 'Coach';
      case ProfileType.physiotherapist:
        return 'Medical Staff – Physiotherapist';
      case ProfileType.store:
        return 'Sports Market (Store)';
      case ProfileType.mainAgent:
        return 'Main Agent';
      case ProfileType.subAgent:
        return 'Sub Agent';
      case ProfileType.club:
        return 'Club';
      case ProfileType.academy:
        return 'Sports Academy';
      case ProfileType.camp:
        return 'Sport Camp';
    }
  }

  String _labelForSport(Sport s) {
    switch (s) {
      case Sport.football:
        return 'Football';
      case Sport.futsal:
        return 'Futsal';
      case Sport.basketball:
        return 'Basketball';
      case Sport.volleyball:
        return 'Volleyball';
      case Sport.handball:
        return 'Handball';
      case Sport.swimming:
        return 'Swimming';
      case Sport.tennis:
        return 'Tennis';
    }
  }

  /* ===================== Step body factory ===================== */

  Widget _buildStepBody(int stepIndex, ValueChanged<bool> onValid) {
    final title = _steps[stepIndex].label;

    // Step 0 is always "Profile Type"
    if (stepIndex == 0) {
      return _RoleSportSelector(
        selectedType: _type,
        selectedSport: _sport,
        onChanged: (t, s) {
          setState(() {
            _type = t;
            _sport = t == ProfileType.athlete ? s : null;

            // ✅ Step 0 is valid when role is chosen,
            // and if role == athlete, a sport must be chosen too
            _valid[0] =
                _type != null &&
                (_type != ProfileType.athlete || _sport != null);
          });

          _rebuildStepsForSelection(); // keep this
        },
      );
    }

    if (_type == ProfileType.athlete) {
      return _buildAthleteStep(title, onValid);
    }

    switch (_type!) {
      case ProfileType.coach:
        return _buildCoachStep(title, onValid);
      case ProfileType.physiotherapist:
        return _buildPhysioStep(title, onValid);
      case ProfileType.store:
        return _buildStoreStep(title, onValid);
      case ProfileType.mainAgent:
        return _buildMainAgentStep(title, onValid);
      case ProfileType.subAgent:
        return _buildSubAgentStep(title, onValid);
      case ProfileType.club:
        return _buildClubStep(title, onValid);
      case ProfileType.academy:
        return _buildAcademyStep(title, onValid);
      case ProfileType.camp:
        return _buildCampStep(title, onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Athlete flow ---------------- */
  Widget _buildAthleteStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Personal':
        return PersonalForm(onValidChanged: onValid);

      case 'Football':
      case 'Futsal':
      case 'Basketball':
      case 'Volleyball':
      case 'Handball':
      case 'Sport':
        if (_sport == null) {
          return const Text('Please select a sport above to continue.');
        }
        return _AthleteSportForm(sport: _sport!, onValidChanged: onValid);

      case 'Contract':
        return ContractForm(onValidChanged: onValid);

      case 'Stats':
        if (_sport == null) {
          return const Text('Please select a sport first to enter stats.');
        }
        return _AthleteStatsForm(sport: _sport!, onValidChanged: onValid);

      case 'Injuries':
        return InjuriesForm(onValidChanged: onValid);

      case 'Achievements':
        return AchievementsForm(onValidChanged: onValid);

      case 'Media':
        return VideosForm(onValidChanged: onValid);

      case 'Verification':
        return VerificationForm(onValidChanged: onValid);

      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Coach flow ---------------- */
  Widget _buildCoachStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Personal':
        return PersonalForm(onValidChanged: onValid);
      case 'Coaching':
        return _CoachForm(onValidChanged: onValid);
      case 'Licenses':
        return _SimpleListInput(
          label: 'Coaching Licenses / Certifications',
          hint: 'e.g., FINA Level 3, CPR/First Aid',
          onValidChanged: onValid,
        );
      case 'Experience':
        return _ExperienceYearsForm(onValidChanged: onValid);
      case 'Media':
        return VideosForm(onValidChanged: onValid);
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Physio flow ---------------- */
  Widget _buildPhysioStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Personal':
        return PersonalForm(onValidChanged: onValid);
      case 'Professional':
        return _PhysioProfessionalForm(onValidChanged: onValid);
      case 'Licenses':
        return _SimpleListInput(
          label: 'Medical Licenses',
          hint: 'e.g., FIFA Sports Medicine, Manual Therapist',
          onValidChanged: onValid,
        );
      case 'Case Studies':
        return _CaseStudyForm(onValidChanged: onValid);
      case 'Media':
        return VideosForm(onValidChanged: onValid);
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Store flow ---------------- */
  Widget _buildStoreStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Business':
        return _StoreBusinessForm(onValidChanged: onValid);
      case 'Products & Services':
        return _StoreProductsForm(onValidChanged: onValid);
      case 'Shipping':
        return _StoreShippingForm(onValidChanged: onValid);
      case 'Media':
        return VideosForm(onValidChanged: onValid);
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Main Agent flow ---------------- */
  Widget _buildMainAgentStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Profile':
        return _AgentProfileForm(onValidChanged: onValid, isMain: true);
      case 'Licensing / KYC':
        return _KycForm(
          onValidChanged: onValid,
          kycNote: 'KYC management: Yes',
        );
      case 'Portfolio':
        return _SimpleCounterForm(
          label: 'Assigned Sporters',
          min: 0,
          max: 1000,
          onValidChanged: onValid,
        );
      case 'Services':
        return _TagSelectorForm(
          label: 'Services Offered',
          tags: const [
            ('📄', 'Contract Negotiation'),
            ('⚖️', 'Legal Oversight'),
            ('🩺', 'Medical Oversight'),
            ('🔁', 'Transfer Management'),
            ('📢', 'Promotion'),
          ],
          onValidChanged: onValid,
        );
      case 'Media':
        return VideosForm(onValidChanged: onValid);
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Sub Agent flow ---------------- */
  Widget _buildSubAgentStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Profile':
        return _AgentProfileForm(onValidChanged: onValid, isMain: false);
      case 'Main Agent Link':
        return LabeledField(
          label: 'Main Agent',
          child: TextField(
            decoration: const InputDecoration(hintText: 'e.g., Omar Nasser'),
            onChanged: (t) => onValid(t.trim().isNotEmpty),
          ),
        );
      case 'Portfolio':
        return _SimpleCounterForm(
          label: 'Managed Sporters',
          min: 0,
          max: 1000,
          onValidChanged: onValid,
        );
      case 'Media':
        return VideosForm(onValidChanged: onValid);
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Club flow ---------------- */
  Widget _buildClubStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Club Info':
        return _ClubInfoForm(onValidChanged: onValid);
      case 'Departments':
        return _TagSelectorForm(
          label: 'Sports Departments',
          tags: const [
            ('⚽', 'Football'),
            ('🏐', 'Volleyball'),
            ('🥅', 'Futsal'),
            ('🏀', 'Basketball'),
            ('👩‍🦰', 'Women\'s Football'),
          ],
          onValidChanged: onValid,
        );
      case 'Divisions':
        return _SimpleListInput(
          label: 'Club Divisions',
          hint: 'e.g., First Team, U21, U18',
          onValidChanged: onValid,
        );
      case 'Recruitment':
        return _SimpleListInput(
          label: 'Currently Looking For',
          hint: 'e.g., GK (U18), Youth Medical Trainer',
          onValidChanged: onValid,
        );
      case 'Facilities & Media':
        return Column(
          children: [
            _SimpleListInput(
              label: 'Facilities',
              hint: 'e.g., Stadium, Rehab Center, Indoor Field',
              onValidChanged: (_) {},
            ),
            const SizedBox(height: 10),
            VideosForm(onValidChanged: onValid),
          ],
        );
      case 'Policies':
        return LabeledField(
          label: 'Transfer Policy',
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'e.g., Via platform-verified agents only',
            ),
            onChanged: (t) => onValid(t.trim().isNotEmpty),
          ),
        );
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Academy flow ---------------- */
  Widget _buildAcademyStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Academy Info':
        return _AcademyInfoForm(onValidChanged: onValid);
      case 'Sports & Ages':
        return Column(
          children: [
            _TagSelectorForm(
              label: 'Sports Offered',
              tags: const [('⚽', 'Football'), ('🏐', 'Volleyball')],
              onValidChanged: (_) {},
            ),
            const SizedBox(height: 10),
            _TagSelectorForm(
              label: 'Age Groups',
              tags: const [('👶', 'U10'), ('🧒', 'U14'), ('🧑', 'U18')],
              onValidChanged: onValid,
            ),
          ],
        );
      case 'Facilities':
        return _SimpleListInput(
          label: 'Facilities',
          hint: 'e.g., Stadium, Gym, Indoor Court',
          onValidChanged: onValid,
        );
      case 'Requirements':
        return _SimpleListInput(
          label: 'Registration Requirements',
          hint:
              'e.g., Fee, Parent Consent, Medical Certificate, Transportation',
          onValidChanged: onValid,
        );
      case 'Media':
        return VideosForm(onValidChanged: onValid);
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }

  /* ---------------- Camp flow ---------------- */
  Widget _buildCampStep(String title, ValueChanged<bool> onValid) {
    switch (title) {
      case 'Camp Info':
        return _CampInfoForm(onValidChanged: onValid);
      case 'Schedule':
        return LabeledField(
          label: 'Season / Duration',
          child: TextField(
            decoration: const InputDecoration(hintText: 'e.g., June–August'),
            onChanged: (t) => onValid(t.trim().isNotEmpty),
          ),
        );
      case 'Sports & Services':
        return Column(
          children: [
            _TagSelectorForm(
              label: 'Sports',
              tags: const [
                ('⚽', 'Football'),
                ('🏊', 'Swimming'),
                ('🎾', 'Tennis'),
              ],
              onValidChanged: (_) {},
            ),
            const SizedBox(height: 10),
            _SimpleListInput(
              label: 'Included Services',
              hint: 'e.g., Hotel, Meals, 2 daily sessions, Friendlies',
              onValidChanged: onValid,
            ),
          ],
        );
      case 'Requirements':
        return _SimpleListInput(
          label: 'Requirements',
          hint: 'e.g., Passport, Health Check',
          onValidChanged: onValid,
        );
      case 'Media':
        return VideosForm(onValidChanged: onValid);
      case 'Verification':
        return VerificationForm(onValidChanged: onValid);
      default:
        return const SizedBox.shrink();
    }
  }
}

/* ============================================================
   Step 0: Role & Sport Selector
   (Uses Segmented from your wizard_ui.dart)
   ============================================================ */

class _RoleSportSelector extends StatefulWidget {
  const _RoleSportSelector({
    required this.selectedType,
    required this.selectedSport,
    required this.onChanged,
  });
  final ProfileType? selectedType;
  final Sport? selectedSport;
  final void Function(ProfileType?, Sport?) onChanged;

  @override
  State<_RoleSportSelector> createState() => _RoleSportSelectorState();
}

class _RoleSportSelectorState extends State<_RoleSportSelector> {
  ProfileType? _type;
  Sport? _sport;

  @override
  void initState() {
    super.initState();
    _type = widget.selectedType;
    _sport = widget.selectedSport;
  }

  @override
  Widget build(BuildContext context) {
    final typeOpts = const [
      ('🏃', 'Athlete', ProfileType.athlete),
      ('🎓', 'Coach', ProfileType.coach),
      ('🩺', 'Physiotherapist', ProfileType.physiotherapist),
      ('🏬', 'Store', ProfileType.store),
      ('🧑‍⚖️', 'Main Agent', ProfileType.mainAgent),
      ('🤝', 'Sub Agent', ProfileType.subAgent),
      ('🏟️', 'Club', ProfileType.club),
      ('🏫', 'Academy', ProfileType.academy),
      ('🏕️', 'Camp', ProfileType.camp),
    ];

    final sportOpts = const [
      ('⚽', 'Football', Sport.football),
      ('🥅', 'Futsal', Sport.futsal),
      ('🏀', 'Basketball', Sport.basketball),
      ('🏐', 'Volleyball', Sport.volleyball),
      ('🤾', 'Handball', Sport.handball),
      ('🏊', 'Swimming', Sport.swimming),
      ('🎾', 'Tennis', Sport.tennis),
    ];

    return Column(
      children: [
        Segmented<ProfileType>(
          label: 'Select Role',
          value: _type,
          options: typeOpts,
          onChanged: (v) {
            setState(() => _type = v);
            widget.onChanged(
              _type,
              _type == ProfileType.athlete ? _sport : null,
            );
          },
        ),
        const SizedBox(height: 10),
        Opacity(
          opacity: _type == ProfileType.athlete ? 1 : .5,
          child: IgnorePointer(
            ignoring: _type != ProfileType.athlete,
            child: Segmented<Sport>(
              label: 'Select Sport',
              value: _sport,
              options: sportOpts,
              onChanged: (v) {
                setState(() => _sport = v);
                widget.onChanged(_type, _sport);
              },
            ),
          ),
        ),
      ],
    );
  }
}

/* ============================================================
   Athlete: Sport Form (positions, hand/foot, height/weight, club, since)
   ============================================================ */

class _AthleteSportForm extends StatefulWidget {
  const _AthleteSportForm({required this.sport, required this.onValidChanged});
  final Sport sport;
  final ValueChanged<bool> onValidChanged;

  @override
  State<_AthleteSportForm> createState() => _AthleteSportFormState();
}

class _AthleteSportFormState extends State<_AthleteSportForm> {
  final _positions = <String>{};
  String? _handOrFoot;
  int _height = 175;
  int _weight = 70;
  final _club = TextEditingController();
  DateTime? _since;

  @override
  void initState() {
    super.initState();
    _club.addListener(_validate);
  }

  void _validate() {
    final ok =
        _positions.isNotEmpty &&
        _handOrFoot != null &&
        _height > 0 &&
        _weight > 0 &&
        _since != null;
    widget.onValidChanged(ok);
  }

  List<(String, String, String)> _positionOptions() {
    switch (widget.sport) {
      case Sport.football:
      case Sport.futsal:
        return const [
          ('🎯', 'Striker', 'ST'),
          ('🧠', 'Attacking Mid', 'CAM'),
          ('🛡️', 'Defensive Mid', 'CDM'),
          ('🪽', 'Left Wing', 'LW'),
          ('🪽', 'Right Wing', 'RW'),
          ('🪨', 'Center Back', 'CB'),
          ('🧤', 'Goalkeeper', 'GK'),
          // Futsal extras
          ('🛑', 'Fixo', 'FIXO'),
          ('🪽', 'Ala (Left)', 'ALA_L'),
          ('🪽', 'Ala (Right)', 'ALA_R'),
          ('🎯', 'Pivot', 'PIVOT'),
        ];
      case Sport.basketball:
        return const [
          ('1', 'Point Guard (PG)', 'PG'),
          ('2', 'Shooting Guard (SG)', 'SG'),
          ('3', 'Small Forward (SF)', 'SF'),
          ('4', 'Power Forward (PF)', 'PF'),
          ('5', 'Center (C)', 'C'),
        ];
      case Sport.volleyball:
        return const [
          ('🏹', 'Outside Hitter (OH)', 'OH'),
          ('🛡️', 'Opposite (OPP)', 'OPP'),
          ('⬆️', 'Setter (S)', 'S'),
          ('🧱', 'Middle Blocker (MB)', 'MB'),
          ('🦺', 'Libero (L)', 'L'),
        ];
      case Sport.handball:
        return const [
          ('⬅️', 'Left Wing (LW)', 'LW'),
          ('➡️', 'Right Wing (RW)', 'RW'),
          ('🧠', 'Centre Back (CB)', 'CB'),
          ('⬅️', 'Left Back (LB)', 'LB'),
          ('➡️', 'Right Back (RB)', 'RB'),
          ('🧤', 'Goalkeeper (GK)', 'GK'),
        ];
      default:
        return const [];
    }
  }

  List<(String, String, String)> _handOrFootOptions() {
    switch (widget.sport) {
      case Sport.football:
      case Sport.futsal:
        return const [
          ('🦶', 'Left', 'L'),
          ('🦶', 'Right', 'R'),
          ('🦶', 'Both', 'B'),
        ];
      default:
        return const [
          ('✋', 'Left', 'L'),
          ('🤚', 'Right', 'R'),
          ('👐', 'Both', 'B'),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiChip<String>(
          label: 'Preferred Positions',
          options: _positionOptions(),
          onChanged: (s) {
            setState(() {
              _positions
                ..clear()
                ..addAll(s);
            });
            _validate();
          },
        ),
        const SizedBox(height: 10),
        Segmented<String>(
          label:
              (widget.sport == Sport.football || widget.sport == Sport.futsal)
                  ? 'Preferred Foot'
                  : 'Dominant Hand',
          value: _handOrFoot,
          options: _handOrFootOptions(),
          onChanged: (v) {
            setState(() => _handOrFoot = v);
            _validate();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Height (cm)',
          value: _height,
          min: 120,
          max: 230,
          onChanged: (v) {
            setState(() => _height = v);
            _validate();
          },
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Weight (kg)',
          value: _weight,
          min: 35,
          max: 160,
          onChanged: (v) {
            setState(() => _weight = v);
            _validate();
          },
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Current Club / Team',
          child: TextField(
            controller: _club,
            decoration: const InputDecoration(
              hintText: 'e.g., Free Agent / Al-Wasl',
            ),
          ),
        ),
        const SizedBox(height: 10),
        DateField(
          label: 'Playing Since',
          value: _since,
          onPick: (d) {
            setState(() => _since = d);
            _validate();
          },
        ),
      ],
    );
  }
}

/* ============================================================
   Athlete: Stats (sport-specific quick fields)
   ============================================================ */

class _AthleteStatsForm extends StatefulWidget {
  const _AthleteStatsForm({required this.sport, required this.onValidChanged});
  final Sport sport;
  final ValueChanged<bool> onValidChanged;
  @override
  State<_AthleteStatsForm> createState() => _AthleteStatsFormState();
}

class _AthleteStatsFormState extends State<_AthleteStatsForm> {
  final Map<String, int> _int = {};
  final Map<String, double> _double = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onValidChanged(true);
    });
  }

  void _setInt(String k, int v) => setState(() => _int[k] = v);
  void _setDouble(String k, double v) => setState(() => _double[k] = v);

  Widget _numField(String label, String key, {int min = 0, int max = 500}) {
    final v = _int[key] ?? 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: NumberWheelField(
        label: label,
        value: v,
        min: min,
        max: max,
        onChanged: (x) => _setInt(key, x),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.sport) {
      case Sport.football:
      case Sport.futsal:
        return Column(
          children: [
            _numField('Matches', 'matches', max: 200),
            _numField('Goals', 'goals', max: 200),
            _numField('Assists', 'assists', max: 200),
            _numField('Key Passes (Futsal)', 'keypasses', max: 200),
            _numField('Yellow Cards', 'yellow', max: 50),
            _numField('Red Cards', 'red', max: 20),
          ],
        );
      case Sport.basketball:
        return Column(
          children: [
            _numField('Matches', 'matches', max: 82),
            _numField('Total Points', 'points', max: 2000),
            _numField('Assists', 'assists', max: 800),
            _numField('Rebounds', 'reb', max: 1000),
            _numField('Steals', 'stl', max: 200),
            _numField('Blocks', 'blk', max: 200),
            _PercentField(
              label: '3PT %',
              onChanged: (v) => _setDouble('3pt', v),
            ),
            _PercentField(
              label: 'Free Throw %',
              onChanged: (v) => _setDouble('ft', v),
            ),
          ],
        );
      case Sport.volleyball:
        return Column(
          children: [
            _numField('Matches', 'matches', max: 60),
            _numField('Aces', 'aces', max: 200),
            _numField('Kills', 'kills', max: 500),
            _numField('Blocks', 'blocks', max: 300),
            _numField('Assists', 'assists', max: 300),
            _PercentField(
              label: 'Serve Reception Success %',
              onChanged: (v) => _setDouble('recv', v),
            ),
          ],
        );
      case Sport.handball:
        return Column(
          children: [
            _numField('Matches', 'matches', max: 50),
            _numField('Goals', 'goals', max: 250),
            _numField('Assists', 'assists', max: 200),
            _numField('Blocks', 'blocks', max: 150),
            _numField('Steals', 'steals', max: 150),
            _numField('Yellow Cards', 'yellow', max: 30),
            _numField('Red Cards', 'red', max: 10),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _PercentField extends StatefulWidget {
  const _PercentField({required this.label, required this.onChanged});
  final String label;
  final ValueChanged<double> onChanged;

  @override
  State<_PercentField> createState() => _PercentFieldState();
}

class _PercentFieldState extends State<_PercentField> {
  double _v = 0;
  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: widget.label,
      child: Row(
        children: [
          Expanded(
            child: Slider(
              value: _v,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (x) {
                setState(() => _v = x);
                widget.onChanged(x);
              },
            ),
          ),
          SizedBox(width: 60, child: Text('${_v.toStringAsFixed(1)}%')),
        ],
      ),
    );
  }
}

/* ===================== Coach ===================== */

class _CoachForm extends StatefulWidget {
  const _CoachForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_CoachForm> createState() => _CoachFormState();
}

class _CoachFormState extends State<_CoachForm> {
  final _special = <String>{};
  final _club = TextEditingController();
  int _years = 1;

  @override
  void initState() {
    super.initState();
    _club.addListener(_validate);
  }

  void _validate() => widget.onValidChanged(
    _special.isNotEmpty && _club.text.trim().isNotEmpty && _years > 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiChip<String>(
          label: 'Coaching Specialization',
          options: const [
            ('⚽', 'Football', 'football'),
            ('🏀', 'Basketball', 'basketball'),
            ('🏐', 'Volleyball', 'volleyball'),
            ('🏊', 'Swimming', 'swimming'),
            ('👶', 'U12', 'u12'),
            ('🧑', 'U18', 'u18'),
            ('👨', 'Adults', 'adults'),
          ],
          onChanged: (s) {
            _special
              ..clear()
              ..addAll(s);
            _validate();
          },
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Current Club / Independent',
          child: TextField(
            controller: _club,
            decoration: const InputDecoration(hintText: 'e.g., Independent'),
          ),
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Years of Experience',
          value: _years,
          min: 0,
          max: 50,
          onChanged: (v) {
            setState(() => _years = v);
            _validate();
          },
        ),
      ],
    );
  }
}

class _ExperienceYearsForm extends StatefulWidget {
  const _ExperienceYearsForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_ExperienceYearsForm> createState() => _ExperienceYearsFormState();
}

class _ExperienceYearsFormState extends State<_ExperienceYearsForm> {
  int _years = 1;
  @override
  Widget build(BuildContext context) {
    return NumberWheelField(
      label: 'Total Coaching Experience (Years)',
      value: _years,
      min: 0,
      max: 60,
      onChanged: (v) {
        setState(() => _years = v);
        widget.onValidChanged(true);
      },
    );
  }
}

/* ===================== Physiotherapist ===================== */

class _PhysioProfessionalForm extends StatefulWidget {
  const _PhysioProfessionalForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_PhysioProfessionalForm> createState() =>
      _PhysioProfessionalFormState();
}

class _PhysioProfessionalFormState extends State<_PhysioProfessionalForm> {
  final _areas = <String>{};
  final _affil = TextEditingController();
  int _years = 1;

  @override
  void initState() {
    super.initState();
    _affil.addListener(_validate);
  }

  void _validate() => widget.onValidChanged(
    _areas.isNotEmpty && _affil.text.trim().isNotEmpty && _years > 0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiChip<String>(
          label: 'Areas of Expertise',
          options: const [
            ('🦵', 'ACL/MCL Recovery', 'acl'),
            ('🎗️', 'Neuromuscular Taping', 'nmt'),
            ('🛠️', 'Post-Surgical Rehab', 'rehab'),
            ('🏃', 'Return-to-Play', 'rtp'),
          ],
          onChanged: (s) {
            _areas
              ..clear()
              ..addAll(s);
            _validate();
          },
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Affiliation / Club',
          child: TextField(
            controller: _affil,
            decoration: const InputDecoration(
              hintText: 'e.g., Al-Shorta Baghdad',
            ),
          ),
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Years of Experience',
          value: _years,
          min: 0,
          max: 40,
          onChanged: (v) {
            setState(() => _years = v);
            _validate();
          },
        ),
      ],
    );
  }
}

class _CaseStudyForm extends StatefulWidget {
  const _CaseStudyForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_CaseStudyForm> createState() => _CaseStudyFormState();
}

class _CaseStudyFormState extends State<_CaseStudyForm> {
  // Use tuples correctly; don't access .title/.duration as properties.
  final _items = <(String, String)>[]; // (title, duration/notes)

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _items.length; i++) ...[
          LabeledField(
            label: 'Case Study Title',
            child: TextField(
              controller: TextEditingController(text: _items[i].$1),
              onChanged: (t) => _items[i] = (t, _items[i].$2),
            ),
          ),
          const SizedBox(height: 8),
          LabeledField(
            label: 'Duration / Notes',
            child: TextField(
              controller: TextEditingController(text: _items[i].$2),
              onChanged: (t) => _items[i] = (_items[i].$1, t),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => setState(() => _items.removeAt(i)),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Remove'),
            ),
          ),
          const SizedBox(height: 8),
        ],
        OutlinedButton.icon(
          onPressed: () {
            setState(() => _items.add(('ACL Rehab Drills', '6 months')));
            widget.onValidChanged(true);
          },
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Case Study'),
        ),
      ],
    );
  }
}

/* ===================== Store ===================== */

class _StoreBusinessForm extends StatefulWidget {
  const _StoreBusinessForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_StoreBusinessForm> createState() => _StoreBusinessFormState();
}

class _StoreBusinessFormState extends State<_StoreBusinessForm> {
  final _name = TextEditingController();
  final _loc = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.addListener(_v);
    _loc.addListener(_v);
  }

  void _v() => widget.onValidChanged(
    _name.text.trim().isNotEmpty && _loc.text.trim().isNotEmpty,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(
          label: 'Store Name',
          child: TextField(
            controller: _name,
            decoration: const InputDecoration(hintText: 'ProFit Gear'),
          ),
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Location',
          child: TextField(
            controller: _loc,
            decoration: const InputDecoration(hintText: 'Dubai, UAE'),
          ),
        ),
      ],
    );
  }
}

class _StoreProductsForm extends StatefulWidget {
  const _StoreProductsForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_StoreProductsForm> createState() => _StoreProductsFormState();
}

class _StoreProductsFormState extends State<_StoreProductsForm> {
  final _products = <String>[];
  final _services = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SimpleListInput(
          label: 'Products',
          hint: 'e.g., Jerseys, Gear, Shoes',
          onValidChanged: (_) {},
          onListChanged: (lst) {
            _products
              ..clear()
              ..addAll(lst);
          },
        ),
        const SizedBox(height: 10),
        _SimpleListInput(
          label: 'Services',
          hint: 'e.g., Customization (Logos, Names, Numbers), Team Orders',
          onValidChanged: (ok) => widget.onValidChanged(ok),
          onListChanged: (lst) {
            _services
              ..clear()
              ..addAll(lst);
          },
        ),
      ],
    );
  }
}

class _StoreShippingForm extends StatefulWidget {
  const _StoreShippingForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_StoreShippingForm> createState() => _StoreShippingFormState();
}

class _StoreShippingFormState extends State<_StoreShippingForm> {
  final _regions = <String>{};

  @override
  Widget build(BuildContext context) {
    return _TagSelectorForm(
      label: 'Shipping Regions',
      tags: const [
        ('🌍', 'Middle East'),
        ('🇪🇺', 'Europe'),
        ('🇺🇸', 'North America'),
        ('🌏', 'Asia-Pacific'),
      ],
      onValidChanged: (ok) => widget.onValidChanged(ok),
      onChanged: (set) {
        _regions
          ..clear()
          ..addAll(set);
      },
    );
  }
}

/* ===================== Agents ===================== */

class _AgentProfileForm extends StatefulWidget {
  const _AgentProfileForm({required this.onValidChanged, required this.isMain});
  final ValueChanged<bool> onValidChanged;
  final bool isMain;

  @override
  State<_AgentProfileForm> createState() => _AgentProfileFormState();
}

class _AgentProfileFormState extends State<_AgentProfileForm> {
  final _name = TextEditingController();
  final _country = TextEditingController();
  final _lang = <String>{'ar', 'en'};
  int _years = 1;
  double _wallet = 0;

  @override
  void initState() {
    super.initState();
    _name.addListener(_v);
    _country.addListener(_v);
  }

  void _v() => widget.onValidChanged(
    _name.text.trim().isNotEmpty && _country.text.trim().isNotEmpty,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(label: 'Name', child: TextField(controller: _name)),
        const SizedBox(height: 10),
        LabeledField(label: 'Country', child: TextField(controller: _country)),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Years of Experience',
          value: _years,
          min: 0,
          max: 40,
          onChanged: (v) => setState(() => _years = v),
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Wallet Balance (USD)',
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'e.g., 1270'),
            onChanged: (t) => setState(() => _wallet = double.tryParse(t) ?? 0),
          ),
        ),
        const SizedBox(height: 10),
        MultiChip<String>(
          label: 'Languages',
          options: const [
            ('🇦🇪', 'Arabic', 'ar'),
            ('🇬🇧', 'English', 'en'),
            ('🇫🇷', 'French', 'fr'),
          ],
          initial: _lang,
          onChanged:
              (s) =>
                  _lang
                    ..clear()
                    ..addAll(s),
        ),
      ],
    );
  }
}

class _KycForm extends StatefulWidget {
  const _KycForm({required this.onValidChanged, this.kycNote});
  final ValueChanged<bool> onValidChanged;
  final String? kycNote;
  @override
  State<_KycForm> createState() => _KycFormState();
}

class _KycFormState extends State<_KycForm> {
  bool _doc1 = false, _doc2 = false;

  @override
  Widget build(BuildContext context) {
    final note = widget.kycNote;
    final ok = _doc1 && _doc2;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onValidChanged(ok);
    });

    return Column(
      children: [
        if (note != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(note, style: Theme.of(context).textTheme.bodySmall),
          ),
        OutlinedButton.icon(
          onPressed: () => setState(() => _doc1 = true),
          icon: const Icon(Icons.upload_file_rounded),
          label: const Text('Upload Agent License'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => setState(() => _doc2 = true),
          icon: const Icon(Icons.upload_file_rounded),
          label: const Text('Upload National ID / Passport'),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              ok ? Icons.check_circle : Icons.info_outline,
              color: ok ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 6),
            Text(ok ? 'KYC ready' : 'Please upload both documents'),
          ],
        ),
      ],
    );
  }
}

/* ===================== Club ===================== */

class _ClubInfoForm extends StatefulWidget {
  const _ClubInfoForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_ClubInfoForm> createState() => _ClubInfoFormState();
}

class _ClubInfoFormState extends State<_ClubInfoForm> {
  final _name = TextEditingController();
  final _country = TextEditingController();
  final _city = TextEditingController();
  int _founded = 1960;
  String _type = 'Professional';

  @override
  void initState() {
    super.initState();
    for (final c in [_name, _country, _city]) {
      c.addListener(() {
        widget.onValidChanged(
          _name.text.trim().isNotEmpty &&
              _country.text.trim().isNotEmpty &&
              _city.text.trim().isNotEmpty,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(label: 'Club Name', child: TextField(controller: _name)),
        const SizedBox(height: 10),
        LabeledField(label: 'Country', child: TextField(controller: _country)),
        const SizedBox(height: 10),
        LabeledField(label: 'City', child: TextField(controller: _city)),
        const SizedBox(height: 10),
        Segmented<String>(
          label: 'Type',
          value: _type,
          options: const [
            ('🏆', 'Professional', 'Professional'),
            ('🎓', 'Academy/Youth', 'Academy'),
          ],
          onChanged: (v) => setState(() => _type = v),
        ),
        const SizedBox(height: 10),
        NumberWheelField(
          label: 'Founded',
          value: _founded,
          min: 1900,
          max: DateTime.now().year,
          onChanged: (v) => setState(() => _founded = v),
        ),
      ],
    );
  }
}

/* ===================== Academy ===================== */

class _AcademyInfoForm extends StatefulWidget {
  const _AcademyInfoForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_AcademyInfoForm> createState() => _AcademyInfoFormState();
}

class _AcademyInfoFormState extends State<_AcademyInfoForm> {
  final _name = TextEditingController();
  final _country = TextEditingController();
  bool _male = true, _female = true;

  @override
  void initState() {
    super.initState();
    _name.addListener(_v);
    _country.addListener(_v);
  }

  void _v() => widget.onValidChanged(
    _name.text.trim().isNotEmpty && _country.text.trim().isNotEmpty,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(
          label: 'Academy Name',
          child: TextField(controller: _name),
        ),
        const SizedBox(height: 10),
        LabeledField(label: 'Country', child: TextField(controller: _country)),
        const SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
              value: _male,
              onChanged: (v) => setState(() => _male = v ?? false),
            ),
            const Text('Male'),
            const SizedBox(width: 12),
            Checkbox(
              value: _female,
              onChanged: (v) => setState(() => _female = v ?? false),
            ),
            const Text('Female'),
          ],
        ),
      ],
    );
  }
}

/* ===================== Camp ===================== */

class _CampInfoForm extends StatefulWidget {
  const _CampInfoForm({required this.onValidChanged});
  final ValueChanged<bool> onValidChanged;
  @override
  State<_CampInfoForm> createState() => _CampInfoFormState();
}

class _CampInfoFormState extends State<_CampInfoForm> {
  final _name = TextEditingController();
  final _loc = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.addListener(_v);
    _loc.addListener(_v);
  }

  void _v() => widget.onValidChanged(
    _name.text.trim().isNotEmpty && _loc.text.trim().isNotEmpty,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(
          label: 'Camp Name',
          child: TextField(
            controller: _name,
            decoration: const InputDecoration(
              hintText: 'Mediterranean Elite Camp',
            ),
          ),
        ),
        const SizedBox(height: 10),
        LabeledField(
          label: 'Location',
          child: TextField(
            controller: _loc,
            decoration: const InputDecoration(hintText: 'Antalya, Turkey'),
          ),
        ),
      ],
    );
  }
}

/* ===================== Small helpers for lists/tags ===================== */

class _SimpleListInput extends StatefulWidget {
  const _SimpleListInput({
    required this.label,
    required this.hint,
    required this.onValidChanged,
    this.onListChanged,
  });
  final String label;
  final String hint;
  final ValueChanged<bool> onValidChanged;
  final ValueChanged<List<String>>? onListChanged;

  @override
  State<_SimpleListInput> createState() => _SimpleListInputState();
}

class _SimpleListInputState extends State<_SimpleListInput> {
  final _ctrl = TextEditingController();
  final _items = <String>[];

  void _push() {
    final t = _ctrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _items.add(t);
      _ctrl.clear();
    });
    widget.onValidChanged(_items.isNotEmpty);
    widget.onListChanged?.call(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledField(
          label: widget.label,
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: IconButton(
                onPressed: _push,
                icon: const Icon(Icons.add_rounded),
              ),
            ),
            onSubmitted: (_) => _push(),
          ),
        ),
        const SizedBox(height: 8),
        if (_items.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _items
                    .map(
                      (e) => Chip(
                        label: Text(e),
                        onDeleted: () {
                          setState(() => _items.remove(e));
                          widget.onValidChanged(_items.isNotEmpty);
                          widget.onListChanged?.call(_items);
                        },
                      ),
                    )
                    .toList(),
          ),
      ],
    );
  }
}

class _SimpleCounterForm extends StatefulWidget {
  const _SimpleCounterForm({
    required this.label,
    required this.min,
    required this.max,
    required this.onValidChanged,
  });
  final String label;
  final int min, max;
  final ValueChanged<bool> onValidChanged;

  @override
  State<_SimpleCounterForm> createState() => _SimpleCounterFormState();
}

class _SimpleCounterFormState extends State<_SimpleCounterForm> {
  int _v = 0;
  @override
  Widget build(BuildContext context) {
    return NumberWheelField(
      label: widget.label,
      value: _v,
      min: widget.min,
      max: widget.max,
      onChanged: (x) {
        setState(() => _v = x);
        widget.onValidChanged(true);
      },
    );
  }
}

class _TagSelectorForm extends StatefulWidget {
  const _TagSelectorForm({
    required this.label,
    required this.tags,
    required this.onValidChanged,
    this.onChanged,
  });
  final String label;
  final List<(String, String)> tags; // (emoji, label)
  final ValueChanged<bool> onValidChanged;
  final ValueChanged<Set<String>>? onChanged;

  @override
  State<_TagSelectorForm> createState() => _TagSelectorFormState();
}

class _TagSelectorFormState extends State<_TagSelectorForm> {
  final _sel = <String>{};
  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: widget.label,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            widget.tags.map((t) {
              final selected = _sel.contains(t.$2);
              return FilterChip(
                selected: selected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(t.$1), const SizedBox(width: 6), Text(t.$2)],
                ),
                onSelected: (v) {
                  setState(() => v ? _sel.add(t.$2) : _sel.remove(t.$2));
                  widget.onValidChanged(_sel.isNotEmpty);
                  widget.onChanged?.call(_sel);
                },
              );
            }).toList(),
      ),
    );
  }
}
