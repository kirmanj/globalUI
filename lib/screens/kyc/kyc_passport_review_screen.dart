import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';
import '../../theme/app_theme.dart'; // AppGradients, AppPalette

class KYCPassportReviewScreen extends StatefulWidget {
  const KYCPassportReviewScreen({super.key});

  @override
  State<KYCPassportReviewScreen> createState() =>
      _KYCPassportReviewScreenState();
}

class _KYCPassportReviewScreenState extends State<KYCPassportReviewScreen> {
  // Simulated status: 0 Submitted, 1 Under Review, 2 Verified (or 3 Rejected)
  int _currentStep = 1; // under review
  final String _applicationId = 'KYC-87654321';
  final DateTime _submittedAt = DateTime.now().subtract(
    const Duration(hours: 2, minutes: 15),
  );

  double get _progress => (_currentStep + 1) / 3.0; // 3 steps to "Verified"

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SectionScaffold(
      title: 'KYC Verification — Review',
      children: [
        // Gradient hero header
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
                'Passport review in progress ',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Application ID: $_applicationId',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 12),
              // Progress bar
              SizedBox(height: 8, child: _ProgressBar(value: _progress)),
              const SizedBox(height: 10),
              // Step pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _StepPill(label: 'Submitted ', active: _currentStep >= 0),
                    const SizedBox(width: 8),
                    _StepPill(
                      label: 'Under Review ',
                      active: _currentStep >= 1,
                    ),
                    const SizedBox(width: 8),
                    _StepPill(label: 'Verifying', active: _currentStep >= 2),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Timeline card
        _CardShell(
          title: 'Review timeline',
          icon: Icon(Icons.image_search_outlined, color: Colors.white),
          child: Column(
            children: [
              _TimelineTile(
                leading: Icon(Icons.abc, size: 0),
                title: 'Submitted',
                subtitle: _fmtTime(_submittedAt),
                done: true,
              ),
              _ConnectorLine(done: _currentStep >= 1),
              _TimelineTile(
                leading: Icon(Icons.abc, size: 0),
                title: 'Under Review',
                subtitle: 'Estimated 24–48 hours',
                done: _currentStep >= 1,
                active: _currentStep == 1,
              ),
              _ConnectorLine(done: _currentStep >= 2),
              _TimelineTile(
                leading: const Icon(Icons.verified, color: Colors.blueAccent),
                title: 'Verification',
                subtitle: _currentStep >= 2 ? 'Approved 🎉' : 'Pending ',
                done: _currentStep >= 2,
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Documents summary
        _CardShell(
          title: 'Documents',
          icon: Icon(Icons.document_scanner_rounded, color: Colors.white),
          subtitle: 'What we’re reviewing',
          child: Column(
            children: const [
              _DocRow(
                emoji: '📘',
                title: 'Passport (Primary)',
                status: 'Uploaded',
              ),

              _DocRow(
                emoji: '📘',
                title: 'Passport (Secondary)',
                status: 'Uploaded',
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        const SizedBox(height: 8),
        Text(
          'Your data is encrypted and securely stored in compliance with regulations',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  String _fmtTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return 'Today, $h:$m';
  }
}

/* --------------------------- UI bits --------------------------- */

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
              Container(color: Colors.white.withOpacity(trackOpacity)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: w,
                color: Colors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  const _StepPill({required this.label, required this.active});
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color:
            active
                ? Colors.white.withOpacity(0.18)
                : Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: Colors.white.withOpacity(active ? 0.7 : 0.35),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.title,
    this.subtitle,
    required this.child,
    required this.icon,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(16);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: radius,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.primary,
                  ),
                  alignment: Alignment.center,
                  child: icon,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.done = false,
    this.active = false,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w700,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leading,
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: titleStyle),
                  if (done) ...[
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConnectorLine extends StatelessWidget {
  const _ConnectorLine({this.done = false});
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 16,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
        color:
            done
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

class _DocRow extends StatelessWidget {
  const _DocRow({
    required this.emoji,
    required this.title,
    required this.status,
  });
  final String emoji;
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: theme.colorScheme.primaryContainer,
          ),
          child: Text(
            status,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
