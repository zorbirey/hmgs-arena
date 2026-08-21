import 'dart:async';

import 'package:flutter/material.dart';

void main() {
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
        scaffoldBackgroundColor: const Color(0xFF061120),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD7A84A),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const IntroFlow(),
    );
  }
}

class IntroFlow extends StatefulWidget {
  const IntroFlow({super.key});

  @override
  State<IntroFlow> createState() => _IntroFlowState();
}

class _IntroFlowState extends State<IntroFlow> {
  int page = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      if (page < 1) {
        setState(() => page++);
      } else {
        timer?.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ArenaShell()),
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (page == 0) {
      return const BrandSplash(
        icon: Icons.sports_martial_arts,
        title: 'HMGS ARENA',
        subtitle: 'PER ASPERA AD ASTRA\nZorluklardan yıldızlara',
      );
    }
    return const BrandSplash(
      icon: Icons.bolt,
      title: 'INSPIRED FROM ZEUS',
      subtitle: 'Bilgi, disiplin ve mücadele',
    );
  }
}

class BrandSplash extends StatelessWidget {
  const BrandSplash({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF101B2B), Color(0xFF02060B)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 116, color: const Color(0xFFD7A84A)),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArenaShell extends StatefulWidget {
  const ArenaShell({super.key});

  @override
  State<ArenaShell> createState() => _ArenaShellState();
}

class _ArenaShellState extends State<ArenaShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const StudyPage(),
      const TrialExamPage(),
      const WeakTopicsPage(),
      const RankingPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Arena'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Çalış'),
          NavigationDestination(icon: Icon(Icons.timer_outlined), label: 'Deneme'),
          NavigationDestination(icon: Icon(Icons.analytics_outlined), label: 'Zayıf'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), label: 'Sıralama'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ArenaScaffold(
      title: 'HMGS ARENA',
      child: Column(
        children: [
          StatRow(),
          SizedBox(height: 18),
          ChallengeCard(),
          SizedBox(height: 14),
          ProgressCard(),
          Spacer(),
          Text('PER ASPERA AD ASTRA', style: TextStyle(letterSpacing: 2)),
        ],
      ),
    );
  }
}

class StatRow extends StatelessWidget {
  const StatRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: StatBox(label: 'CAN', value: '1', icon: Icons.favorite)),
        SizedBox(width: 10),
        Expanded(child: StatBox(label: 'SERİ', value: '12', icon: Icons.local_fire_department)),
        SizedBox(width: 10),
        Expanded(child: StatBox(label: 'XP', value: '2.480', icon: Icons.bolt)),
      ],
    );
  }
}

class StatBox extends StatelessWidget {
  const StatBox({super.key, required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: cardDecoration,
      child: Column(
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: cardDecoration,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('GÜNLÜK MEYDAN OKUMA', style: TextStyle(fontWeight: FontWeight.w900)),
          SizedBox(height: 8),
          Text('10 soru · 1 can · yanlış yapmadan tamamla'),
          SizedBox(height: 10),
          Text('+1.000 XP', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: cardDecoration,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Seviye 14 · Stajyer Avukat', style: TextStyle(fontWeight: FontWeight.w800)),
          SizedBox(height: 12),
          LinearProgressIndicator(value: .62),
          SizedBox(height: 8),
          Text('Sonraki seviye için 1.520 XP'),
        ],
      ),
    );
  }
}

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ArenaScaffold(
      title: 'ÇALIŞMA MODU',
      child: Column(
        children: [
          const Text('Sınırsız çalışma · 5 zorluk seviyesi · yakın soru tekrarı yok'),
          const SizedBox(height: 16),
          ...['Çok Kolay', 'Kolay', 'Orta', 'Zor', 'Çok Zor', 'Rastgele · eşit dağılım'].map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(onPressed: () {}, child: Text(e)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrialExamPage extends StatelessWidget {
  const TrialExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ArenaScaffold(
      title: 'DENEME SINAVI',
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: cardDecoration,
            child: const Column(
              children: [
                Text('120 SORU', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
                Text('155 dakika · gerçek sınav temposu'),
                SizedBox(height: 12),
                Text('Soru başına ortalama 01:17', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ExamSessionPage()));
              },
              child: const Text('DENEMEYİ BAŞLAT', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ),
          const SizedBox(height: 14),
          const Text('Süre dolduğunda sınav otomatik biter. Sonuç ekranı sınav bitiminden sonra açılır.'),
        ],
      ),
    );
  }
}

class ExamSessionPage extends StatefulWidget {
  const ExamSessionPage({super.key});

  @override
  State<ExamSessionPage> createState() => _ExamSessionPageState();
}

class _ExamSessionPageState extends State<ExamSessionPage> {
  int current = 1;
  int selected = -1;
  int secondsLeft = 77;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (secondsLeft > 0) {
        setState(() => secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get clock => '${(secondsLeft ~/ 60).toString().padLeft(2, '0')}:${(secondsLeft % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final danger = selected == -1 && secondsLeft <= 10;
    return Scaffold(
      backgroundColor: danger && secondsLeft.isEven ? const Color(0xFF651111) : const Color(0xFF061120),
      appBar: AppBar(
        title: Text('$current / 120'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Center(child: Text(clock, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: cardDecoration,
                child: const Text(
                  'Örnek soru alanı: HMGS özgün soru bankasından gelen soru burada gösterilecek. Sınav sırasında doğru/yanlış geri bildirimi verilmez.',
                  style: TextStyle(fontSize: 18, height: 1.4),
                ),
              ),
              const SizedBox(height: 16),
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => setState(() => selected = i),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: selected == i ? Colors.white12 : null,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${String.fromCharCode(65 + i)}) Cevap seçeneği'),
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: current > 1 ? () => setState(() => current--) : null, child: const Text('ÖNCEKİ'))),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          if (current < 120) current++;
                          selected = -1;
                          secondsLeft = 77;
                        });
                      },
                      child: const Text('SONRAKİ'),
                    ),
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

class WeakTopicsPage extends StatelessWidget {
  const WeakTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ArenaScaffold(
      title: 'ZAYIF KONULAR',
      child: Column(
        children: [
          WeakTopicCard(course: 'Borçlar Hukuku', topic: 'Haksız Fiil', score: 42),
          SizedBox(height: 10),
          WeakTopicCard(course: 'İcra ve İflas', topic: 'Takip Hukuku', score: 51),
          SizedBox(height: 10),
          WeakTopicCard(course: 'Ceza Hukuku', topic: 'Teşebbüs', score: 64),
        ],
      ),
    );
  }
}

class WeakTopicCard extends StatelessWidget {
  const WeakTopicCard({super.key, required this.course, required this.topic, required this.score});

  final String course;
  final String topic;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration,
      child: Row(
        children: [
          Expanded(child: Text('$course\n$topic', style: const TextStyle(fontWeight: FontWeight.w700))),
          Text('%$score', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ArenaScaffold(
      title: 'SIRALAMA',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Türkiye · İl · Kişisel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          SizedBox(height: 20),
          StatBox(label: 'ARENA PUANI', value: '8.420', icon: Icons.emoji_events),
          SizedBox(height: 12),
          StatBox(label: 'TÜRKİYE SIRASI', value: '#184', icon: Icons.public),
        ],
      ),
    );
  }
}

class ArenaScaffold extends StatelessWidget {
  const ArenaScaffold({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: child,
        ),
      ),
    );
  }
}

const cardDecoration = BoxDecoration(
  color: Color(0xFF101B2B),
  borderRadius: BorderRadius.all(Radius.circular(18)),
  border: Border.fromBorderSide(BorderSide(color: Color(0x332FA9FF))),
);
