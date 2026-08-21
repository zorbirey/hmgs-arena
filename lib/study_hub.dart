import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'smart_notes.dart';

const _navy = Color(0xFF020914);
const _panel = Color(0xFF0A2038);
const _blue = Color(0xFF48B7FF);
const _gold = Color(0xFFE5BF72);
const _gold2 = Color(0xFFFFD98A);

const extraSmartNotes = <SmartNote>[
  SmartNote(
    id: 'SN-021',
    subject: 'Anayasa Hukuku',
    kind: 'Mutlaka Bil',
    title: 'Temel haklar yalnız kanunla sınırlanır',
    body: 'Temel hak ve hürriyetler yalnız kanunla, ilgili Anayasa maddesinde belirtilen sebeplere bağlı olarak ve ölçülülük ilkesine uygun biçimde sınırlanabilir.',
    trap: 'Genelge veya sıradan bir idari işlem temel hak sınırlamasının genel aracı değildir.',
    sourceRef: 'Anayasa m.13',
  ),
  SmartNote(
    id: 'SN-022',
    subject: 'Anayasa Hukuku',
    kind: 'Sık Karıştırılan',
    title: 'Gizli oy – açık sayım',
    body: 'Seçimler ve halkoylaması serbest, eşit, gizli, tek dereceli ve genel oy esaslarına göre; açık sayım ve döküm altında yapılır.',
    trap: 'Sınavda sık yapılan hata “açık oy – gizli sayım” şeklinde ters çevirmektir.',
    sourceRef: 'Anayasa m.67',
  ),
  SmartNote(
    id: 'SN-023',
    subject: 'Ticaret Hukuku',
    kind: 'Sık Karıştırılan',
    title: 'Fiilen başlamadan tacir olunabilir',
    body: 'Ticari işletmesini tescil ve ilan ettiren veya işletmesini açtığını halka bildiren kişi fiilen işletmeye başlamamış olsa da tacir sayılır.',
    trap: 'Tacir sıfatını her durumda fiilî işletme başlangıcına bağlama.',
    sourceRef: 'TTK m.12/2',
  ),
  SmartNote(
    id: 'SN-024',
    subject: 'Ticaret Hukuku',
    kind: 'Sık Karıştırılan',
    title: 'Küçük işletme sahibi – yasal temsilci',
    body: 'Küçüğe veya kısıtlıya ait ticari işletme yasal temsilci tarafından işletilirse tacir sıfatı temsil edilene aittir.',
    trap: 'Yasal temsilci tacir değildir; ceza hükümleri yönünden tacir gibi sorumlu olabilmesi ayrı konudur.',
    sourceRef: 'TTK m.13',
  ),
  SmartNote(
    id: 'SN-025',
    subject: 'Hukuk Yargılama Usulü',
    kind: 'Mutlaka Bil',
    title: 'Taşınmaz aynında kesin yetki',
    body: 'Taşınmaz üzerindeki ayni hakka ilişkin davalarda taşınmazın bulunduğu yer mahkemesi kesin yetkilidir.',
    trap: 'Burada genel yetki kuralı olan davalının yerleşim yeri esas alınmaz.',
    sourceRef: 'HMK m.12/1',
  ),
  SmartNote(
    id: 'SN-026',
    subject: 'Hukuk Yargılama Usulü',
    kind: 'Sık Karıştırılan',
    title: 'Yetki sözleşmesinin üç kilidi',
    body: 'Yetki sözleşmesi kural olarak tacirler veya kamu tüzel kişileri arasında yapılabilir, yazılı olmalıdır ve kesin yetki bulunan konuda yapılamaz.',
    trap: 'Her iki gerçek kişi sırf anlaşarak dilediği mahkemeyi yetkili kılamaz.',
    sourceRef: 'HMK m.17-18',
  ),
  SmartNote(
    id: 'SN-027',
    subject: 'Ceza Hukuku',
    kind: 'Mutlaka Bil',
    title: 'Ceza hukukunda kıyas yasaktır',
    body: 'Kanunun açıkça suç saymadığı bir fiil için ceza verilemez ve güvenlik tedbiri uygulanamaz. Suç ve ceza içeren hükümler kıyasa yol açacak biçimde geniş yorumlanamaz.',
    trap: 'Örf ve âdet yeni bir suç veya ceza yaratamaz.',
    sourceRef: 'TCK m.2',
  ),
  SmartNote(
    id: 'SN-028',
    subject: 'Ceza Hukuku',
    kind: 'Sık Karıştırılan',
    title: 'Tüzel kişiye ceza yaptırımı yok',
    body: 'Tüzel kişiler hakkında ceza yaptırımı uygulanamaz. Suç dolayısıyla kanunda öngörülen güvenlik tedbirleri saklıdır.',
    trap: '“Tüzel kişiye hapis veya adli para cezası verilir” şeklinde genelleme yapma.',
    sourceRef: 'TCK m.20/2',
  ),
  SmartNote(
    id: 'SN-029',
    subject: 'İcra ve İflas',
    kind: 'Süre / Sayı',
    title: 'İtiraz 7 gün ve sonucu takip durur',
    body: 'Genel haciz yoluyla ilamsız takipte borçlu ödeme emrinin tebliğinden itibaren 7 gün içinde itiraz edebilir. Süresinde yapılan itiraz takibi durdurur.',
    trap: 'İtiraz alacağı ortadan kaldırmaz; takip işlemlerini durdurur.',
    sourceRef: 'İİK m.62/1 ve m.66',
  ),
  SmartNote(
    id: 'SN-030',
    subject: 'Medeni Hukuk',
    kind: 'Sık Karıştırılan',
    title: 'Hak ehliyeti – fiil ehliyeti',
    body: 'Her insanın hak ehliyeti vardır. Tam fiil ehliyeti için ayırt etme gücü, erginlik ve kısıtlı olmama birlikte aranır.',
    trap: 'Hak sahibi olabilmek ile kendi işlemleriyle hak kazanıp borç altına girebilmek aynı kavram değildir.',
    sourceRef: 'TMK m.8 ve m.10',
  ),
];

final List<SmartNote> allSmartNotes = List<SmartNote>.unmodifiable(<SmartNote>[
  ...smartNotes,
  ...extraSmartNotes,
]);

class StudyHubPage extends StatelessWidget {
  const StudyHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bolt_rounded, color: _blue, size: 20),
              SizedBox(width: 5),
              Text('ÇALIŞMA', style: TextStyle(fontFamily: 'serif', fontSize: 23, color: _gold2, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Kısa, net, sınav odaklı tekrar', style: TextStyle(fontSize: 10, color: Color(0xFFA4B8CA))),
          const SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: _StudyTile(
              icon: Icons.auto_awesome_rounded,
              eyebrow: '30 DOĞRULANMIŞ KART',
              title: 'Akıllı Notlar',
              body: 'Bilinmesi gerekenler, süreler, sayılar ve en çok karıştırılan ayrımlar.',
              active: true,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SmartNotesArenaScreen())),
            ),
          ),
          const SizedBox(height: 8),
          const Expanded(
            flex: 3,
            child: _StudyTile(
              icon: Icons.style_rounded,
              eyebrow: 'YAKINDA',
              title: 'Bilgi Kartları',
              body: 'Konu bazlı özet ve madde kartları.',
            ),
          ),
          const SizedBox(height: 8),
          const Expanded(
            flex: 3,
            child: _StudyTile(
              icon: Icons.quiz_rounded,
              eyebrow: 'YAKINDA',
              title: 'Konu Testleri',
              body: 'Seçtiğin konudan kısa odak testleri.',
            ),
          ),
        ],
      ),
    );
  }
}

class _StudyTile extends StatelessWidget {
  const _StudyTile({required this.icon, required this.eyebrow, required this.title, required this.body, this.active = false, this.onTap});

  final IconData icon;
  final String eyebrow;
  final String title;
  final String body;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: active ? const [Color(0xFF123D66), Color(0xFF0B213A)] : const [Color(0xCC0A2038), Color(0xCC07182C)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: active ? const Color(0x88E5BF72) : const Color(0x3348B7FF)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: _blue.withOpacity(.13), border: Border.all(color: active ? _gold : const Color(0x5548B7FF))),
                  child: Icon(icon, color: active ? _gold2 : _blue, size: 27),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(eyebrow, style: TextStyle(fontSize: 8, letterSpacing: 1.1, color: active ? _gold2 : const Color(0xFF8FA9C0), fontWeight: FontWeight.w800)),
                      const SizedBox(height: 3),
                      Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 17, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 3),
                      Text(body, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, height: 1.25, color: Color(0xFFAFC1D2))),
                    ],
                  ),
                ),
                if (active) const Icon(Icons.chevron_right_rounded, color: _gold2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SmartNotesArenaScreen extends StatefulWidget {
  const SmartNotesArenaScreen({super.key});

  @override
  State<SmartNotesArenaScreen> createState() => _SmartNotesArenaScreenState();
}

class _SmartNotesArenaScreenState extends State<SmartNotesArenaScreen> {
  int index = 0;
  String filter = 'Tümü';
  Set<String> learned = <String>{};
  Set<String> repeat = <String>{};

  List<SmartNote> get visible {
    if (filter == 'Tümü') return allSmartNotes;
    if (filter == 'Tekrar') {
      final result = allSmartNotes.where((n) => repeat.contains(n.id)).toList(growable: false);
      return result.isEmpty ? allSmartNotes : result;
    }
    return allSmartNotes.where((n) => n.kind == filter).toList(growable: false);
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    learned = (p.getStringList('smart_notes_learned') ?? const <String>[]).toSet();
    repeat = (p.getStringList('smart_notes_repeat') ?? const <String>[]).toSet();
    if (mounted) setState(() {});
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setStringList('smart_notes_learned', learned.toList());
    await p.setStringList('smart_notes_repeat', repeat.toList());
  }

  void _setFilter(String value) {
    setState(() {
      filter = value;
      index = 0;
    });
  }

  void _next() {
    final list = visible;
    if (list.isEmpty) return;
    setState(() => index = (index + 1) % list.length);
  }

  void _previous() {
    final list = visible;
    if (list.isEmpty) return;
    setState(() => index = (index - 1 + list.length) % list.length);
  }

  Future<void> _markLearned(SmartNote note) async {
    setState(() {
      learned.add(note.id);
      repeat.remove(note.id);
    });
    await _save();
    _next();
  }

  Future<void> _markRepeat(SmartNote note) async {
    setState(() {
      repeat.add(note.id);
      learned.remove(note.id);
    });
    await _save();
    _next();
  }

  Color _kindColor(String kind) {
    switch (kind) {
      case 'Mutlaka Bil':
        return _gold2;
      case 'Sık Karıştırılan':
        return const Color(0xFFFF9B73);
      case 'Süre / Sayı':
        return _blue;
      case 'İstisna':
        return const Color(0xFFC7A7FF);
      default:
        return _gold;
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = visible;
    if (list.isEmpty) {
      return const Scaffold(backgroundColor: _navy, body: SafeArea(child: Center(child: Text('Bu filtrede kart bulunamadı.'))));
    }
    if (index >= list.length) index = 0;
    final note = list[index];

    return Scaffold(
      backgroundColor: _navy,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF071E3B), _navy, Color(0xFF030A14)])),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.chevron_left_rounded)),
                    const Expanded(
                      child: Column(
                        children: [
                          Text('AKILLI NOTLAR', style: TextStyle(color: _gold2, fontSize: 20, fontWeight: FontWeight.w900, fontFamily: 'serif')),
                          Text('HMGS ARENA · HIZLI TEKRAR', style: TextStyle(color: _blue, fontSize: 8, letterSpacing: 1.5, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      tooltip: 'Not filtresi',
                      initialValue: filter,
                      onSelected: _setFilter,
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'Tümü', child: Text('Tümü')),
                        PopupMenuItem(value: 'Mutlaka Bil', child: Text('Mutlaka Bil')),
                        PopupMenuItem(value: 'Sık Karıştırılan', child: Text('Sık Karıştırılan')),
                        PopupMenuItem(value: 'Süre / Sayı', child: Text('Süre / Sayı')),
                        PopupMenuItem(value: 'İstisna', child: Text('İstisna')),
                        PopupMenuItem(value: 'Tekrar', child: Text('Tekrar Göster')),
                      ],
                      icon: const Icon(Icons.tune_rounded, color: _gold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _MiniStat(label: 'KART', value: '${index + 1}/${list.length}')),
                    const SizedBox(width: 6),
                    Expanded(child: _MiniStat(label: 'BİLDİM', value: '${learned.length}/30')),
                    const SizedBox(width: 6),
                    Expanded(child: _MiniStat(label: 'TEKRAR', value: '${repeat.length}')),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF10345A), _panel, Color(0xFF07182C)]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _kindColor(note.kind).withOpacity(.65)),
                      boxShadow: [BoxShadow(color: _kindColor(note.kind).withOpacity(.08), blurRadius: 22)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                              decoration: BoxDecoration(color: _kindColor(note.kind).withOpacity(.12), borderRadius: BorderRadius.circular(20), border: Border.all(color: _kindColor(note.kind).withOpacity(.45))),
                              child: Text(note.kind.toUpperCase(), style: TextStyle(color: _kindColor(note.kind), fontSize: 8, letterSpacing: 1, fontWeight: FontWeight.w900)),
                            ),
                            const Spacer(),
                            Flexible(child: Text(note.subject, textAlign: TextAlign.right, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF9DB5CA), fontSize: 9, fontWeight: FontWeight.w700))),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(note.title, style: const TextStyle(color: _gold2, fontSize: 20, height: 1.05, fontFamily: 'serif', fontWeight: FontWeight.w900)),
                        const SizedBox(height: 10),
                        Expanded(child: Center(child: Text(note.body, style: const TextStyle(fontSize: 14, height: 1.42, color: Color(0xFFF3F5F7), fontWeight: FontWeight.w500)))),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: const Color(0xFF081725), borderRadius: BorderRadius.circular(13), border: Border.all(color: const Color(0x44FF9B73))),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Icon(Icons.warning_amber_rounded, size: 19, color: Color(0xFFFFA276)),
                            const SizedBox(width: 8),
                            Expanded(child: Text(note.trap, style: const TextStyle(fontSize: 11, height: 1.32, color: Color(0xFFD9E2EA)))),
                          ]),
                        ),
                        const SizedBox(height: 8),
                        Row(children: [
                          const Icon(Icons.verified_rounded, size: 15, color: _blue),
                          const SizedBox(width: 5),
                          Expanded(child: Text('Kaynak: ${note.sourceRef}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _blue, fontSize: 9, fontWeight: FontWeight.w800))),
                        ]),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(width: 42, height: 43, child: OutlinedButton(onPressed: _previous, child: const Icon(Icons.chevron_left_rounded))),
                    const SizedBox(width: 6),
                    Expanded(child: SizedBox(height: 43, child: OutlinedButton.icon(onPressed: () => _markRepeat(note), icon: const Icon(Icons.replay_rounded, size: 18), label: const Text('Tekrar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800))))),
                    const SizedBox(width: 6),
                    Expanded(child: SizedBox(height: 43, child: FilledButton.icon(onPressed: () => _markLearned(note), icon: const Icon(Icons.check_rounded, size: 18), label: const Text('Bildim', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900))))),
                    const SizedBox(width: 6),
                    SizedBox(width: 42, height: 43, child: OutlinedButton(onPressed: _next, child: const Icon(Icons.chevron_right_rounded))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: const Color(0xCC081B2F), borderRadius: BorderRadius.circular(11), border: Border.all(color: const Color(0x3348B7FF))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(label, style: const TextStyle(fontSize: 7, color: Color(0xFF8DA5BC), letterSpacing: .8)),
        const SizedBox(height: 1),
        Text(value, style: const TextStyle(fontSize: 11, color: _gold2, fontWeight: FontWeight.w900)),
      ]),
    );
  }
}
