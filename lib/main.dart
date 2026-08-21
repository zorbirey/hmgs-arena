import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const arenaNavy = Color(0xFF020914);
const arenaNavy2 = Color(0xFF07182C);
const arenaPanel = Color(0xFF0A2038);
const arenaBlue = Color(0xFF1466A8);
const arenaElectric = Color(0xFF48B7FF);
const arenaGold = Color(0xFFE5BF72);
const arenaGold2 = Color(0xFFFFD98A);

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
  runApp(const HmgsArenaApp());
}

class HmgsArenaApp extends StatelessWidget {
  const HmgsArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HMGS ARENA',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: arenaNavy,
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: arenaGold,
          onPrimary: Color(0xFF171006),
          secondary: arenaElectric,
          onSecondary: Colors.black,
          surface: arenaPanel,
          onSurface: Color(0xFFF6F0E5),
          error: Color(0xFFFF6B6B),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 60,
          backgroundColor: const Color(0xFF061426),
          indicatorColor: arenaBlue.withOpacity(.42),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            return IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? arenaGold2
                  : const Color(0xFF8DA5BC),
              size: 22,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            return TextStyle(
              color: states.contains(WidgetState.selected)
                  ? arenaGold2
                  : const Color(0xFF8DA5BC),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            );
          }),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: arenaGold,
            foregroundColor: const Color(0xFF130D04),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: arenaGold2,
            side: const BorderSide(color: Color(0x88E5BF72)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const BootFlow(),
    );
  }
}

class BootFlow extends StatefulWidget {
  const BootFlow({super.key});

  @override
  State<BootFlow> createState() => _BootFlowState();
}

class _BootFlowState extends State<BootFlow> {
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
      return EntrySplashScreen(onEnter: _enterArena);
    }
    if (stage == 1) {
      return const BrandImageScreen(
        asset: 'assets/branding/inspired_from_zeus.jpg',
      );
    }
    return const ArenaShell();
  }
}

class EntrySplashScreen extends StatelessWidget {
  const EntrySplashScreen({super.key, required this.onEnter});

  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010713),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/branding/splash_arena_v2.jpg',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
            Align(
              alignment: const Alignment(0, .83),
              child: Semantics(
                button: true,
                label: 'Arenaya Gir',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onEnter,
                    borderRadius: BorderRadius.circular(20),
                    splashColor: arenaGold.withOpacity(.18),
                    highlightColor: arenaElectric.withOpacity(.08),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .82,
                      height: 92,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandImageScreen extends StatelessWidget {
  const BrandImageScreen({super.key, required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010713),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}

class ZeusBackdrop extends StatelessWidget {
  const ZeusBackdrop({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF061B35), Color(0xFF020914), Color(0xFF030A14)],
          stops: [0, .42, 1],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -18,
            right: -12,
            child: Icon(
              Icons.bolt_rounded,
              size: 180,
              color: arenaElectric.withOpacity(.035),
            ),
          ),
          Positioned(
            bottom: 30,
            left: -35,
            child: Icon(
              Icons.bolt_rounded,
              size: 150,
              color: arenaGold.withOpacity(.025),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class ProgressData {
  const ProgressData({
    required this.xp,
    required this.streak,
    required this.lastTopic,
    required this.premium,
  });

  final int xp;
  final int streak;
  final String lastTopic;
  final bool premium;

  int get level => (xp ~/ 1000) + 1;

  String get title {
    if (level >= 20) return 'LEJYONER';
    if (level >= 10) return 'GLADYATÖR';
    if (level >= 5) return 'ADAY';
    return 'ACEMİ';
  }

  ProgressData copyWith({int? xp, int? streak, String? lastTopic, bool? premium}) {
    return ProgressData(
      xp: xp ?? this.xp,
      streak: streak ?? this.streak,
      lastTopic: lastTopic ?? this.lastTopic,
      premium: premium ?? this.premium,
    );
  }
}

class ProgressStore {
  static const _xp = 'hmgs_xp';
  static const _streak = 'hmgs_streak';
  static const _topic = 'hmgs_topic';
  static const _premium = 'hmgs_premium';

  Future<ProgressData> load() async {
    final p = await SharedPreferences.getInstance();
    return ProgressData(
      xp: p.getInt(_xp) ?? 0,
      streak: p.getInt(_streak) ?? 1,
      lastTopic: p.getString(_topic) ?? 'Anayasa Hukuku · Temel İlkeler',
      premium: p.getBool(_premium) ?? false,
    );
  }

  Future<void> save(ProgressData data) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_xp, data.xp);
    await p.setInt(_streak, data.streak);
    await p.setString(_topic, data.lastTopic);
    await p.setBool(_premium, data.premium);
  }
}

class ArenaQuestion {
  const ArenaQuestion({
    required this.subject,
    required this.topic,
    required this.text,
    required this.options,
    required this.correct,
    required this.explanation,
  });

  final String subject;
  final String topic;
  final String text;
  final List<String> options;
  final int correct;
  final String explanation;
}

const demoQuestions = <ArenaQuestion>[
  ArenaQuestion(subject: 'Anayasa Hukuku', topic: 'Egemenlik', text: 'Türkiye Cumhuriyeti Anayasası’na göre egemenlik kayıtsız şartsız kime aittir?', options: ['TBMM’ye', 'Millete', 'Cumhurbaşkanına', 'Yargı organlarına', 'Devlete'], correct: 1, explanation: 'Anayasa m.6 uyarınca egemenlik kayıtsız şartsız Milletindir.'),
  ArenaQuestion(subject: 'Medeni Hukuk', topic: 'Erginlik', text: 'Türk Medeni Kanunu’na göre erginlik kural olarak kaç yaşın doldurulmasıyla başlar?', options: ['15', '16', '17', '18', '21'], correct: 3, explanation: 'TMK m.11 uyarınca erginlik on sekiz yaşın doldurulmasıyla başlar.'),
  ArenaQuestion(subject: 'Borçlar Hukuku', topic: 'Sözleşmenin kurulması', text: 'Bir sözleşmenin kurulması için tarafların irade açıklamalarının kural olarak nasıl olması gerekir?', options: ['Yazılı', 'Noterde', 'Karşılıklı ve uygun', 'Tanıklı', 'Tescilli'], correct: 2, explanation: 'Sözleşme tarafların karşılıklı ve birbirine uygun irade açıklamalarıyla kurulur.'),
  ArenaQuestion(subject: 'Ceza Hukuku', topic: 'Kanunilik', text: 'Suçta ve cezada kanunilik ilkesi aşağıdakilerden hangisini ifade eder?', options: ['Kıyas serbesttir', 'İdare ceza koyar', 'Kanunsuz suç ve ceza olmaz', 'Hakim suç yaratır', 'Örf suç yaratır'], correct: 2, explanation: 'Kanunda açıkça suç sayılmayan bir fiil için kimseye ceza verilemez.'),
  ArenaQuestion(subject: 'Ceza Muhakemesi', topic: 'Sanık', text: 'Ceza muhakemesinde kişi hangi aşamada sanık sıfatını alır?', options: ['İhbar', 'Soruşturma', 'İddianamenin kabulü', 'Gözaltı', 'Yakalama'], correct: 2, explanation: 'İddianamenin kabulüyle kovuşturma başlar ve kişi sanık sıfatını alır.'),
  ArenaQuestion(subject: 'Medeni Usul', topic: 'Dava şartları', text: 'Dava şartlarıyla ilgili aşağıdakilerden hangisi doğrudur?', options: ['Sadece davalı ileri sürer', 'Mahkeme kendiliğinden inceler', 'Yalnız temyizde incelenir', 'Taraflar kaldırabilir', 'Sadece ceza davasında vardır'], correct: 1, explanation: 'Dava şartları mahkemece davanın her aşamasında kendiliğinden araştırılır.'),
  ArenaQuestion(subject: 'İdare Hukuku', topic: 'İdari işlem', text: 'İdari işlemin temel özelliklerinden biri aşağıdakilerden hangisidir?', options: ['Mutlaka iki taraflıdır', 'Özel hukuk sözleşmesidir', 'Tek yanlı hukuki sonuç doğurabilir', 'Sadece mahkeme yapar', 'Her zaman sözlüdür'], correct: 2, explanation: 'İdari işlemler idarenin tek yanlı irade açıklamasıyla hukuki sonuç doğurabilir.'),
  ArenaQuestion(subject: 'Ticaret Hukuku', topic: 'Tacir', text: 'Ticari işletmeyi kısmen dahi olsa kendi adına işleten kişiye ne ad verilir?', options: ['Esnaf', 'Tacir', 'Komisyoncu', 'Tüketici', 'Vekil'], correct: 1, explanation: 'TTK sisteminde ticari işletmeyi kendi adına işleten kişi tacirdir.'),
  ArenaQuestion(subject: 'İş Hukuku', topic: 'İş sözleşmesi', text: 'İş sözleşmesinin ayırt edici unsurlarından biri aşağıdakilerden hangisidir?', options: ['Bağımlılık', 'Mirasçılık', 'Ortaklık payı', 'Kamu gücü', 'Vesayet'], correct: 0, explanation: 'İş görme, ücret ve bağımlılık iş sözleşmesinin temel unsurlarıdır.'),
  ArenaQuestion(subject: 'İcra ve İflas', topic: 'Takip hukuku', text: 'İcra hukukunun temel amacı aşağıdakilerden hangisidir?', options: ['Suç yaratmak', 'Özel hukuk alacağını devlet gücüyle yerine getirmek', 'Kanun iptal etmek', 'Vergi belirlemek', 'İdari işlem yapmak'], correct: 1, explanation: 'İcra hukuku özel hukuk alacaklarının cebri icra organlarıyla yerine getirilmesini düzenler.'),
];

class ArenaShell extends StatefulWidget {
  const ArenaShell({super.key});

  @override
  State<ArenaShell> createState() => _ArenaShellState();
}

class _ArenaShellState extends State<ArenaShell> {
  final store = ProgressStore();
  ProgressData data = const ProgressData(
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
    final result = await Navigator.of(context).push<QuizResult>(
      MaterialPageRoute(builder: (_) => QuizScreen(isPremium: data.premium)),
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
        body: Center(child: CircularProgressIndicator(color: arenaGold)),
      );
    }

    final pages = <Widget>[
      HomePanel(
        data: data,
        onStart: _startQuiz,
        onTogglePremium: _togglePremium,
        onRanking: () => setState(() => tab = 4),
      ),
      const CompactInfoPage(title: 'ÇALIŞMA', icon: Icons.menu_book_rounded, body: 'Konu bazlı çalışma, bilgi kartları ve zayıf konu testleri bu bölümde açılacak.'),
      const CompactInfoPage(title: 'DENEMELER', icon: Icons.timer_rounded, body: 'HMGS Tam Deneme: 120 soru · 155 dakika. 120 doğrulanmış soru tamamlandığında aktif olacak.'),
      const CompactInfoPage(title: 'ZAYIF KONULAR', icon: Icons.analytics_rounded, body: 'En az 5 cevap sonrası başarı oranı düşük konular burada kişisel çalışma kartlarına dönüşecek.'),
      const RankingPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: ZeusBackdrop(
          child: Column(
            children: [
              Expanded(child: pages[tab]),
              NavigationBar(
                selectedIndex: tab,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                onDestinationSelected: (i) => setState(() => tab = i),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Arena'),
                  NavigationDestination(icon: Icon(Icons.menu_book_rounded), label: 'Çalışma'),
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

class HomePanel extends StatelessWidget {
  const HomePanel({
    super.key,
    required this.data,
    required this.onStart,
    required this.onTogglePremium,
    required this.onRanking,
  });

  final ProgressData data;
  final VoidCallback onStart;
  final VoidCallback onTogglePremium;
  final VoidCallback onRanking;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final compact = c.maxHeight < 650;
        final gap = compact ? 6.0 : 9.0;
        return Padding(
          padding: EdgeInsets.fromLTRB(12, compact ? 7 : 10, 12, 6),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      'assets/branding/app_icon_v2.jpg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(Icons.bolt_rounded, size: 13, color: arenaElectric),
                          SizedBox(width: 3),
                          Text('HMGS ARENA', style: TextStyle(color: arenaGold2, fontSize: 11, letterSpacing: 2, fontWeight: FontWeight.w900)),
                        ]),
                        Text('Hoş geldin, Gladyatör', style: TextStyle(fontFamily: 'serif', fontSize: 19, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(colors: [Color(0xFF173E68), Color(0xFF071526)]),
                          border: Border.all(color: arenaGold),
                          boxShadow: [BoxShadow(color: arenaElectric.withOpacity(.15), blurRadius: 10)],
                        ),
                        alignment: Alignment.center,
                        child: Text('SV ${data.level}', style: const TextStyle(color: arenaGold2, fontWeight: FontWeight.w900)),
                      ),
                      const SizedBox(height: 2),
                      Text(data.title, style: const TextStyle(color: arenaGold2, fontSize: 9, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: gap),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.transparent, arenaElectric.withOpacity(.65), arenaGold.withOpacity(.7), Colors.transparent]),
                ),
              ),
              SizedBox(height: gap),
              Row(
                children: [
                  Expanded(child: StatBox(label: 'BUGÜN', value: '20 soru')),
                  const SizedBox(width: 6),
                  Expanded(child: StatBox(label: 'SERİ', value: '${data.streak} gün')),
                  const SizedBox(width: 6),
                  Expanded(child: StatBox(label: 'XP', value: '${data.xp}')),
                ],
              ),
              SizedBox(height: gap),
              ActionCard(label: 'KALDIĞIN YERDEN DEVAM', title: data.lastTopic, onTap: onStart),
              SizedBox(height: gap),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: BigAction(icon: Icons.bolt_rounded, title: 'Arena', subtitle: '10 soruluk demo', gold: true, onTap: onStart)),
                    const SizedBox(width: 7),
                    const Expanded(child: BigAction(icon: Icons.timer_rounded, title: 'Tam Deneme', subtitle: '120 soru · 155 dk')),
                  ],
                ),
              ),
              SizedBox(height: gap),
              Row(
                children: [
                  const Expanded(child: MiniCard(label: 'ZAYIF KONU', title: 'Borçlar Hukuku', value: '%48')),
                  const SizedBox(width: 7),
                  Expanded(child: MiniCard(label: 'SIRALAMAN', title: 'Türkiye #128', value: 'İstanbul #36', onTap: onRanking)),
                ],
              ),
              SizedBox(height: gap),
              SizedBox(
                height: 37,
                child: OutlinedButton.icon(
                  onPressed: onTogglePremium,
                  icon: Icon(data.premium ? Icons.workspace_premium : Icons.campaign_rounded, size: 17),
                  label: Text(data.premium ? 'Premium · Reklamsız' : 'Ücretsiz · Reklamlı', style: const TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatBox extends StatelessWidget {
  const StatBox({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0E2A48), Color(0xFF08182B)]),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0x44E5BF72)),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label, style: const TextStyle(fontSize: 8, color: Color(0xFF8FA9C0))),
        const SizedBox(height: 2),
        FittedBox(child: Text(value, style: const TextStyle(fontSize: 12, color: arenaGold2, fontWeight: FontWeight.w900))),
      ]),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({super.key, required this.label, required this.title, required this.onTap});
  final String label;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF103861), Color(0xFF0A2038)]),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x5548B7FF)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(children: [
              const Icon(Icons.play_circle_fill_rounded, color: arenaGold),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(label, style: const TextStyle(fontSize: 8, color: arenaElectric, letterSpacing: 1.1)),
                const SizedBox(height: 2),
                FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 14, fontWeight: FontWeight.w700))),
              ])),
              const Icon(Icons.bolt_rounded, size: 18, color: arenaElectric),
            ]),
          ),
        ),
      ),
    );
  }
}

class BigAction extends StatelessWidget {
  const BigAction({super.key, required this.icon, required this.title, required this.subtitle, this.gold = false, this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final bool gold;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gold
            ? const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF5C421C), Color(0xFF142B47)])
            : const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E2E51), Color(0xFF08182B)]),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gold ? const Color(0x66E5BF72) : const Color(0x5548B7FF)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, color: gold ? arenaGold2 : arenaElectric, size: 29),
              const SizedBox(height: 5),
              Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 15, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              FittedBox(child: Text(subtitle, style: const TextStyle(fontSize: 9, color: Color(0xFFA0B5C9)))),
            ]),
          ),
        ),
      ),
    );
  }
}

class MiniCard extends StatelessWidget {
  const MiniCard({super.key, required this.label, required this.title, required this.value, this.onTap});
  final String label;
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xCC081B2F),
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), border: Border.all(color: const Color(0x2248B7FF))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(fontSize: 8, color: Color(0xFF849EB5), letterSpacing: 1)),
            const SizedBox(height: 3),
            FittedBox(child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
            const SizedBox(height: 3),
            Text(value, style: const TextStyle(color: arenaGold2, fontSize: 12, fontWeight: FontWeight.w900)),
          ]),
        ),
      ),
    );
  }
}

class CompactInfoPage extends StatelessWidget {
  const CompactInfoPage({super.key, required this.title, required this.icon, required this.body});
  final String title;
  final IconData icon;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(shape: BoxShape.circle, color: arenaBlue.withOpacity(.15), border: Border.all(color: const Color(0x66E5BF72))),
          child: Icon(icon, size: 54, color: arenaGold),
        ),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 25, color: arenaGold2, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.bolt_rounded, color: arenaElectric, size: 15), SizedBox(width: 4), Text('HMGS ARENA', style: TextStyle(fontSize: 9, letterSpacing: 1.5, color: arenaElectric))]),
        const SizedBox(height: 14),
        Text(body, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFFAAB9C9), height: 1.4)),
      ]),
    );
  }
}

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  int mode = 0;

  @override
  Widget build(BuildContext context) {
    final title = mode == 0 ? 'Türkiye #128' : mode == 1 ? 'İstanbul #36' : 'Kişisel Özet';
    final rows = mode == 0
        ? const [['#126','CorpusIuris','90.35'],['#127','Praetor06','89.95'],['#128','SEN','89.60'],['#129','IusCivilis','89.20'],['#130','Forum35','88.85']]
        : mode == 1
            ? const [['#34','Themis34','90.80'],['#35','CorpusIuris','90.25'],['#36','SEN','89.60'],['#37','Actio','88.10'],['#38','RatioLegis','87.85']]
            : const [['TR','Türkiye','#128'],['IL','İstanbul','#36'],['AR','Haftalık Arena','#54'],['UP','Son 7 gün','+19 sıra']];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      child: Column(children: [
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.bolt_rounded, color: arenaElectric, size: 20),
          SizedBox(width: 5),
          Text('SIRALAMA', style: TextStyle(fontFamily: 'serif', fontSize: 23, color: arenaGold2, fontWeight: FontWeight.w900)),
        ]),
        const SizedBox(height: 8),
        SegmentedButton<int>(
          segments: const [ButtonSegment(value: 0,label: Text('Türkiye')),ButtonSegment(value: 1,label: Text('İl')),ButtonSegment(value: 2,label: Text('Kişisel'))],
          selected: {mode},
          onSelectionChanged: (s) => setState(() => mode = s.first),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF10345A), Color(0xFF0A2038)]),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0x66E5BF72)),
          ),
          child: Column(children: [
            const Text('MEVCUT KONUMUN', style: TextStyle(fontSize: 9, color: Color(0xFFA0B5C9))),
            const SizedBox(height: 3),
            Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 23, color: arenaGold2, fontWeight: FontWeight.w800)),
          ]),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Column(
            children: rows.map((r) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 11),
                decoration: BoxDecoration(
                  color: r[1] == 'SEN' ? const Color(0xFF153F65) : const Color(0xCC081B2F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: r[1] == 'SEN' ? arenaGold : const Color(0x3348B7FF)),
                ),
                child: Row(children: [
                  SizedBox(width: 58, child: Text(r[0], style: const TextStyle(color: arenaGold2, fontWeight: FontWeight.w900))),
                  Expanded(child: Text(r[1], style: const TextStyle(fontWeight: FontWeight.w700))),
                  Text(r[2], style: const TextStyle(color: Color(0xFFC7DDF0), fontWeight: FontWeight.w800)),
                ]),
              ),
            )).toList(),
          ),
        ),
      ]),
    );
  }
}

class QuizResult {
  const QuizResult({required this.correct, required this.answers, required this.lastTopic});
  final int correct;
  final List<int?> answers;
  final String lastTopic;
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.isPremium});
  final bool isPremium;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int seconds = 78;
  int? selected;
  Timer? timer;
  final answers = List<int?>.filled(demoQuestions.length, null);

  ArenaQuestion get q => demoQuestions[index];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    seconds = 78;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted || selected != null) return;
      setState(() => seconds--);
      if (seconds <= 0) {
        t.cancel();
        setState(() {
          selected = -1;
          answers[index] = -1;
        });
      }
    });
  }

  void _select(int value) {
    if (selected != null) return;
    timer?.cancel();
    setState(() {
      selected = value;
      answers[index] = value;
    });
  }

  Future<void> _next() async {
    if (index < demoQuestions.length - 1) {
      setState(() {
        index++;
        selected = null;
      });
      _startTimer();
      return;
    }

    timer?.cancel();
    final correct = List.generate(demoQuestions.length, (i) => answers[i] == demoQuestions[i].correct).where((v) => v).length;

    if (!widget.isPremium) {
      await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FakeAdScreen()));
      if (!mounted) return;
    }

    final result = await Navigator.of(context).push<QuizResult>(
      MaterialPageRoute(builder: (_) => ResultScreen(correct: correct, answers: List<int?>.from(answers))),
    );
    if (!mounted) return;
    Navigator.of(context).pop(result ?? QuizResult(correct: correct, answers: List<int?>.from(answers), lastTopic: '${q.subject} · ${q.topic}'));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final urgent = selected == null && seconds <= 10;
    return Scaffold(
      body: SafeArea(
        child: ZeusBackdrop(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 8),
            child: Column(children: [
              Row(children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.chevron_left_rounded)),
                Expanded(child: Column(children: [
                  Text('${index + 1} / ${demoQuestions.length}', style: const TextStyle(fontWeight: FontWeight.w900)),
                  const Text('ARENA TESTİ', style: TextStyle(fontSize: 8, color: arenaGold2, letterSpacing: 1.5)),
                ])),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: urgent ? const Color(0xFF8B1E1E) : const Color(0xFF10375C),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: urgent ? Colors.redAccent : const Color(0x5548B7FF)),
                  ),
                  child: Text('${(seconds ~/ 60).toString().padLeft(2,'0')}:${(seconds % 60).toString().padLeft(2,'0')}', style: const TextStyle(fontWeight: FontWeight.w900)),
                ),
              ]),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(border: Border.all(color: const Color(0x66E5BF72)), borderRadius: BorderRadius.circular(20), color: const Color(0x660A2038)),
                  child: Text('${q.subject} · ${q.topic}', style: const TextStyle(fontSize: 9, color: arenaGold2)),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 76,
                child: Center(child: Text(q.text, style: const TextStyle(fontFamily: 'serif', fontSize: 17, fontWeight: FontWeight.w700), textAlign: TextAlign.center, maxLines: 4, overflow: TextOverflow.ellipsis)),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Column(
                  children: List.generate(q.options.length, (i) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Material(
                        color: selected == i ? const Color(0xFF164B78) : const Color(0xDD0A1D32),
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: selected == null ? () => _select(i) : null,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: selected == i ? arenaElectric : const Color(0x3348B7FF)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(children: [
                              Container(
                                width: 25,
                                height: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: selected == i ? arenaGold : const Color(0xFF6F86A0))),
                                child: Text(String.fromCharCode(65+i), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                              ),
                              const SizedBox(width: 9),
                              Expanded(child: Text(q.options[i], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12))),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              const SizedBox(height: 6),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: selected == null
                    ? const SizedBox(height: 42)
                    : SizedBox(
                        height: 42,
                        width: double.infinity,
                        child: FilledButton(onPressed: _next, child: Text(index == demoQuestions.length - 1 ? 'Testi Bitir' : 'Sonraki Soru')),
                      ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class FakeAdScreen extends StatefulWidget {
  const FakeAdScreen({super.key});

  @override
  State<FakeAdScreen> createState() => _FakeAdScreenState();
}

class _FakeAdScreenState extends State<FakeAdScreen> {
  int n = 2;
  Timer? t;

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => n--);
      if (n <= 0) Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZeusBackdrop(
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.bolt_rounded, size: 46, color: arenaElectric),
              const Text('HMGS ARENA', style: TextStyle(color: arenaGold2, letterSpacing: 2, fontWeight: FontWeight.w900)),
              const SizedBox(height: 18),
              Container(width: 270, height: 170, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xDD0A2038), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0x66E5BF72))), child: const Text('REKLAM ALANI', style: TextStyle(color: arenaGold2, letterSpacing: 2, fontWeight: FontWeight.w900))),
              const SizedBox(height: 16),
              const Text('Ücretsiz sürümde sonuçtan önce reklam gösterilir.', style: TextStyle(color: Color(0xFF91A4B8))),
              const SizedBox(height: 14),
              Text('$n', style: const TextStyle(fontFamily: 'serif', color: arenaGold2, fontSize: 44, fontWeight: FontWeight.w900)),
            ]),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.correct, required this.answers});
  final int correct;
  final List<int?> answers;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int review = -1;

  List<int> get wrong => List.generate(demoQuestions.length, (i) => i).where((i) => widget.answers[i] != demoQuestions[i].correct).toList();

  @override
  Widget build(BuildContext context) {
    if (review >= 0 && wrong.isNotEmpty) {
      final qi = wrong[review];
      final q = demoQuestions[qi];
      final a = widget.answers[qi];
      final user = a == null || a == -1 ? 'Boş' : '${String.fromCharCode(65+a)}) ${q.options[a]}';
      final right = '${String.fromCharCode(65+q.correct)}) ${q.options[q.correct]}';
      return Scaffold(
        body: SafeArea(
          child: ZeusBackdrop(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(children: [
                Row(children: [
                  IconButton(onPressed: () => setState(() => review = -1), icon: const Icon(Icons.chevron_left)),
                  Expanded(child: Text('${review+1} / ${wrong.length}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900))),
                  const SizedBox(width: 48),
                ]),
                const SizedBox(height: 8),
                Text('${q.subject} · ${q.topic}', style: const TextStyle(color: arenaGold2, fontSize: 11)),
                const SizedBox(height: 12),
                Text(q.text, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'serif', fontSize: 19, fontWeight: FontWeight.w800)),
                const SizedBox(height: 16),
                Expanded(child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: const Color(0xDD081B2F), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0x3348B7FF))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Senin cevabın: $user', style: const TextStyle(color: Color(0xFFFFB1B1))),
                    const SizedBox(height: 12),
                    Text('Doğru cevap: $right', style: const TextStyle(color: Color(0xFF91E0B9))),
                    const SizedBox(height: 16),
                    Text(q.explanation, style: const TextStyle(color: Color(0xFFAAB9C9), height: 1.4)),
                  ]),
                )),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: OutlinedButton(onPressed: review > 0 ? () => setState(() => review--) : null, child: const Text('Önceki'))),
                  const SizedBox(width: 8),
                  Expanded(child: FilledButton(onPressed: () { if (review < wrong.length-1) { setState(() => review++); } else { setState(() => review=-1); } }, child: Text(review < wrong.length-1 ? 'Sonraki' : 'Bitti'))),
                ]),
              ]),
            ),
          ),
        ),
      );
    }

    final wrongCount = demoQuestions.length - widget.correct;
    return Scaffold(
      body: SafeArea(
        child: ZeusBackdrop(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.bolt_rounded, size: 62, color: arenaElectric),
              const Text('ARENA TAMAMLANDI', style: TextStyle(fontSize: 10, letterSpacing: 2, color: arenaGold2, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('${widget.correct} / ${demoQuestions.length}', style: const TextStyle(fontFamily: 'serif', fontSize: 48, color: arenaGold2, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: StatBox(label: 'DOĞRU', value: '${widget.correct}')),
                const SizedBox(width: 7),
                Expanded(child: StatBox(label: 'YANLIŞ/BOŞ', value: '$wrongCount')),
                const SizedBox(width: 7),
                Expanded(child: StatBox(label: 'XP', value: '+${widget.correct*100}')),
              ]),
              const SizedBox(height: 18),
              SizedBox(width: double.infinity, child: FilledButton(onPressed: wrong.isEmpty ? null : () => setState(() => review = 0), child: const Text('Yanlış Soruları İncele'))),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Navigator.pop(context, QuizResult(correct: widget.correct, answers: widget.answers, lastTopic: '${demoQuestions.last.subject} · ${demoQuestions.last.topic}')), child: const Text('Arena’ya Dön'))),
            ]),
          ),
        ),
      ),
    );
  }
}
