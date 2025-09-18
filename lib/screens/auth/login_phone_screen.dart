import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';

import '../../theme/app_theme.dart'; // AppPalette, AppGradients

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.keyboardType,
    this.trailing,
    this.prefix,
    this.maxLines = 1,
  });

  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final Widget? trailing;
  final Widget? prefix;
  final int maxLines;

  InputDecoration _fieldDecoration(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return InputDecoration(
      hintText: hint,
      isDense: true, // keep height tight
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: radius),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
      prefixIcon: prefix,
      suffixIcon: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: _fieldDecoration(context),
        ),
      ],
    );
  }
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  bool _agree = false;

  // country code state
  String _dialCode = '+964'; // default (Iraq)
  final List<_DialItem> _dialItems = const [
    _DialItem(country: 'Iraq', cc: 'IQ', dial: '+964'),
    _DialItem(country: 'UAE', cc: 'AE', dial: '+971'),
    _DialItem(country: 'Turkey', cc: 'TR', dial: '+90'),
    _DialItem(country: 'USA', cc: 'US', dial: '+1'),
    _DialItem(country: 'UK', cc: 'GB', dial: '+44'),
    _DialItem(country: 'Germany', cc: 'DE', dial: '+49'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SectionScaffold(
      title: 'Live Sports Experience',
      children: [
        // Header image
        SizedBox(
          width: width,
          child: Image.asset(
            'assets/images/welcomBack.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),

        // Responsive form
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final double widthFactor =
                w >= 1280
                    ? 0.45
                    : w >= 992
                    ? 0.55
                    : w >= 640
                    ? 0.72
                    : 1.0;

            final double gap = (w * 0.015).clamp(12.0, 20.0);
            final double pad = (w * 0.02).clamp(16.0, 24.0);
            // final radius = BorderRadius.circular(16); // (kept if you wrap in Card later)

            return FractionallySizedBox(
              widthFactor: widthFactor,
              child: Padding(
                padding: EdgeInsets.all(pad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Phone: country code dropdown + number field
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 34,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Country Code',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: 8),
                              _DialCodeField(
                                value: _dialCode,
                                items: _dialItems,
                                onChanged:
                                    (v) => setState(
                                      () => _dialCode = v ?? _dialCode,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: gap),
                        const Flexible(
                          flex: 66,
                          child: AppTextField(
                            label: 'Phone number',
                            hint: 'Enter your phone number',
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: gap * 0.6),
                    Text(
                      "We'll send a verification code to this number",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: gap * 2),

                    SizedBox(height: gap * 2),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _agree,
                            onChanged:
                                (v) => setState(() => _agree = v ?? false),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '  I agree to the Terms of Service and Privacy Policy',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: gap),
                    SizedBox(height: gap),

                    InkWell(
                      onTap:
                          _agree
                              ? () =>
                                  Navigator.pushNamed(context, '/verifyCode')
                              : null,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        decoration: const BoxDecoration(
                          gradient: AppGradients.primary,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: const Text(
                          'Send Verification Code',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Compact, box-styled dropdown with label, iOS chevron, and only "flag + dial".
class _DialCodeField extends StatelessWidget {
  const _DialCodeField({
    required this.value,
    required this.onChanged,
    required this.items,
  });

  final String value;
  final ValueChanged<String?> onChanged;
  final List<_DialItem> items;

  InputDecoration _fieldDecoration(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: radius),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      // itemHeight removed (must be >= 48 if set)
      menuMaxHeight: 280,
      icon: const Icon(CupertinoIcons.chevron_down, size: 16),
      decoration: _fieldDecoration(context),
      items:
          items.map((d) {
            final label = '${_flag(d.cc)} ${d.dial}'; // flag + dial only
            return DropdownMenuItem<String>(
              value: d.dial,
              child: Text(label, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
      selectedItemBuilder:
          (context) =>
              items.map((d) {
                final label = '${_flag(d.cc)} ${d.dial}';
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(label, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
      onChanged: onChanged,
    );
  }
}

// --- helpers ----------------------------------------------------------------
class _DialItem {
  final String country; // (not shown, but kept if you need it elsewhere)
  final String cc; // ISO 2-letter country code
  final String dial; // +XXX
  const _DialItem({
    required this.country,
    required this.cc,
    required this.dial,
  });
}

String _flag(String countryCode) {
  final cc = countryCode.toUpperCase();
  if (cc.length != 2) return '🏳️';
  const base = 0x1F1E6; // 'A'
  final a = base + (cc.codeUnitAt(0) - 65);
  final b = base + (cc.codeUnitAt(1) - 65);
  return String.fromCharCodes([a, b]);
}
