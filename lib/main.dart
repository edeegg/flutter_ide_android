import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/injection_container.dart' as di;
import 'features/onboarding/presentation/providers/onboarding_provider.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/terminal/presentation/providers/terminal_provider.dart';
import 'features/terminal/presentation/screens/terminal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OnboardingProvider>(
          create: (_) => di.sl<OnboardingProvider>(),
        ),
        ChangeNotifierProvider<TerminalProvider>(
          create: (_) => di.sl<TerminalProvider>(),
        ),
      ],
      child: DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          darkScheme = darkDynamic.harmonized();
        } else {
          lightScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          );
          darkScheme = ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          );
        }
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: darkScheme.surface,
            systemNavigationBarColor: darkScheme.surface,
          ),
          child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/': (_) => const OnboardingScreen(),
              '/home': (_) => const HomeScreen(),
              // '/editor': (_) => EditorScreen(),
              '/terminal': (_) => const TerminalScreen(),
            },
            theme: ThemeData(
              colorScheme: lightScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: darkScheme,
              useMaterial3: true,
            ),
          ),
        );
      }),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter IDE')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*    ElevatedButton.icon(
              icon: const Icon(Icons.code),
              label: const Text('Editor de Código'),
              onPressed: () => Navigator.pushNamed(context, '/editor'),
            ),
            const SizedBox(height: 16), */
            ElevatedButton.icon(
              icon: const Icon(Icons.terminal),
              label: const Text('Terminal'),
              onPressed: () => Navigator.pushNamed(context, '/terminal'),
            ),
          ],
        ),
      ),
    );
  }
}
