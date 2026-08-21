import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart' as arena;
import 'smart_notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        scaffoldBackgroundColor: arena.arenaNavy,
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: arena.arenaGold,
          onPrimary: Color(0xFF171006),
          secondary: arena.arenaElectric,
          onSecondary: Colors.black,
          surface: arena.arenaPanel,
          onSurface: Color(0xFFF6F0E5),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 60,
          backgroundColor: const Color(0xFF061426),
          indicatorColor: arena.arenaBlue.withOpacity(.42),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: arena.arenaGold,
            foregroundColor: const Color(0xFF130D04),
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
    if (stage == 0) return arena.EntrySplashScreen(onEnter: _enterArena);
    if (stage == 1) {
      return const arena.BrandImageScreen(
        asset: 'assets/branding/inspired_from_zeus.jpg',
      );
    }
    return const SmartArenaShell();
  }
}

class SmartArenaShell extends StatefulWidget {
  const SmartArenaShell({super.key});
  @override
  State<SmartArenaShell> createState() => _SmartArenaShellState();
}

class _SmartArenaShellState extends State<SmartArenaShell> {
  final store = arena.ProgressStore();
  arena.ProgressData data = const arena.ProgressData(
    xp: 0,
    streak: 1,
    lastTopic: 'Anayasa Hukuku · Temel İlkeler',
    premium: false,
  );
  int tab = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    data = await store.load();
    if (mounted) setState(() => loading = false);
  }

  Future<void> _togglePremium() async {
    data = data.copyWith(premium: !data.premium);
    await store.save(data);
    if (mounted) setState(() {});
  }

  Future<void> _startQuiz() async {
    final result = await Navigator.of(context).push<arena.QuizResult>(
      MaterialPageRoute(
        builder: (_) => arena.QuizScreen(isPremium: data.premium),
      ),
    );
    if (result == null) return;
    data = data.copyWith(
      xp: data.xp + result.correct * 100,
      lastTopic: result.lastTopic,
    );
    await store.save(data);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: arena.arenaGold),
        ),
      );
    }

    final pages = <Widget>[
      arena.HomePanel(
        data: data,
        onStart: _startQuiz,
        onTogglePremium: _togglePremium,
        onRanking: () => setState(() => tab = 4),
      ),
      const StudyPage(),
      const arena.CompactInfoPage(
        title: 'DENEMELER',
        icon: Icons.timer_rounded,
        body: 'HMGS Tam Deneme: 120 soru · 155 dakika. Doğrulanmış soru havuzuyla bu bölüm genişletiliyor.',
      ),
      const arena.CompactInfoPage(
        title: 'ZAYIF KONULAR',
        icon: Icons.analytics_rounded,
        body: 'Başarı oranı düşük konular kişisel çalışma kartlarına ve Akıllı Not önerilerine dönüşecek.',
      ),
      const arena.RankingPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: arena.ZeusBackdrop(
          child: Column(
            children: [
              Expanded(child: pages[tab]),
              NavigationBar(
                selectedIndex: tab,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                onDestinationSelected: (i) => setState(() => tab = i),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_rounded),
                    label: 'Arena',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.menu_book_rounded),
                    label: 'Çalışma',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.timer_rounded),
                    label: 'Deneme',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.analytics_rounded),
                    label: 'Zayıf',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.emoji_events_rounded),
                    label: 'Sıralama',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
