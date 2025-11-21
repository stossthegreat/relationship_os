import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/home/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Add error handling for uncaught exceptions
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };
  
  runApp(
    const ProviderScope(
      child: RelationshipOSApp(),
    ),
  );
}

class RelationshipOSApp extends ConsumerWidget {
  const RelationshipOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use a default theme mode if provider fails
    ThemeMode themeMode = ThemeMode.dark;
    try {
      themeMode = ref.watch(themeProvider);
    } catch (e) {
      debugPrint('Error loading theme: $e');
    }

    return MaterialApp(
      title: 'RelationshipOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      home: const SplashScreen(),
      builder: (context, child) {
        // Error boundary
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return Scaffold(
            backgroundColor: const Color(0xFF030712),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${details.exception}',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        };
        return child ?? const SizedBox.shrink();
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        // TEMPORARY: Skip onboarding/sign-in, go directly to main app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const MainNavigation(),
          ),
        );
      }
    } catch (e, stackTrace) {
      // Enhanced error logging
      debugPrint('Error checking onboarding status: $e');
      debugPrint('Stack trace: $stackTrace');
      
      // If there's an error, go to main nav
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const MainNavigation(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030712),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFfb7185),
                    const Color(0xFFec4899),
                    const Color(0xFFd946ef),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.favorite,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFec4899)),
            ),
          ],
        ),
      ),
    );
  }
}
