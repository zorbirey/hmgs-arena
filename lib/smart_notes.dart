import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _navy = Color(0xFF020914);
const _panel = Color(0xFF0A2038);
const _blue = Color(0xFF48B7FF);
const _gold = Color(0xFFE5BF72);
const _gold2 = Color(0xFFFFD98A);

class SmartNote {
  const SmartNote({
    required this.id,
    required this.subject,
    required this.kind,
    required this.title,
    required this.body,
    required this.trap,
    required this.sourceRef,
  });

  final String id;
  final String subject;
  final String kind;
  final String title;
  final String body;
  final String trap;
  final String sourceRef;
}

const smartNotes = <SmartNote>[
  SmartNote(
    id: 'SN-001',
    subject: 'Anayasa Hukuku',
    kind: 'Mutlaka Bil',
    title: 'Egemenlik kime aittir?',
    body: 'Egemenlik kayıtsız şartsız Milletindir. Türk Milleti egemenliğini Anayasanın koyduğu esaslara göre yetkili organları eliyle kullanır.',
    trap: 'Egemenlik TBMM’ye değil Millete aittir. TBMM egemenliği kullanan anayasal organlardan biridir.',
    sourceRef: 'Anayasa m.6',
  ),
  SmartNote(
    id: 'SN-002',
    subject: 'Vergi Hukuku',
    kind: 'Mutlaka Bil',
    title: 'Vergide kanunilik',
    body: 'Vergi, resim, harç ve benzeri mali yükümlülükler kanunla konulur, değiştirilir veya kaldırılır.',
    trap: 'Cumhurbaşkanına verilen yetki yeni bir vergi yaratma yetkisi değildir; kanunun belirlediği sınırlar içinde muaflık, istisna, indirim ve oranlara ilişkindir.',
    sourceRef: 'Anayasa m.73/3-4',
  ),
  SmartNote(
    id: 'SN-003',
    subject: 'Ceza Hukuku',
    kind: 'Sık Karıştırılan',
    title: 'Kast ve taksir ayrımı',
    body: 'Kast, suçun kanuni tanımındaki unsurların bilerek ve istenerek gerçekleştirilmesidir. Taksirli fiiller ise ancak kanunun açıkça belirttiği hâllerde cezalandırılır.',
    trap: 'Her öngörülen netice kast değildir. Olası kast ile bilinçli taksir ayrımında failin neticeye yönelik iradesi önemlidir.',
    sourceRef: 'TCK m.21-22',
  ),
  SmartNote(
    id: 'SN-004',
    subject: 'Ceza Muhakemesi',
    kind: 'Sık Karıştırılan',
    title: 'Şüpheli ne zaman sanık olur?',
    body: 'Soruşturma evresindeki kişi şüphelidir. Kovuşturma, iddianamenin kabulüyle başlar ve kişi sanık sıfatını alır.',
    trap: 'İddianamenin düzenlenmesi ile kabul edilmesi aynı şey değildir. Sanık sıfatı kabul ile başlar.',
    sourceRef: 'CMK m.2/1-a, b, f',
  ),
  SmartNote(
    id: 'SN-005',
    subject: 'Ceza Muhakemesi',
    kind: 'Mutlaka Bil',
    title: 'Tutuklama için iki temel koşul',
    body: 'Kuvvetli suç şüphesini gösteren somut deliller ile bir tutuklama nedeninin birlikte bulunması gerekir. Ayrıca ölçülülük aranır.',
    trap: 'Bir suçun katalog suç olması tek başına otomatik tutuklama anlamına gelmez.',
    sourceRef: 'CMK m.100',
  ),
  SmartNote(
    id: 'SN-006',
    subject: 'Ticaret Hukuku',
    kind: 'Sık Karıştırılan',
    title: 'Tacir ve esnaf aynı değildir',
    body: 'Bir ticari işletmeyi kısmen dahi olsa kendi adına işleten kişi tacirdir. Esnaf faaliyetinde ise ekonomik faaliyet sermayeden çok bedenî çalışmaya dayanır ve gelir esnaf sınırını aşmaz.',
    trap: 'Her işletme işleten kişi otomatik olarak esnaf değildir; ticari işletme ölçütü tacir sıfatını belirler.',
    sourceRef: 'TTK m.12 ve m.15',
  ),
  SmartNote(
    id: 'SN-007',
    subject: 'Ticaret Hukuku',
    kind: 'Süre / Sayı',
    title: 'Faturaya itiraz: 8 gün',
    body: 'Bir fatura alan kişi, aldığı tarihten itibaren sekiz gün içinde faturanın içeriğine itiraz etmezse içeriğini kabul etmiş sayılır.',
    trap: 'Bu süreyi 7 günlük İİK şikâyet süresiyle karıştırma.',
    sourceRef: 'TTK m.21/2',
  ),
  SmartNote(
    id: 'SN-008',
    subject: 'Hukuk Yargılama Usulü',
    kind: 'Mutlaka Bil',
    title: 'Dava şartlarını mahkeme kendiliğinden inceler',
    body: 'Mahkeme dava şartlarının mevcut olup olmadığını davanın her aşamasında kendiliğinden araştırır. Taraflar da dava şartı noksanlığını her zaman ileri sürebilir.',
    trap: 'Dava şartları yalnız davalının itirazına bağlı değildir.',
    sourceRef: 'HMK m.115',
  ),
  SmartNote(
    id: 'SN-009',
    subject: 'Hukuk Yargılama Usulü',
    kind: 'Sık Karıştırılan',
    title: 'Görev ve yetki aynı şey değildir',
    body: 'Görev, uyuşmazlığa hangi tür mahkemenin bakacağını; yetki ise hangi yerdeki mahkemenin bakacağını belirler.',
    trap: 'Görev kuralları kamu düzenindendir. Yetkide ise kesin yetki olan ve olmayan hâller ayrılır.',
    sourceRef: 'HMK m.1, m.5 vd.',
  ),
  SmartNote(
    id: 'SN-010',
    subject: 'İcra ve İflas',
    kind: 'Süre / Sayı',
    title: 'Şikâyet süresi kural olarak 7 gün',
    body: 'İcra ve iflas dairelerinin kanuna aykırı veya olaya uygun olmayan işlemlerine karşı şikâyet kural olarak işlemin öğrenilmesinden itibaren yedi gündür.',
    trap: 'Kanunda süresiz şikâyet öngörülen hâller ayrıca vardır; 7 gün her olay için mutlak değildir.',
    sourceRef: 'İİK m.16',
  ),
  SmartNote(
    id: 'SN-011',
    subject: 'İcra ve İflas',
    kind: 'Sık Karıştırılan',
    title: 'Ödeme emri ve icra emri',
    body: 'Genel haciz yoluyla ilamsız takipte borçluya ödeme emri gönderilir. Para veya teminat verilmesine ilişkin ilamların icrasında ise icra emri söz konusudur.',
    trap: 'İlamlı icrada “ödeme emri” demek sık yapılan hatadır.',
    sourceRef: 'İİK m.32, m.60',
  ),
  SmartNote(
    id: 'SN-012',
    subject: 'İş Hukuku',
    kind: 'Süre / Sayı',
    title: 'İhbar süreleri: 2-4-6-8 hafta',
    body: 'Belirsiz süreli sözleşmelerde kıdeme göre bildirim süreleri sırasıyla 2, 4, 6 ve 8 haftadır. Süreler asgaridir ve sözleşmeyle artırılabilir.',
    trap: 'Üç yıldan fazla kıdemde süre 8 haftadır. Bu süreleri yıllık izin süreleriyle karıştırma.',
    sourceRef: 'İşK m.17',
  ),
  SmartNote(
    id: 'SN-013',
    subject: 'İş Hukuku',
    kind: 'Süre / Sayı',
    title: 'Fazla çalışma eşiği ve zam oranı',
    body: 'Kural olarak haftalık 45 saati aşan çalışma fazla çalışmadır. Her bir fazla çalışma saatinin ücreti normal saat ücretinin %50 yükseltilmesiyle ödenir.',
    trap: '45 saat eşik, %50 ise ücret artış oranıdır.',
    sourceRef: 'İşK m.41',
  ),
  SmartNote(
    id: 'SN-014',
    subject: 'İş Hukuku',
    kind: 'Süre / Sayı',
    title: 'İş güvencesinde 30 işçi + 6 ay',
    body: 'Genel kural olarak 30 veya daha fazla işçi çalıştırılan işyerinde en az 6 aylık kıdeme sahip belirsiz süreli iş sözleşmesiyle çalışan işçi iş güvencesi kapsamındadır.',
    trap: 'Yer altı işçilerinde 6 aylık kıdem şartı aranmaz.',
    sourceRef: 'İşK m.18',
  ),
  SmartNote(
    id: 'SN-015',
    subject: 'Sosyal Güvenlik',
    kind: 'Sık Karıştırılan',
    title: 'İş kazası sadece işyerinde olmaz',
    body: 'İş kazası, yalnız işyeri binasında gerçekleşen olay değildir. İşveren tarafından yürütülen iş nedeniyle veya işverence sağlanan taşıtla işe gidiş geliş gibi kanunda sayılan hâller de kapsama girebilir.',
    trap: '“İşyeri dışında oldu, iş kazası değildir” genellemesi yanlıştır.',
    sourceRef: '5510 m.13',
  ),
  SmartNote(
    id: 'SN-016',
    subject: 'Vergi Usul Hukuku',
    kind: 'Sık Karıştırılan',
    title: 'Tarh, tahakkuk ve tahsil',
    body: 'Tarh verginin hesaplanıp miktar olarak tespitidir. Tahakkuk, tarh ve tebliğ edilen verginin ödenmesi gereken aşamaya gelmesidir. Tahsil ise ödemenin gerçekleşmesidir.',
    trap: 'Tarh ile tahakkuk aynı aşama değildir.',
    sourceRef: 'VUK m.20-23',
  ),
  SmartNote(
    id: 'SN-017',
    subject: 'Avukatlık Hukuku',
    kind: 'Mutlaka Bil',
    title: 'Avukatlık: kamu hizmeti + serbest meslek',
    body: 'Avukatlık hem kamu hizmeti hem serbest bir meslektir. Avukat yargının kurucu unsurlarından bağımsız savunmayı serbestçe temsil eder.',
    trap: 'Avukatı memur veya yalnız özel meslek mensubu olarak nitelendirmek eksiktir.',
    sourceRef: 'Avukatlık K. m.1',
  ),
  SmartNote(
    id: 'SN-018',
    subject: 'Avukatlık Hukuku',
    kind: 'İstisna',
    title: 'Müvekkil izin verse de avukat tanıklıktan çekinebilir',
    body: 'İş sahibinin muvafakati mesleki sır hakkında tanıklığı mümkün kılar. Buna rağmen avukat tanıklıktan çekinebilir.',
    trap: 'Müvekkilin muvafakati avukatı mutlaka tanıklık etmeye zorlamaz.',
    sourceRef: 'Avukatlık K. m.36',
  ),
  SmartNote(
    id: 'SN-019',
    subject: 'Medeni Hukuk',
    kind: 'Süre / Sayı',
    title: 'Erginlik kural olarak 18 yaş',
    body: 'Erginlik on sekiz yaşın doldurulmasıyla başlar. Evlenme kişiyi ergin kılar; ayrıca kanundaki şartlarla mahkemece ergin kılınma mümkündür.',
    trap: '18 yaş genel kuraldır; evlenme ve kazai rüşt istisnalarını unutma.',
    sourceRef: 'TMK m.11-12',
  ),
  SmartNote(
    id: 'SN-020',
    subject: 'Borçlar Hukuku',
    kind: 'Mutlaka Bil',
    title: 'Sözleşme nasıl kurulur?',
    body: 'Sözleşme, tarafların iradelerini karşılıklı ve birbirine uygun olarak açıklamalarıyla kurulur. Açıklama açık veya örtülü olabilir.',
    trap: 'Her sözleşmenin yazılı veya noterlikçe yapılması gerektiğini düşünme; şekil şartı istisnadır ve kanundan doğar.',
    sourceRef: 'TBK m.1 ve m.12',
  ),
];

class SmartNotesScreen extends StatefulWidget {
  const SmartNotesScreen({super.key});

  @override
  State<SmartNotesScreen> createState() => _SmartNotesScreenState();
}

class _SmartNotesScreenState extends State<SmartNotesScreen> {
  int index = 0;
  String filter = 'Tümü';
  Set<String> learned = <String>{};
  Set<String> repeat = <String>{};

  List<SmartNote> get visible {
    if (filter == 'Tümü') return smartNotes;
    if (filter == 'Tekrar') {
      final result = smartNotes.where((n) => repeat.contains(n.id)).toList();
      return result.isEmpty ? smartNotes : result;
    }
    return smartNotes.where((n) => n.kind == filter).toList();
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
    final note = list[index.clamp(0, list.length - 1)];
    final learnedCount = learned.length;
    return Scaffold(
      backgroundColor: _navy,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF071E3B), _navy, Color(0xFF030A14)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.chevron_left_rounded),
                    ),
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
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: _MiniStat(label: 'KART', value: '${index + 1}/${list.length}')),
                    const SizedBox(width: 6),
                    Expanded(child: _MiniStat(label: 'BİLDİM', value: '$learnedCount/20')),
                    const SizedBox(width: 6),
                    Expanded(child: _MiniStat(label: 'TEKRAR', value: '${repeat.length}')),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF10345A), _panel, Color(0xFF07182C)],
                      ),
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
                              decoration: BoxDecoration(
                                color: _kindColor(note.kind).withOpacity(.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: _kindColor(note.kind).withOpacity(.45)),
                              ),
                              child: Text(note.kind.toUpperCase(), style: TextStyle(color: _kindColor(note.kind), fontSize: 8, letterSpacing: 1, fontWeight: FontWeight.w900)),
                            ),
                            const Spacer(),
                            Flexible(child: Text(note.subject, textAlign: TextAlign.right, style: const TextStyle(color: Color(0xFF9DB5CA), fontSize: 9, fontWeight: FontWeight.w700))),
                          ],
                        ),
                        const SizedBox(height: 13),
                        Text(note.title, style: const TextStyle(color: _gold2, fontSize: 21, height: 1.05, fontFamily: 'serif', fontWeight: FontWeight.w900)),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Center(
                            child: Text(
                              note.body,
                              style: const TextStyle(fontSize: 15, height: 1.45, color: Color(0xFFF3F5F7), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: const Color(0xFF081725),
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(color: const Color(0x44FF9B73)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.warning_amber_rounded, size: 19, color: Color(0xFFFFA276)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(note.trap, style: const TextStyle(fontSize: 11, height: 1.35, color: Color(0xFFD9E2EA)))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            const Icon(Icons.verified_rounded, size: 15, color: _blue),
                            const SizedBox(width: 5),
                            Expanded(child: Text('Kaynak: ${note.sourceRef}', style: const TextStyle(color: _blue, fontSize: 10, fontWeight: FontWeight.w800))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(width: 44, height: 43, child: OutlinedButton(onPressed: _previous, child: const Icon(Icons.chevron_left_rounded))),
                    const SizedBox(width: 6),
                    Expanded(
                      child: SizedBox(
                        height: 43,
                        child: OutlinedButton.icon(
                          onPressed: () => _markRepeat(note),
                          icon: const Icon(Icons.replay_rounded, size: 18),
                          label: const Text('Tekrar Göster', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: SizedBox(
                        height: 43,
                        child: FilledButton.icon(
                          onPressed: () => _markLearned(note),
                          icon: const Icon(Icons.check_rounded, size: 18),
                          label: const Text('Bildim', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(width: 44, height: 43, child: OutlinedButton(onPressed: _next, child: const Icon(Icons.chevron_right_rounded))),
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
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xCC081B2F),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0x3348B7FF)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 7, color: Color(0xFF8DA5BC), letterSpacing: .8)),
          const SizedBox(height: 1),
          Text(value, style: const TextStyle(fontSize: 11, color: _gold2, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
