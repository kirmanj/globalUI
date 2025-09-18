import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../theme/app_theme.dart'; // AppGradients, AppPalette

class KYCPassportCaptureScreen extends StatefulWidget {
  const KYCPassportCaptureScreen({super.key});

  @override
  State<KYCPassportCaptureScreen> createState() =>
      _KYCPassportCaptureScreenState();
}

class _KYCPassportCaptureScreenState extends State<KYCPassportCaptureScreen> {
  final _scroll = ScrollController();

  // All passports inline (first is primary by default)
  final List<_PassportData> _passports = [];
  int _primaryIndex = 0;

  @override
  void initState() {
    super.initState();
    _passports.add(_PassportData(isPrimary: true)); // first primary
  }

  @override
  void dispose() {
    for (final p in _passports) {
      p.dispose();
    }
    _scroll.dispose();
    super.dispose();
  }

  void _addPassport() {
    setState(() {
      _passports.add(_PassportData());
    });
    // scroll to bottom to reveal the newly added card
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 240,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _setPrimary(int i) {
    setState(() {
      _primaryIndex = i;
      for (int k = 0; k < _passports.length; k++) {
        _passports[k].isPrimary = (k == i);
      }
    });
  }

  void _removePassport(int i) {
    if (_passports.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one passport is required.')),
      );
      return;
    }
    final wasPrimary = i == _primaryIndex;
    setState(() {
      _passports.removeAt(i);
      if (wasPrimary) {
        _primaryIndex = 0;
        _passports[0].isPrimary = true;
      } else if (i < _primaryIndex) {
        _primaryIndex -= 1; // shift left
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionScaffold(
      title: 'KYC Verification — Passport',
      children: [
        // Gradient page intro
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Passports 📘',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Fill details first, then upload your passport photo.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Inline list of passports (first primary by default)
        SingleChildScrollView(
          controller: _scroll,
          child: Column(
            children: List.generate(_passports.length, (i) {
              final p = _passports[i];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: i == _passports.length - 1 ? 0 : 12,
                ),
                child: _PassportCard(
                  index: i,
                  data: p,
                  isPrimary: i == _primaryIndex,
                  onSetPrimary: () => _setPrimary(i),
                  onDelete:
                      i == _primaryIndex ? null : () => _removePassport(i),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 12),

        // Add another passport inline
        Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: _addPassport,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Add another passport'),
                  ),
                ),

                const SizedBox(height: 12),
                Text(
                  'Your data is encrypted and securely stored in compliance with regulations',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Positioned(
              left: -10,
              top: -20,
              child: SizedBox(
                width: 150,
                child: Image.asset(
                  'assets/images/kyc.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/* ===================== PASSPORT CARD ===================== */

class _PassportCard extends StatefulWidget {
  const _PassportCard({
    required this.index,
    required this.data,
    required this.isPrimary,
    required this.onSetPrimary,
    this.onDelete,
  });

  final int index;
  final _PassportData data;
  final bool isPrimary;
  final VoidCallback onSetPrimary;
  final VoidCallback? onDelete;

  @override
  State<_PassportCard> createState() => _PassportCardState();
}

class _PassportCardState extends State<_PassportCard> {
  bool get _detailsValid =>
      widget.data.number.text.trim().isNotEmpty &&
      widget.data.countryIso != null &&
      widget.data.dob != null &&
      widget.data.expiry != null;

  void _saveDetails() {
    if (!_detailsValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all passport details.')),
      );
      return;
    }
    setState(() => widget.data.saved = true);
  }

  void _editDetails() => setState(() => widget.data.saved = false);

  Future<void> _upload(bool camera) async {
    // TODO hook real picker
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(camera ? 'Open camera…' : 'Open gallery…')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final idx = widget.index + 1;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER
            Row(
              children: [
                // gradient icon chip
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.primary,
                  ),
                  alignment: Alignment.center,
                  child: const Text('📘', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Passport #$idx ${widget.isPrimary ? "(Primary)" : ""}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // Primary radio
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Primary', style: theme.textTheme.bodySmall),
                    const SizedBox(width: 6),
                    Radio<bool>(
                      value: true,
                      groupValue: widget.isPrimary,
                      onChanged: (_) => widget.onSetPrimary(),
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                if (widget.data.saved)
                  TextButton.icon(
                    onPressed: _editDetails,
                    icon: const Icon(Icons.edit_rounded, size: 18),
                    label: const Text('Edit'),
                  ),
                if (widget.onDelete != null) ...[
                  const SizedBox(width: 6),
                  IconButton(
                    tooltip: 'Remove',
                    onPressed: widget.onDelete,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),

            // STEP 1 — DETAILS
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _Labeled(
                          'Passport Number',
                          TextField(
                            controller: widget.data.number,
                            enabled: !widget.data.saved,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              hintText: 'e.g., A1234567',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _EmojiCountryField(
                          label: 'Country of Issue',
                          value: widget.data.countryIso,
                          onChanged:
                              widget.data.saved
                                  ? null
                                  : (v) => setState(
                                    () => widget.data.countryIso = v,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _DateField(
                          label: 'Date of Birth',
                          value: widget.data.dob,
                          onPick:
                              widget.data.saved
                                  ? (_) {}
                                  : (d) => setState(() => widget.data.dob = d),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _DateField(
                          label: 'Expiry Date',
                          value: widget.data.expiry,
                          onPick:
                              widget.data.saved
                                  ? (_) {}
                                  : (d) =>
                                      setState(() => widget.data.expiry = d),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryButton(
                      label: widget.data.saved ? 'Saved ✓' : 'Save details',
                      onPressed: widget.data.saved ? null : _saveDetails,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // STEP 2 — UPLOAD (enabled after details saved)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Upload from Gallery',
                          onPressed:
                              widget.data.saved ? () => _upload(false) : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SecondaryButton(
                          label: 'Take Photo',
                          onPressed:
                              widget.data.saved ? () => _upload(true) : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tips: good lighting, no glare, all edges visible.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ===================== INPUT HELPERS ===================== */

class _Labeled extends StatelessWidget {
  const _Labeled(this.label, this.child);
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

// Country dropdown with emoji flags
class _EmojiCountryField extends StatelessWidget {
  const _EmojiCountryField({
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final String? value;
  final ValueChanged<String?>? onChanged;

  static const _items = <(String emoji, String name, String iso)>[
    ('🇮🇶', 'Iraq', 'IQ'),
    ('🇸🇦', 'Saudi Arabia', 'SA'),
    ('🇹🇷', 'Turkey', 'TR'),
    ('🇬🇧', 'United Kingdom', 'GB'),
    ('🇪🇬', 'Egypt', 'EG'),
    ('🇺🇸', 'United States', 'US'),
  ];

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return _Labeled(
      label,
      DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        onChanged: onChanged, // null when saved (disabled)
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          border: OutlineInputBorder(borderRadius: radius),
        ),
        items:
            _items.map((e) {
              return DropdownMenuItem<String>(
                value: e.$3,
                child: Row(
                  children: [
                    Text(e.$1, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(e.$2)),
                  ],
                ),
              );
            }).toList(),
      ),
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
    return _Labeled(
      label,
      InkWell(
        onTap: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime(now.year - 18, 1, 1),
            firstDate: DateTime(1960),
            lastDate: DateTime(now.year + 30),
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

/* ===================== MODEL ===================== */

class _PassportData {
  final TextEditingController number = TextEditingController();
  String? countryIso;
  DateTime? dob;
  DateTime? expiry;
  bool saved = false;
  bool isPrimary;
  _PassportData({this.isPrimary = false});
  void dispose() => number.dispose();
}
