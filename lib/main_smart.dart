import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart' as legacy;
import 'smart_notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const HmgsArenaSmartApp());
}

class HmgsArenaSmartApp extends StatelessWidget {
  const HmgsArenaSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HMGS ARENA',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: legacy.arenaNavy,
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: legacy.arenaGold,
          onPrimary: Color(0xFF171006),
          secondary: legacy.arenaElectric,
          onSecondary: Colors.black,
          surface: legacy.arenaPanel,
          onSurface: Color(0xFFF6F0E5),
          error: Color(0xFFFF6B6B),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 60,
          backgroundColor: const Color(0xFF061426),
          indicatorColor: legacy.arenaBlue.withOpacity(.42),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? legacy.arenaGold2
                  : const Color(0xFF8DA5BC),
              size: 22,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            return TextStyle(
              color: states.contains(WidgetState.selected)
                  ? legacy.arenaGold2
                  : const Color(0xFF8DA5BC),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            );
          }),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: legacy.arenaGold,
            foregroundColor: const Color(0xFF130D04),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: legacy.arenaGold2,
            side: const BorderSide(color: Color(0x88E5BF72)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const SmartBootFlow(),
    );
  }
}

class SmartBootFlow extends StatefulWidget {
  const SmartBootFlow({super.key});

  @override
  State<SmartBootFlow> createState() => _SmartBootFlowState();
}

class _SmartBootFlowState extends State<SmartBootFlow> {
  int stage = 0;
  bool entering = false;

  Future<void> _enterArena() async {
    if (entering) return;
    entering = true;
    setState(() => stage = 1);
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() => stage = 2);
  }

  @override
  Widget build(BuildContext context) {
    if (stage == 0) {
      return legacy.EntrySplashScreen(onEnter: _enterArena);
    }
    if (stage == 1) {
      return const legacy.BrandImageScreen(
        asset: 'assets/branding/inspired_from_zeus.jpg',
      );
    }
    return const SmartArenaHost();
  }
}

class SmartArenaHost extends StatelessWidget {
  const SmartArenaHost({super.key});

  void _openNotes(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SmartNotesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const legacy.ArenaShell(),
        Positioned(
          right: 10,
          bottom: 68,
          child: SafeArea(
            top: false,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _openNotes(context),
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE5BF72), Color(0xFF1466A8)],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xAAFFD98A)),
                    boxShadow: const [
                      BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 4)),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_stories_rounded, size: 18, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Akıllı Notlar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(Icons.bolt_rounded, size: 16, color: Color(0xFFFFE19B)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
