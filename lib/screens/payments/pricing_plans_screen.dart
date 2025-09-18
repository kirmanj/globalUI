import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart'; // for PrimaryButton/SecondaryButton below

// ===================== THEME GRADIENT (your exact colors) =====================

// ===================== PRICING: Centered Gradient Carousel ====================

// A tiny helper to make "white with gradient border" cards.
class _GradientBorderCard extends StatelessWidget {
  const _GradientBorderCard({
    required this.child,
    this.radius = 16,
    this.padding = const EdgeInsets.all(14),
    this.fill = false,
    this.gradient,
  });
  final Widget child;
  final double radius;
  final EdgeInsets padding;
  final bool fill;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final g = gradient ?? kBrandGradient;

    if (fill) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(
          gradient: g,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      );
    }
    return Container(
      decoration: BoxDecoration(
        gradient: g,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius - 2),
        ),
        child: child,
      ),
    );
  }
}

// === Your gradient ===
const Color kGradientStart = Color(0xFF010669);
const Color kGradientEnd = Color(0xFF012DF0);
const LinearGradient kBrandGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kGradientStart, kGradientEnd],
);

class PricingPlansScreen extends StatefulWidget {
  const PricingPlansScreen({super.key});

  @override
  State<PricingPlansScreen> createState() => _PricingPlansScreenState();
}

class _PricingPlansScreenState extends State<PricingPlansScreen> {
  final _page = PageController(viewportFraction: 0.78);
  int _selectedPlanIndex = 0; // Free first
  String? _selectedCardId;

  final List<_Plan> _plans = const [
    _Plan(title: 'Free Plan', priceLabel: '\$0'),
    _Plan(title: 'Premium Monthly', priceLabel: '\$9.99'),
    _Plan(
      title: 'Premium 16 Months',
      priceLabel: '\$109.99',
      discountLabel: '4 extra months',
    ),
    _Plan(
      title: 'Premium Annual',
      priceLabel: '\$89.99',
      discountLabel: 'Save 25%',
    ),
  ];

  final List<_SavedCard> _savedCards = [
    _SavedCard(
      id: 'card_1',
      brand: _CardBrand.visa,
      last4: '4242',
      holderName: 'Your Name',
      expiry: '12/26',
    ),
  ];

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  bool get _isFreeSelected => _plans[_selectedPlanIndex].title == 'Free Plan';

  // -------------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return SectionScaffold(
      title: 'Choose Your Plan',
      footer: Center(
        child: PrimaryButton(label: 'Subscribe', onPressed: _onSubscribe),
      ),
      children: [
        // ---------- Payment Method section (ABOVE the subscription cards) ----------
        _GradientBorderCard(
          fill: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: t.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: kGradientStart,
                ),
              ),
              const SizedBox(height: 12),

              // Saved cards (horizontal selector) + Add Card tile
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _savedCards.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == _savedCards.length) {
                      // Add Card tile
                      return _AddCardTile(onTap: _openAddCardSheet);
                    }
                    final card = _savedCards[index];
                    final selected = card.id == _selectedCardId;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedCardId = card.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 220,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: selected ? kBrandGradient : null,
                          color: selected ? null : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border:
                              selected
                                  ? null
                                  : Border.all(
                                    color: kGradientEnd.withOpacity(0.45),
                                  ),
                          boxShadow: [
                            if (selected)
                              BoxShadow(
                                color: kGradientEnd.withOpacity(0.28),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _brandRow(card.brand, selectedText: selected),
                            const Spacer(),
                            Text(
                              '•••• ${card.last4}',
                              style: t.titleMedium?.copyWith(
                                color: selected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${card.holderName} • ${card.expiry}',
                              style: t.bodySmall?.copyWith(
                                color:
                                    selected ? Colors.white70 : Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (!_isFreeSelected) ...[
                const SizedBox(height: 10),
                Text(
                  _selectedCardId == null
                      ? 'Select or add a card to subscribe.'
                      : 'Card selected.',
                  style: t.labelMedium?.copyWith(
                    color:
                        _selectedCardId == null
                            ? Colors.red[700]
                            : Colors.green[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ] else ...[
                const SizedBox(height: 10),
                Text(
                  'Free plan does not require a card.',
                  style: t.labelMedium?.copyWith(color: Colors.black87),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ---------- Subscription Cards (gradient background + white text) ----------
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _page,
            itemCount: _plans.length,
            onPageChanged: (i) => setState(() => _selectedPlanIndex = i),
            itemBuilder: (context, index) {
              final plan = _plans[index];
              final isSelected = index == _selectedPlanIndex;

              return AnimatedScale(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                scale: isSelected ? 1.0 : 0.92,
                child: GestureDetector(
                  onTap: () {
                    if (_selectedPlanIndex != index) {
                      _page.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    margin: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: isSelected ? 8 : 18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: kBrandGradient, // gradient background
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: kGradientEnd.withOpacity(0.35),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 240),
                            opacity: isSelected ? 1 : 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.14),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.45),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Selected',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            plan.title,
                            textAlign: TextAlign.center,
                            style: t.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            plan.priceLabel,
                            textAlign: TextAlign.center,
                            style: t.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (plan.discountLabel != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.16),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.45),
                                ),
                              ),
                              child: Text(
                                plan.discountLabel!,
                                textAlign: TextAlign.center,
                                style: t.labelLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_plans.length, (i) {
            final active = i == _selectedPlanIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 8,
              width: active ? 22 : 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: active ? Colors.white : Colors.white.withOpacity(0.35),
              ),
            );
          }),
        ),
      ],
    );
  }

  // -------------------- Actions --------------------
  Future<void> _openAddCardSheet() async {
    final result = await showModalBottomSheet<_SavedCard>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddCardSheet(),
    );

    if (result != null) {
      setState(() {
        _savedCards.add(result);
        _selectedCardId = result.id;
      });
    }
  }

  void _onSubscribe() {
    final picked = _plans[_selectedPlanIndex];

    final needsCard = picked.title != 'Free Plan';
    if (needsCard && _selectedCardId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or add a card.')),
      );
      return;
    }

    // TODO: Replace with your real checkout result.
    final success = true; // or false to test failure

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (_) => PaymentResultScreen(
              kind:
                  success
                      ? PaymentResultKind.success
                      : PaymentResultKind.failure,
              amountLabel:
                  picked.title == 'Free Plan' ? '\$0' : picked.priceLabel,
              planLabel: picked.title,
              transactionId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
              dateTime: DateTime.now(),
              failureHints: const [
                'Insufficient funds',
                'Invalid card details',
                'Bank declined transaction',
              ],
              onPrimary: () => Navigator.of(context).popUntil((r) => r.isFirst),
              onSecondary: () => Navigator.of(context).pop(),
            ),
      ),
    );
  }
}

class _Plan {
  final String title;
  final String priceLabel;
  final String? discountLabel;
  const _Plan({
    required this.title,
    required this.priceLabel,
    this.discountLabel,
  });
}

enum _CardBrand { visa, mastercard, unknown }

class _SavedCard {
  final String id;
  final _CardBrand brand;
  final String last4;
  final String holderName;
  final String expiry; // MM/YY
  const _SavedCard({
    required this.id,
    required this.brand,
    required this.last4,
    required this.holderName,
    required this.expiry,
  });
}

Widget _brandRow(_CardBrand brand, {bool selectedText = false}) {
  final color = selectedText ? Colors.white : Colors.black87;
  final sub = selectedText ? Colors.white70 : Colors.black54;
  return Row(
    children: [
      Icon(Icons.credit_card, color: color),
      const SizedBox(width: 8),
      Text(
        brand == _CardBrand.visa
            ? 'Visa'
            : brand == _CardBrand.mastercard
            ? 'MasterCard'
            : 'Card',
        style: TextStyle(fontWeight: FontWeight.w800, color: color),
      ),
      const SizedBox(width: 6),
      Text('•', style: TextStyle(color: sub)),
      const SizedBox(width: 6),
      Text('Saved', style: TextStyle(color: sub, fontWeight: FontWeight.w600)),
    ],
  );
}

class _AddCardTile extends StatelessWidget {
  const _AddCardTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kGradientEnd.withOpacity(0.45)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_card, size: 28, color: Colors.black87),
              SizedBox(height: 8),
              Text('Add Card', style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddCardSheet extends StatefulWidget {
  @override
  State<_AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<_AddCardSheet> {
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _expiry = TextEditingController(); // MM/YY
  final _cvv = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _CardBrand _detect(String num) {
    final n = num.replaceAll(RegExp(r'\s'), '');
    if (n.startsWith('4')) return _CardBrand.visa;
    if (n.startsWith(RegExp(r'5[1-5]'))) return _CardBrand.mastercard;
    return _CardBrand.unknown;
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add Card',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Cardholder name'),
                validator:
                    (v) =>
                        (v == null || v.trim().isEmpty) ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _number,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Card number'),
                validator:
                    (v) =>
                        (v == null || v.replaceAll(' ', '').length < 12)
                            ? 'Enter a valid number'
                            : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiry,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(labelText: 'MM/YY'),
                      validator:
                          (v) =>
                              (v == null ||
                                      !RegExp(r'^\d{2}/\d{2}$').hasMatch(v))
                                  ? 'MM/YY'
                                  : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _cvv,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'CVV'),
                      obscureText: true,
                      validator:
                          (v) => (v == null || v.length < 3) ? 'CVV' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Save Card',
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  final num = _number.text;
                  final brand = _detect(num);
                  final last4 = num.replaceAll(RegExp(r'\s'), '');
                  final card = _SavedCard(
                    id: 'card_${DateTime.now().millisecondsSinceEpoch}',
                    brand: brand,
                    last4: last4.substring(last4.length - 4),
                    holderName: _name.text.trim(),
                    expiry: _expiry.text.trim(),
                  );
                  Navigator.of(context).pop(card);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

enum PaymentResultKind { success, failure }

class PaymentResultScreen extends StatelessWidget {
  const PaymentResultScreen({
    super.key,
    required this.kind,
    this.amountLabel,
    this.planLabel,
    this.transactionId,
    this.dateTime,
    this.failureHints = const [
      'Insufficient funds',
      'Invalid card details',
      'Bank declined transaction',
    ],
    this.onPrimary,
    this.onSecondary,
  });

  final PaymentResultKind kind;
  final String? amountLabel;
  final String? planLabel;
  final String? transactionId;
  final DateTime? dateTime;
  final List<String> failureHints;
  final VoidCallback? onPrimary;
  final VoidCallback? onSecondary;

  String _fmt(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
    // (If you prefer intl, swap this with DateFormat('MMM d, y').format(d))
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final isSuccess = kind == PaymentResultKind.success;

    return SectionScaffold(
      title: isSuccess ? 'Payment Successful!' : 'Payment Failed',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (kind == PaymentResultKind.failure)
            SecondaryButton(
              label: 'Change Payment Method',
              onPressed: onSecondary,
            ),
          if (kind == PaymentResultKind.failure) const SizedBox(width: 12),
          PrimaryButton(
            label: isSuccess ? 'Continue' : 'Try Again',
            onPressed: onPrimary,
          ),
        ],
      ),
      children: [
        const SizedBox(height: 12),

        // Icon with gradient ring
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: kBrandGradient,
                ),
              ),
              Container(
                width: 104,
                height: 104,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
                  size: 64,
                  color: isSuccess ? Colors.green : Colors.redAccent,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Details BOX — white background + gradient border (centered text)
        _GradientBorderCard(
          fill: true,
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSuccess) ...[
                Text(
                  'Your subscription is now active',
                  style: t.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                if (amountLabel != null)
                  Text(
                    'Amount Paid: $amountLabel',
                    textAlign: TextAlign.center,
                    style: t.bodyMedium?.copyWith(color: Colors.white),
                  ),
                if (planLabel != null)
                  Text(
                    'Plan: $planLabel',
                    textAlign: TextAlign.center,
                    style: t.bodyMedium?.copyWith(color: Colors.white),
                  ),
                if (transactionId != null)
                  Text(
                    'Transaction ID: $transactionId',
                    textAlign: TextAlign.center,
                    style: t.bodyMedium?.copyWith(color: Colors.white),
                  ),
                if (dateTime != null)
                  Text(
                    'Date: ${_fmt(dateTime!)}',
                    textAlign: TextAlign.center,
                    style: t.bodyMedium?.copyWith(color: Colors.white),
                  ),
              ] else ...[
                Text(
                  "We couldn't process your payment",
                  style: t.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Possible reasons:',
                  textAlign: TextAlign.center,
                  style: t.bodyMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                ...failureHints.map(
                  (h) => Text(
                    '• $h',
                    textAlign: TextAlign.center,
                    style: t.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
