import 'package:flutter/material.dart';

const _navy = Color(0xFF020914);
const _panel = Color(0xFF0A2038);
const _blue = Color(0xFF48B7FF);
const _gold = Color(0xFFE5BF72);
const _gold2 = Color(0xFFFFD98A);

class SmartNote {
  const SmartNote({required this.id, required this.subject, required this.title, required this.fact, required this.trap, required this.memory, required this.sourceRef, required this.tags});
  final String id;
  final String subject;
  final String title;
  final String fact;
  final String trap;
  final String memory;
  final String sourceRef;
  final Set<String> tags;
}

const smartNotes = <SmartNote>[
  SmartNote(id:'SN-001',subject:'Anayasa Hukuku',title:'Egemenlik kime ait',fact:'Egemenlik kayıtsız şartsız Milletindir.',trap:'TBMM egemenliğin sahibi değil, Anayasanın koyduğu esaslara göre egemenliği kullanan organlardan biridir.',memory:'Sahip Millet, kullanım anayasal organlar.',sourceRef:'Anayasa m.6',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-002',subject:'Vergi Hukuku',title:'Verginin kanuniliği',fact:'Vergi, resim, harç ve benzeri mali yükümlülükler kanunla konulur, değiştirilir veya kaldırılır.',trap:'Cumhurbaşkanı yeni bir vergiyi tek başına ihdas edemez; yalnız kanunun çizdiği sınırlar içindeki bazı oran, muaflık, istisna ve indirimlerde yetkilendirilebilir.',memory:'Verginin temeli kanun, hareket alanı sınırlandırılmış yetki.',sourceRef:'Anayasa m.73',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-003',subject:'Anayasa Hukuku',title:'Kanun önünde eşitlik',fact:'Devlet organları ve idare makamları bütün işlemlerinde kanun önünde eşitlik ilkesine uygun hareket etmek zorundadır.',trap:'Eşitlik her durumda herkese aynı işlem yapılması demek değildir; hukuken farklı durumda olanlar için farklı düzenleme mümkün olabilir.',memory:'Aynı durumda aynı, farklı durumda ölçülü farklılık.',sourceRef:'Anayasa m.10',tags:{'kritik'}),
  SmartNote(id:'SN-004',subject:'Ceza Hukuku',title:'Olası kast ve bilinçli taksir',fact:'Olası kastta fail neticenin gerçekleşebileceğini öngörür ve fiili işler; bilinçli taksirde neticeyi öngörür fakat istemez.',trap:'İkisinde de netice öngörülür. Ayrım, neticeye yönelik iradenin niteliğindedir.',memory:'Olası kast: olursa olsun. Bilinçli taksir: olmaz sanıyordum.',sourceRef:'TCK m.21/2 ve m.22/3',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-005',subject:'Ceza Hukuku',title:'Kanunilik ve kıyas',fact:'Suç ve ceza içeren hükümler bakımından kıyas yapılamaz ve kıyasa yol açacak şekilde geniş yorum yapılamaz.',trap:'Yeni bir suç veya ceza kuralı kıyasla üretilemez.',memory:'Ceza hukukunda suç yaratmak için kıyas yok.',sourceRef:'TCK m.2',tags:{'kritik'}),
  SmartNote(id:'SN-006',subject:'Ceza Hukuku',title:'Tüzel kişinin ceza sorumluluğu',fact:'Tüzel kişiler hakkında ceza yaptırımı uygulanmaz; kanunda öngörülen güvenlik tedbirleri saklıdır.',trap:'Şirket adına suç işlenmesi şirketin hapis veya adli para cezasıyla cezalandırılması anlamına gelmez.',memory:'Tüzel kişiye ceza değil, kanuni güvenlik tedbiri.',sourceRef:'TCK m.20/2',tags:{'karistirilan'}),
  SmartNote(id:'SN-007',subject:'Ceza Hukuku',title:'Teşebbüste başlangıç noktası',fact:'Teşebbüs için failin elverişli hareketlerle doğrudan doğruya icraya başlaması ve suçu elinde olmayan nedenlerle tamamlayamaması gerekir.',trap:'Hazırlık hareketi tek başına teşebbüs değildir.',memory:'Hazırlık değil, doğrudan icra.',sourceRef:'TCK m.35',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-008',subject:'Ceza Muhakemesi',title:'Şüpheli ve sanık ayrımı',fact:'Soruşturma evresindeki kişi şüpheli, kovuşturma evresindeki kişi sanıktır.',trap:'İddianamenin düzenlenmesi sanık sıfatını başlatmaz. Kovuşturma iddianamenin kabulüyle başlar.',memory:'Kabulden önce şüpheli, kabulden sonra sanık.',sourceRef:'CMK m.2',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-009',subject:'Ceza Muhakemesi',title:'Soruşturma nerede biter',fact:'Soruşturma, suç şüphesinin öğrenilmesinden iddianamenin kabulüne kadar sürer.',trap:'Savcının iddianameyi yazması soruşturmayı tek başına bitirmez.',memory:'Sınır çizgisi: iddianamenin kabulü.',sourceRef:'CMK m.2/1-e-f',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-010',subject:'Ceza Muhakemesi',title:'Susma hakkı',fact:'Şüpheli veya sanığa, yüklenen suç hakkında açıklamada bulunmamasının kanuni hakkı olduğu bildirilir.',trap:'Susmak suçun kabulü sayılmaz.',memory:'Savunma hakkı konuşmayı da susmayı da kapsar.',sourceRef:'CMK m.147/1-e',tags:{'kritik'}),
  SmartNote(id:'SN-011',subject:'Ceza Muhakemesi',title:'Eski eş tanıklıktan çekinebilir',fact:'Evlilik bağı sona ermiş olsa bile şüpheli veya sanığın eşi tanıklıktan çekinebilir.',trap:'Boşanma bu çekinme hakkını ortadan kaldırmaz.',memory:'Evlilik biter, çekinme hakkı kalır.',sourceRef:'CMK m.45/1-b',tags:{'karistirilan'}),
  SmartNote(id:'SN-012',subject:'Ticaret Hukuku',title:'Tacir ve esnaf',fact:'Ticari işletmeyi kısmen dahi olsa kendi adına işleten kişi tacirdir. Esnaf faaliyetinde bedenî çalışma sermayeye göre daha ağırlıklıdır ve gelir esnaf sınırını aşmaz.',trap:'Her işletme sahibi otomatik olarak tacir değildir; ticari işletme ölçütü önemlidir.',memory:'Ticari işletme → tacir. Esnaf sınırı → esnaf.',sourceRef:'TTK m.12 ve m.15',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-013',subject:'Ticaret Hukuku',title:'Fiilen başlamadan tacir sayılma',fact:'Ticari işletmesini ticaret siciline tescil ettirip ilan eden veya işletmesini açtığını halka bildiren kişi fiilen işletmeye başlamasa da tacir sayılır.',trap:'Tacir sıfatı her durumda ilk satış veya ilk fatura anında başlamaz.',memory:'İlan ve tescil tacir sıfatını öne çekebilir.',sourceRef:'TTK m.12/2',tags:{'karistirilan'}),
  SmartNote(id:'SN-014',subject:'Ticaret Hukuku',title:'Faturaya itiraz süresi',fact:'Faturayı alan kişi, içeriğine sekiz gün içinde itiraz etmezse faturanın içeriğini kabul etmiş sayılır.',trap:'Sekiz günlük süre faturanın her durumda borcu kesinleştirmesi anlamına gelmez; kanuni karine bakımından önemlidir.',memory:'Fatura = 8 gün.',sourceRef:'TTK m.21/2',tags:{'sure','kritik'}),
  SmartNote(id:'SN-015',subject:'Ticaret Hukuku',title:'Bileşik faiz istisnası',fact:'Bileşik faiz kural olarak serbest değildir; cari hesaplarda ve her iki taraf bakımından ticari iş niteliğindeki ödünç sözleşmelerinde, üç aydan kısa olmayan dönemlerle kararlaştırılabilir.',trap:'Her ticari işte bileşik faiz uygulanmaz.',memory:'Cari hesap veya iki taraf için ticari ödünç + en az 3 ay.',sourceRef:'TTK m.8/2',tags:{'kritik','sure','karistirilan'}),
  SmartNote(id:'SN-016',subject:'Hukuk Muhakemeleri',title:'Görev ve yetki aynı şey değil',fact:'Görev, davaya hangi tür mahkemenin; yetki ise coğrafi olarak hangi yerdeki mahkemenin bakacağını belirler.',trap:'Görev kural olarak kamu düzenindendir. Yetki yalnız kesin yetki hâllerinde kamu düzeni niteliği taşır.',memory:'Görev = mahkeme türü. Yetki = yer.',sourceRef:'HMK m.1 ve m.5 vd.',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-017',subject:'Hukuk Muhakemeleri',title:'Dava şartları kendiliğinden incelenir',fact:'Mahkeme dava şartlarının mevcut olup olmadığını davanın her aşamasında kendiliğinden araştırır.',trap:'Dava şartlarının incelenmesi için mutlaka davalının itiraz etmesi gerekmez.',memory:'Dava şartı = re’sen kontrol.',sourceRef:'HMK m.115',tags:{'kritik'}),
  SmartNote(id:'SN-018',subject:'Hukuk Muhakemeleri',title:'İlk itirazları kaçırma',fact:'İlk itirazlar cevap dilekçesinde ileri sürülmelidir; aksi hâlde dinlenmez.',trap:'İlk itiraz ile dava şartı aynı şey değildir.',memory:'İlk itiraz = cevap dilekçesi.',sourceRef:'HMK m.117',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-019',subject:'Hukuk Muhakemeleri',title:'Cevap süresi',fact:'Cevap dilekçesini verme süresi dava dilekçesinin davalıya tebliğinden itibaren iki haftadır.',trap:'Mahkeme koşulları varsa bir defaya mahsus ek süre verebilir; asıl süre iki haftadır.',memory:'Cevap = 2 hafta.',sourceRef:'HMK m.127',tags:{'sure','kritik'}),
  SmartNote(id:'SN-020',subject:'İcra ve İflas',title:'Şikâyet süresi',fact:'İcra ve iflas dairesinin kanuna aykırı veya hadiseye uygun olmayan işlemine karşı genel şikâyet süresi öğrenmeden itibaren yedi gündür.',trap:'Bir hakkın yerine getirilmemesi veya işin sebepsiz sürüncemede bırakılması hâllerinde şikâyet süreye bağlı değildir.',memory:'Genel şikâyet 7 gün, yapmama-sürünceme süresiz.',sourceRef:'İİK m.16',tags:{'sure','kritik','karistirilan'}),
  SmartNote(id:'SN-021',subject:'İcra ve İflas',title:'Ödeme emrine itiraz',fact:'Genel haciz yoluyla ilamsız takipte borçlu ödeme emrine tebliğden itibaren yedi gün içinde itiraz eder.',trap:'İtiraz doğrudan borcu ortadan kaldırmaz; süresinde yapılan itiraz takibi durdurur.',memory:'Ödeme emri itirazı = 7 gün.',sourceRef:'İİK m.62 ve m.66',tags:{'sure','kritik'}),
  SmartNote(id:'SN-022',subject:'İcra ve İflas',title:'İtirazın iptali davası',fact:'Alacaklı, itirazın tebliğinden itibaren bir yıl içinde itirazın iptali davası açabilir.',trap:'Yedi günlük borçlunun itiraz süresi ile alacaklının bir yıllık dava süresini karıştırma.',memory:'Borçlu 7 gün, alacaklı iptal davası 1 yıl.',sourceRef:'İİK m.67',tags:{'sure','karistirilan'}),
  SmartNote(id:'SN-023',subject:'İcra ve İflas',title:'Haciz isteme süresi',fact:'Haciz isteme hakkı kural olarak ödeme emrinin tebliğinden itibaren bir yıl geçmekle düşer.',trap:'Bu süre satış isteme süresiyle veya zamanaşımıyla aynı kavram değildir.',memory:'Haciz isteme = 1 yıl.',sourceRef:'İİK m.78',tags:{'sure'}),
  SmartNote(id:'SN-024',subject:'Medeni Hukuk',title:'Erginlik yaşı',fact:'Erginlik on sekiz yaşın doldurulmasıyla başlar.',trap:'Evlenme kişiyi ergin kılar; yaş kuralı ile evlenmeyle erginliği karıştırma.',memory:'Kural 18.',sourceRef:'TMK m.11',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-025',subject:'Medeni Hukuk',title:'Kişiliğin başlangıcı',fact:'Kişilik, çocuğun sağ ve tamamıyla doğduğu anda başlar; çocuk hak ehliyetini sağ doğmak koşuluyla ana rahmine düştüğü andan başlayarak elde eder.',trap:'Hak ehliyetinin geriye etkili kazanımı ile kişiliğin başlangıç anı aynı değildir.',memory:'Kişilik doğumda, hak ehliyeti sağ doğum şartıyla ana rahminden.',sourceRef:'TMK m.28',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-026',subject:'Borçlar Hukuku',title:'Sözleşmenin kurulması',fact:'Sözleşme, tarafların iradelerini karşılıklı ve birbirine uygun olarak açıklamalarıyla kurulur.',trap:'Kanun özel bir şekil aramadıkça sözleşmenin mutlaka yazılı yapılması gerekmez.',memory:'Karşılıklı + uygun irade.',sourceRef:'TBK m.1',tags:{'kritik'}),
  SmartNote(id:'SN-027',subject:'Borçlar Hukuku',title:'Haksız fiilde zamanaşımı',fact:'Tazminat istemi, zararı ve tazminat yükümlüsünü öğrenmeden itibaren iki yıl ve her hâlde fiilden itibaren on yıl içinde zamanaşımına uğrar.',trap:'İki yıllık nispi süre ile on yıllık mutlak süreyi karıştırma; ceza kanununda daha uzun süre varsa özel kural ayrıca uygulanabilir.',memory:'Haksız fiil: 2 / 10.',sourceRef:'TBK m.72',tags:{'sure','kritik','karistirilan'}),
  SmartNote(id:'SN-028',subject:'İş Hukuku',title:'İş sözleşmesinin üç çekirdeği',fact:'İş sözleşmesinin ayırt edici unsurları iş görme, ücret ve bağımlılıktır.',trap:'Vekâlet veya eser sözleşmesinden ayrımda özellikle bağımlılık unsuru önemlidir.',memory:'İş + ücret + bağımlılık.',sourceRef:'İş Kanunu m.8 ve genel iş hukuku ilkeleri',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-029',subject:'Vergi Usul Hukuku',title:'Tarh, tahakkuk, tahsil',fact:'Tarh verginin hesaplanıp miktar olarak tespitidir; tahakkuk verginin ödenmesi gereken safhaya gelmesidir; tahsil ise verginin kanuna uygun şekilde ödenmesidir.',trap:'Bu üç kavram aynı işlem değildir ve sıraları sık karıştırılır.',memory:'Tarh = hesapla, tahakkuk = ödenecek hâle getir, tahsil = öde.',sourceRef:'VUK m.20, m.22, m.23',tags:{'kritik','karistirilan'}),
  SmartNote(id:'SN-030',subject:'İdari Yargılama',title:'Genel dava açma süreleri',fact:'Özel kanunda ayrı süre yoksa Danıştay ve idare mahkemelerinde genel dava açma süresi 60 gün, vergi mahkemelerinde 30 gündür.',trap:'İdari yargıda bütün davalar için tek bir 60 günlük süre yoktur.',memory:'İdare 60, vergi 30.',sourceRef:'İYUK m.7',tags:{'sure','kritik','karistirilan'}),
];

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});
  @override
  Widget build(BuildContext context) {
    final today = smartNotes[DateTime.now().day % smartNotes.length];
    return Padding(
      padding: const EdgeInsets.fromLTRB(12,10,12,8),
      child: Column(children:[
        const Row(children:[Icon(Icons.auto_awesome_rounded,color:_gold2,size:22),SizedBox(width:7),Expanded(child:Text('ÇALIŞMA MERKEZİ',style:TextStyle(fontFamily:'serif',fontSize:22,color:_gold2,fontWeight:FontWeight.w900)))]),
        const SizedBox(height:10),
        Expanded(flex:5,child:Material(color:_panel,borderRadius:BorderRadius.circular(18),child:InkWell(borderRadius:BorderRadius.circular(18),onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const SmartNotesScreen())),child:Container(width:double.infinity,padding:const EdgeInsets.all(16),decoration:BoxDecoration(borderRadius:BorderRadius.circular(18),border:Border.all(color:_gold.withOpacity(.65)),gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF11365C),Color(0xFF07192D)])),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Row(children:[Icon(Icons.psychology_alt_rounded,color:_blue),SizedBox(width:7),Text('AKILLI NOTLAR',style:TextStyle(color:_gold2,letterSpacing:1.3,fontWeight:FontWeight.w900))]),const SizedBox(height:10),Text(today.subject,style:const TextStyle(color:_blue,fontSize:11,fontWeight:FontWeight.w800)),const SizedBox(height:4),Text(today.title,style:const TextStyle(fontFamily:'serif',fontSize:20,fontWeight:FontWeight.w900)),const SizedBox(height:8),Expanded(child:Text(today.fact,maxLines:5,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Color(0xFFD5E1EC),height:1.35))),const SizedBox(height:8),Row(children:[const Icon(Icons.touch_app_rounded,size:17,color:_gold),const SizedBox(width:5),Text('${smartNotes.length} akıllı notu aç',style:const TextStyle(color:_gold2,fontWeight:FontWeight.w800,fontSize:11))])]))))),
        const SizedBox(height:9),
        Expanded(flex:2,child:Row(children:[Expanded(child:_StudyMini(icon:Icons.warning_amber_rounded,title:'Karıştırılanlar',subtitle:'Tuzak ayrımlar',onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const SmartNotesScreen(initialFilter:'karistirilan'))))),const SizedBox(width:8),Expanded(child:_StudyMini(icon:Icons.schedule_rounded,title:'Süre ve Rakam',subtitle:'7 gün · 1 yıl · 2 hafta',onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>const SmartNotesScreen(initialFilter:'sure')))))])),
        const SizedBox(height:9),
        const SizedBox(height:42,width:double.infinity,child:OutlinedButton(onPressed:null,child:Text('Zayıf konuya göre akıllı not önerileri · sonraki sürüm'))),
      ]),
    );
  }
}

class _StudyMini extends StatelessWidget {
  const _StudyMini({required this.icon,required this.title,required this.subtitle,required this.onTap});
  final IconData icon; final String title; final String subtitle; final VoidCallback onTap;
  @override Widget build(BuildContext context)=>Material(color:const Color(0xFF081B2F),borderRadius:BorderRadius.circular(14),child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(14),child:Padding(padding:const EdgeInsets.all(10),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(icon,color:_gold,size:24),const SizedBox(height:5),FittedBox(child:Text(title,style:const TextStyle(fontWeight:FontWeight.w900))),const SizedBox(height:2),FittedBox(child:Text(subtitle,style:const TextStyle(color:Color(0xFF91A4B8),fontSize:9)))]))));
}

class SmartNotesScreen extends StatefulWidget {
  const SmartNotesScreen({super.key,this.initialFilter='all'}); final String initialFilter;
  @override State<SmartNotesScreen> createState()=>_SmartNotesScreenState();
}

class _SmartNotesScreenState extends State<SmartNotesScreen> {
  late String filter; int index=0; final learned=<String>{};
  @override void initState(){super.initState();filter=widget.initialFilter;}
  List<SmartNote> get visible=>filter=='all'?smartNotes:smartNotes.where((n)=>n.tags.contains(filter)).toList();
  void _setFilter(String value)=>setState((){filter=value;index=0;});
  @override Widget build(BuildContext context){
    final notes=visible; final note=notes[index.clamp(0,notes.length-1)]; final isLearned=learned.contains(note.id);
    return Scaffold(backgroundColor:_navy,body:SafeArea(child:Container(decoration:const BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Color(0xFF071E39),_navy])),child:Padding(padding:const EdgeInsets.fromLTRB(10,6,10,10),child:Column(children:[
      Row(children:[IconButton(onPressed:()=>Navigator.pop(context),icon:const Icon(Icons.chevron_left_rounded)),const Expanded(child:Column(children:[Text('AKILLI NOTLAR',style:TextStyle(color:_gold2,fontFamily:'serif',fontSize:20,fontWeight:FontWeight.w900)),Text('Sınavda en çok karıştırılan çekirdek bilgiler',style:TextStyle(fontSize:9,color:Color(0xFF90A8BF)))])),SizedBox(width:48,child:Center(child:Text('${index+1}/${notes.length}',style:const TextStyle(color:_gold,fontWeight:FontWeight.w900,fontSize:11))))]),
      const SizedBox(height:5),
      SizedBox(height:34,child:ListView(scrollDirection:Axis.horizontal,children:[_Filter(label:'Tümü',selected:filter=='all',onTap:()=>_setFilter('all')),_Filter(label:'Kritik',selected:filter=='kritik',onTap:()=>_setFilter('kritik')),_Filter(label:'Karıştırılan',selected:filter=='karistirilan',onTap:()=>_setFilter('karistirilan')),_Filter(label:'Süre · Rakam',selected:filter=='sure',onTap:()=>_setFilter('sure'))])),
      const SizedBox(height:8),
      Expanded(child:Container(width:double.infinity,padding:const EdgeInsets.all(15),decoration:BoxDecoration(borderRadius:BorderRadius.circular(18),border:Border.all(color:isLearned?const Color(0xFF58D68D):_gold.withOpacity(.55)),color:_panel,boxShadow:[BoxShadow(color:_blue.withOpacity(.08),blurRadius:18)]),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[Expanded(child:Text(note.subject.toUpperCase(),style:const TextStyle(color:_blue,fontSize:10,letterSpacing:1.1,fontWeight:FontWeight.w900))),Container(padding:const EdgeInsets.symmetric(horizontal:8,vertical:4),decoration:BoxDecoration(color:_gold.withOpacity(.12),borderRadius:BorderRadius.circular(20)),child:Text(note.sourceRef,style:const TextStyle(color:_gold2,fontSize:9,fontWeight:FontWeight.w800)))]),
        const SizedBox(height:8),Text(note.title,style:const TextStyle(fontFamily:'serif',fontSize:23,fontWeight:FontWeight.w900)),const SizedBox(height:12),
        _InfoBox(icon:Icons.check_circle_outline_rounded,label:'BİLMEN GEREKEN',text:note.fact,accent:const Color(0xFF78E4AA)),const SizedBox(height:9),
        _InfoBox(icon:Icons.warning_amber_rounded,label:'KARIŞTIRMA',text:note.trap,accent:const Color(0xFFFFC26B)),const SizedBox(height:9),
        _InfoBox(icon:Icons.bolt_rounded,label:'HAFIZA KANCASI',text:note.memory,accent:_blue),const Spacer(),
        SizedBox(height:39,width:double.infinity,child:OutlinedButton.icon(onPressed:()=>setState(()=>isLearned?learned.remove(note.id):learned.add(note.id)),icon:Icon(isLearned?Icons.check_circle_rounded:Icons.bookmark_add_outlined,size:18),label:Text(isLearned?'Bunu biliyorum':'Öğrendim olarak işaretle')))
      ]))),
      const SizedBox(height:8),Row(children:[Expanded(child:OutlinedButton(onPressed:index>0?()=>setState(()=>index--):null,child:const Text('Önceki'))),const SizedBox(width:8),Expanded(child:FilledButton(onPressed:index<notes.length-1?()=>setState(()=>index++):null,child:const Text('Sonraki')))])
    ])))));
  }
}

class _Filter extends StatelessWidget {
  const _Filter({required this.label,required this.selected,required this.onTap}); final String label; final bool selected; final VoidCallback onTap;
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.only(right:6),child:ChoiceChip(label:Text(label,style:const TextStyle(fontSize:10)),selected:selected,onSelected:(_)=>onTap(),selectedColor:_gold.withOpacity(.25),side:BorderSide(color:selected?_gold:const Color(0x3348B7FF))));
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.icon,required this.label,required this.text,required this.accent}); final IconData icon; final String label; final String text; final Color accent;
  @override Widget build(BuildContext context)=>Container(width:double.infinity,padding:const EdgeInsets.all(10),decoration:BoxDecoration(color:const Color(0xFF07192D),borderRadius:BorderRadius.circular(12),border:Border.all(color:accent.withOpacity(.24))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Icon(icon,color:accent,size:16),const SizedBox(width:5),Text(label,style:TextStyle(color:accent,fontSize:9,letterSpacing:1,fontWeight:FontWeight.w900))]),const SizedBox(height:5),Text(text,maxLines:5,overflow:TextOverflow.ellipsis,style:const TextStyle(color:Color(0xFFD4DFEA),fontSize:12.2,height:1.32))]));
}
