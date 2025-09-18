import 'package:flutter/material.dart';
import '../../widgets/atoms.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1) Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/loginBack.jpg', // <- your asset
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),

        // 3) Your original content on top
        Positioned(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              // If SectionScaffold paints a background, make sure it’s transparent in that widget.
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PrimaryButton(label: 'Join as Guest', onPressed: () {}),
                        const SizedBox(height: 12),
                        SecondaryButton(
                          label: 'Create Account',

                          onPressed:
                              () =>
                                  Navigator.pushNamed(context, '/signupPhone'),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Colors.white, // <-- text & icon color
                          ),
                          onPressed:
                              () => Navigator.pushNamed(context, '/loginPhone'),
                          child: const Text('Already have an account? Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
