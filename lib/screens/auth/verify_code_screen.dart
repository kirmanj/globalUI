import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../widgets/atoms.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SectionScaffold(
          title: 'Enter Verification Code',
          footer: Column(
            children: [
              PrimaryButton(label: 'Verify', onPressed: () {}),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: const Text("Didn't receive code? Resend"),
              ),
            ],
          ),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    SizedBox(height: 50),
                    Text(
                      'We\'ve sent a code to +1 234 567 8900',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    AppTextField(
                      label: 'Code',
                      hint: 'Enter 6-digit code',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('Resend code in 00:30', textAlign: TextAlign.center),
          ],
        ),

        Positioned(
          bottom: height * 0.1,
          right: -width * 0.2,
          child: SizedBox(
            height: height * 0.4,
            child: Image.asset(
              'assets/images/net.png', // <- your asset
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
