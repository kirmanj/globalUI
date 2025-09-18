import 'package:flutter/material.dart';
import 'package:globalsportsmarket/screens/universal_profile_wizard.dart';
import 'theme/app_theme.dart';

// ===== Part 1 screens =====
import 'screens/welcome/language_selection_screen.dart';
import 'screens/auth/auth_landing_screen.dart';
import 'screens/auth/signup_phone_screen.dart';
import 'screens/auth/login_phone_screen.dart';
import 'screens/auth/verify_code_screen.dart';
import 'screens/onboarding/choose_profile_screen.dart';
import 'screens/player/player_profile_wizard.dart';
import 'screens/kyc/kyc_passport_capture_screen.dart';
import 'screens/kyc/kyc_passport_review_screen.dart';
import 'screens/payments/pricing_plans_screen.dart';

// ===== Part 2 screens =====
import 'screens/feed/home_feed_screen.dart';
import 'screens/lists/clubs_list_screen.dart';
import 'screens/empty/favorites_empty_screen.dart';
import 'screens/empty/profile_empty_screen.dart';
import 'screens/settings/app_settings_screen.dart';
import 'screens/legal/terms_screen.dart';

void main() => runApp(const GlobalSportsApp());

class GlobalSportsApp extends StatelessWidget {
  const GlobalSportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Sports UI',
      theme: AppTheme.light, // <- apply your theme
      // Tip: you can change this to '/welcomeLanguage' if you want the language screen first.
      initialRoute: '/menu',

      routes: {
        // ===== Menu (development launcher) =====
        '/menu': (c) => const _MenuScreen(),

        // ===== Welcome/Auth/Onboarding =====
        '/welcomeLanguage': (c) => const LanguageSelectionPage(),
        '/authLanding': (c) => const AuthLandingScreen(),
        '/signupPhone': (c) => const SignUpPhoneScreen(),
        '/loginPhone': (c) => const LoginPhoneScreen(),
        '/verifyCode': (c) => const VerifyCodeScreen(),
        '/chooseProfile': (c) => const ChooseProfileScreen(),
        '/playerWizard': (c) => const PlayerProfileWizard(),
        '/universalWizard': (c) => const UniversalProfileWizard(),

        // ===== KYC =====
        '/kycPassportCapture': (c) => const KYCPassportCaptureScreen(),
        '/kycPassportReview': (c) => const KYCPassportReviewScreen(),

        // ===== Payments =====
        '/pricingPlans': (c) => const PricingPlansScreen(),

        // ===== Feed & Lists =====
        '/homeFeed': (c) => const HomeFeedScreen(),
        '/clubsList': (c) => const ClubsListScreen(),

        // Placeholders for list routes referenced in HomeFeed (avoid route errors for now)
        '/playersList':
            (c) => const _PlaceholderListScreen(title: 'Players List'),
        '/coachesList':
            (c) => const _PlaceholderListScreen(title: 'Coaches List'),
        '/agentsList':
            (c) => const _PlaceholderListScreen(title: 'Agents/Sub-Agents'),
        '/storesList':
            (c) => const _PlaceholderListScreen(title: 'Sports Stores'),
        '/campsList':
            (c) => const _PlaceholderListScreen(title: 'Sports Camps'),
        '/academiesList':
            (c) => const _PlaceholderListScreen(title: 'Sports Academies'),
        '/medicalList':
            (c) => const _PlaceholderListScreen(title: 'Medical Staff'),
        '/messagesList': (c) => const _PlaceholderListScreen(title: 'Messages'),

        // // ===== Filters =====
        // '/filtersPlayers': (c) => const FiltersPlayersScreen(),
        // '/filtersCoaches': (c) => const FiltersCoachesScreen(),
        // '/filtersMedical': (c) => const FiltersMedicalScreen(),
        // '/filtersStores': (c) => const FiltersStoresScreen(),
        // '/filtersAgents': (c) => const FiltersAgentsScreen(),
        // '/filtersClubs': (c) => const FiltersClubsScreen(),
        // '/filtersAcademies': (c) => const FiltersAcademiesScreen(),
        // '/filtersCamps': (c) => const FiltersCampsScreen(),

        // ===== Misc =====
        '/favoritesEmpty': (c) => const FavoritesEmptyScreen(),
        '/profileEmpty': (c) => const ProfileEmptyScreen(),
        '/settings': (c) => const AppSettingsScreen(),
        '/terms': (c) => const TermsScreen(),
      },
    );
  }
}

// --- Dev launcher to quickly open any screen ---
class _MenuScreen extends StatelessWidget {
  const _MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = <Map<String, String>>[
      // Onboarding/Auth
      {'title': 'Language Selection', 'route': '/welcomeLanguage'},
      {'title': 'Auth Landing', 'route': '/authLanding'},
      {'title': 'Sign Up (Phone)', 'route': '/signupPhone'},
      {'title': 'Login (Phone)', 'route': '/loginPhone'},
      {'title': 'Verify Code', 'route': '/verifyCode'},
      {'title': 'Choose Profile', 'route': '/chooseProfile'},
      {'title': 'Player Wizard', 'route': '/playerWizard'},
      {'title': 'Universal Wizard', 'route': '/universalWizard'},

      // KYC
      {'title': 'KYC — Passport Capture', 'route': '/kycPassportCapture'},
      {'title': 'KYC — Passport Review', 'route': '/kycPassportReview'},

      // Payments
      {'title': 'Pricing Plans', 'route': '/pricingPlans'},

      // Feed & Lists
      {'title': 'Home Feed', 'route': '/homeFeed'},
      {'title': 'Clubs List', 'route': '/clubsList'},
      {'title': 'Players List (placeholder)', 'route': '/playersList'},
      {'title': 'Coaches List (placeholder)', 'route': '/coachesList'},
      {'title': 'Agents List (placeholder)', 'route': '/agentsList'},
      {'title': 'Stores List (placeholder)', 'route': '/storesList'},
      {'title': 'Camps List (placeholder)', 'route': '/campsList'},
      {'title': 'Academies List (placeholder)', 'route': '/academiesList'},
      {'title': 'Medical Staff List (placeholder)', 'route': '/medicalList'},
      {'title': 'Messages (placeholder)', 'route': '/messagesList'},

      // Filters
      {'title': 'Filters — Players', 'route': '/filtersPlayers'},
      {'title': 'Filters — Coaches', 'route': '/filtersCoaches'},
      {'title': 'Filters — Medical', 'route': '/filtersMedical'},
      {'title': 'Filters — Stores', 'route': '/filtersStores'},
      {'title': 'Filters — Agents', 'route': '/filtersAgents'},
      {'title': 'Filters — Clubs', 'route': '/filtersClubs'},
      {'title': 'Filters — Academies', 'route': '/filtersAcademies'},
      {'title': 'Filters — Camps', 'route': '/filtersCamps'},

      // Misc
      {'title': 'Favorites (Empty)', 'route': '/favoritesEmpty'},
      {'title': 'Profile (Empty)', 'route': '/profileEmpty'},
      {'title': 'Settings', 'route': '/settings'},
      {'title': 'Terms & Conditions', 'route': '/terms'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Global Sports — All Screens')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (c, i) {
          final e = entries[i];
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: Theme.of(c).colorScheme.surface,
            title: Text(e['title']!),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () => Navigator.pushNamed(c, e['route']!),
          );
        },
        separatorBuilder: (c, i) => const SizedBox(height: 8),
        itemCount: entries.length,
      ),
    );
  }
}

// Tiny placeholder used by routes we haven’t fully designed yet.
// Replace these with your real list screens as you add them.
class _PlaceholderListScreen extends StatelessWidget {
  const _PlaceholderListScreen({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: const Center(child: Text('Design coming soon')),
  );
}
