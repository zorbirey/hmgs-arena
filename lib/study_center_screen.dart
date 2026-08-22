import 'dart:math';

import 'package:flutter/material.dart';

import 'question.dart';
import 'question_bank.dart';
import 'question_difficulty.dart';

class StudyCenterScreen extends StatefulWidget {
  const StudyCenterScreen({super.key});

  @override
  State<StudyCenterScreen> createState() => _StudyCenterScreenState();
}

class _StudyCenterScreenState extends State<StudyCenterScreen> {
  late final Future<QuestionBank> _bankFuture = QuestionBank.load();
  String? _subject;
  String? _topic;
  QuestionDifficulty? _difficulty;

  static const _gold = Color(0xFFFFD778);
  static const _panel = Color(0xE60A2038);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Çalışma Merkezi', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: FutureBuilder<QuestionBank>(
        future: _bankFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Soru havuzu yüklenemedi: ${snapshot.error ?? ''}'),
              ),
            );
          }

          final bank = snapshot.data!;
          final subjects = bank.subjects.toList()..sort();
          final topics = _subject == null
              ? <String>[]
              : (bank.questions.where((q) => q.subject == _subject).map((q) => q.topic).toSet().toList()..sort());
          final filtered = bank.questions.where((q) {
            if (_subject != null && q.subject != _subject) return false;
            if (_topic != null && q.topic != _topic) return false;
            if (_difficulty != null && q.difficulty != _difficulty) return false;
            return true;
          }).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            children: [
              const _HeaderCard(),
              const SizedBox(height: 14),
              _SectionCard(
                title: '1. Ders seç',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: subjects.map((subject) {
                    final count = bank.questions.where((q) => q.subject == subject).length;
                    return ChoiceChip(
                      label: Text('$subject  ·  $count'),
                      selected: _subject == subject,
                      onSelected: (_) => setState(() {
                        _subject = _subject == subject ? null : subject;
                        _topic = null;
                      }),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              _SectionCard(
                title: '2. Konu seç',
                child: _subject == null
                    ? const Text('Önce bir ders seç.')
                    : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: topics.map((topic) {
                          final count = bank.questions.where((q) => q.subject == _subject && q.topic == topic).length;
                          return ChoiceChip(
                            label: Text('$topic  ·  $count'),
                            selected: _topic == topic,
                            onSelected: (_) => setState(() => _topic = _topic == topic ? null : topic),
                          );
                        }).toList(),
                      ),
              ),
              const SizedBox(height: 12),
              _SectionCard(
                title: '3. Zorluk seç',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Dengeli / Tümü'),
                      selected: _difficulty == null,
                      onSelected: (_) => setState(() => _difficulty = null),
                    ),
                    ...QuestionDifficulty.values.map((level) => ChoiceChip(
                          label: Text(level.label),
                          selected: _difficulty == level,
                          onSelected: (_) => setState(() => _difficulty = _difficulty == level ? null : level),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _panel,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0x5577CFFF)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.quiz_rounded, color: _gold, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${filtered.length} uygun soru', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                          const SizedBox(height: 3),
                          Text(_selectionText()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 58,
                child: FilledButton.icon(
                  onPressed: filtered.isEmpty ? null : () => _startStudy(filtered),
                  style: FilledButton.styleFrom(
                    backgroundColor: _gold,
                    foregroundColor: const Color(0xFF07101C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
                  ),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('ÇALIŞMAYA BAŞLA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _selectionText() {
    final parts = <String>[
      _subject ?? 'Tüm dersler',
      if (_topic != null) _topic!,
      _difficulty?.label ?? 'Dengeli',
    ];
    return parts.join('  ›  ');
  }

  void _startStudy(List<Question> source) {
    final questions = List<Question>.from(source)..shuffle(Random());
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => StudyQuizScreen(questions: questions.take(20).toList())));
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xEE162D49), Color(0xEE071525)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x55FFD778)),
      ),
      child: const Row(
        children: [
          Icon(Icons.menu_book_rounded, color: Color(0xFFFFD778), size: 36),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('HMGS Çalışma Arenası', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
                SizedBox(height: 5),
                Text('Ders → konu → zorluk seç. 20 soruluk odaklı çalışma turunu başlat.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xE60A2038),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x3377CFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFFFFD778), fontWeight: FontWeight.w900, fontSize: 16)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class StudyQuizScreen extends StatefulWidget {
  const StudyQuizScreen({super.key, required this.questions});
  final List<Question> questions;

  @override
  State<StudyQuizScreen> createState() => _StudyQuizScreenState();
}

class _StudyQuizScreenState extends State<StudyQuizScreen> {
  int _index = 0;
  int? _selected;
  int _correct = 0;

  Question get _q => widget.questions[_index];

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return const Scaffold(body: Center(child: Text('Bu seçimde soru bulunamadı.')));
    }
    return Scaffold(
      appBar: AppBar(title: Text('${_q.subject} · ${_q.topic}')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          LinearProgressIndicator(value: (_index + 1) / widget.questions.length),
          const SizedBox(height: 14),
          Text('Soru ${_index + 1}/${widget.questions.length} · ${_q.difficulty.label}', style: const TextStyle(color: Color(0xFFFFD778), fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(_q.question, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, height: 1.35)),
          const SizedBox(height: 18),
          ...List.generate(_q.options.length, (i) {
            final answered = _selected != null;
            final correct = i == _q.correctIndex;
            Color? color;
            if (answered && correct) color = Colors.green.withValues(alpha: .25);
            if (answered && i == _selected && !correct) color = Colors.red.withValues(alpha: .25);
            return Card(
              color: color ?? const Color(0xE60A2038),
              child: ListTile(
                onTap: answered ? null : () => setState(() {
                  _selected = i;
                  if (i == _q.correctIndex) _correct++;
                }),
                leading: CircleAvatar(child: Text(String.fromCharCode(65 + i))),
                title: Text(_q.options[i]),
              ),
            );
          }),
          if (_selected != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: const Color(0xE61A2636), borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Çözüm / Açıklama', style: TextStyle(color: Color(0xFFFFD778), fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Text(_q.explanation),
                  const SizedBox(height: 6),
                  Text('Kaynak: ${_q.sourceLabel} ${_q.sourceRef}', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: _next,
              child: Text(_index == widget.questions.length - 1 ? 'SONUCU GÖR' : 'SONRAKİ SORU'),
            ),
          ],
        ],
      ),
    );
  }

  void _next() {
    if (_index == widget.questions.length - 1) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Çalışma tamamlandı'),
          content: Text('${widget.questions.length} soruda $_correct doğru yaptın.\nBaşarı: %${((_correct / widget.questions.length) * 100).round()}'),
          actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('ÇALIŞMA MERKEZİNE DÖN'))],
        ),
      );
      return;
    }
    setState(() {
      _index++;
      _selected = null;
    });
  }
}
