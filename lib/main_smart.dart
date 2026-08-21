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
    return const SmartArenaShell();
  }
}

class SmartArenaShell extends StatefulWidget {
  const SmartArenaShell({super.key});

  @override
  State<SmartArenaShell> createState() => _SmartArenaShellState();
}

class _SmartArenaShellState extends State<SmartArenaShell> {
  final store = legacy.ProgressStore();
  legacy.ProgressData data = const legacy.ProgressData(
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
    final result = await Navigator.of(context).push<legacy.QuizResult>(
      MaterialPageRoute(builder: (_) => legacy.QuizScreen(isPremium: data.premium)),
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
        body: Center(child: CircularProgressIndicator(color: legacy.arenaGold)),
      );
    }

    final pages = <Widget>[
      legacy.HomePanel(
        data: data,
        onStart: _startQuiz,
        onTogglePremium: _togglePremium,
        onRanking: () => setState(() => tab = 4),
      ),
      const SmartNotesHub(),
      const legacy.CompactInfoPage(
        title: 'DENEMELER',
        icon: Icons.timer_rounded,
        body: 'HMGS Tam Deneme: 120 soru · 155 dakika. Doğrulanmış soru havuzu tamamlandıkça deneme sistemi genişletilecek.',
      ),
      const legacy.CompactInfoPage(
        title: 'ZAYIF KONULAR',
        icon: Icons.analytics_rounded,
        body: 'En az 5 cevap sonrası başarı oranı düşük konular kişisel çalışma kartlarına dönüşecek.',
      ),
      const legacy.RankingPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: legacy.ZeusBackdrop(
          child: Column(
            children: [
              Expanded(child: pages[tab]),
              NavigationBar(
                selectedIndex: tab,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                onDestinationSelected: (i) => setState(() => tab = i),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Arena'),
                  NavigationDestination(icon: Icon(Icons.auto_stories_rounded), label: 'Çalışma'),
                  NavigationDestination(icon: Icon(Icons.timer_rounded), label: 'Deneme'),
                  NavigationDestination(icon: Icon(Icons.analytics_rounded), label: 'Zayıf'),
                  NavigationDestination(icon: Icon(Icons.emoji_events_rounded), label: 'Sıralama'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmartNotesHub extends StatelessWidget {
  const SmartNotesHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bolt_rounded, color: legacy.arenaElectric, size: 20),
              SizedBox(width: 5),
              Text(
                'ÇALIŞMA',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 23,
                  color: legacy.arenaGold2,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF123B64), Color(0xFF0A2038), Color(0xFF061426)],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0x6650BFFF)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SmartNotesScreen()),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: legacy.arenaBlue.withOpacity(.18),
                            border: Border.all(color: const Color(0x88E5BF72)),
                            boxShadow: [
                              BoxShadow(
                                color: legacy.arenaElectric.withOpacity(.12),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            size: 50,
                            color: legacy.arenaGold2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'AKILLI NOTLAR',
                          style: TextStyle(
                            fontFamily: 'serif',
                            color: legacy.arenaGold2,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Bilinmesi gerekenler · en çok karıştırılanlar · süre ve sayılar · istisnalar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFC1D4E5),
                            height: 1.35,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0x2214B8FF),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0x4450BFFF)),
                          ),
                          child: const Text(
                            '20 doğrulanmış hızlı tekrar kartı',
                            style: TextStyle(
                              color: legacy.arenaElectric,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Expanded(
                child: legacy.MiniCard(
                  label: 'SİSTEM',
                  title: 'Bildim',
                  value: 'Kalıcı kayıt',
                ),
              ),
              SizedBox(width: 7),
              Expanded(
                child: legacy.MiniCard(
                  label: 'TEKRAR',
                  title: 'Tekrar Göster',
                  value: 'Öncelikli liste',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
