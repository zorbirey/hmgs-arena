package com.hmgsarena.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

private val V3Black = Color(0xFF050607)
private val V3Panel = Color(0xFF101418)
private val V3Panel2 = Color(0xFF171B20)
private val V3Red = Color(0xFFE52B2F)
private val V3RedDark = Color(0xFF7A1115)
private val V3Gold = Color(0xFFF3C766)
private val V3Text = Color(0xFFF6F3EE)
private val V3Muted = Color(0xFFB7BBC2)

private enum class V3Tab(val label: String, val icon: String) {
    HOME("Ana Sayfa", "⌂"),
    LESSONS("Dersler", "▤"),
    ARENA("ARENA", "⛨"),
    REPORTS("Raporlar", "▥"),
    PROFILE("Profil", "●")
}

private data class LessonSummary(
    val title: String,
    val short: String,
    val overview: String,
    val topics: List<String>
)

private val lessonSummaries = listOf(
    LessonSummary("Anayasa Hukuku", "Temel haklar, devlet yapısı, yasama-yürütme-yargı", "Anayasa Hukuku özeti; devletin temel niteliklerini, egemenliğin kullanılmasını, kuvvetler ayrılığını, temel hak ve özgürlüklerin rejimini, TBMM'nin görev ve yetkilerini, Cumhurbaşkanlığı sistemini, yargı bağımsızlığını ve anayasa yargısını birlikte ele alır.", listOf("Devletin temel nitelikleri", "Temel hak ve özgürlükler", "Yasama organı", "Yürütme", "Yargı", "Anayasa Mahkemesi", "Olağanüstü yönetim usulleri")),
    LessonSummary("İdare Hukuku", "İdari işlem, kamu hizmeti, kolluk, sorumluluk", "İdare Hukuku; idarenin kuruluşunu ve faaliyetlerini, idari işlemin unsurlarını ve sakatlıklarını, kamu hizmeti ve kolluk faaliyetlerini, kamu mallarını, kamu görevlilerini ve idarenin sorumluluğunu sistematik biçimde açıklar.", listOf("İdarenin bütünlüğü", "İdari işlem", "İdari sözleşmeler", "Kamu hizmeti", "Kolluk", "Kamu malları", "Kamu görevlileri", "İdarenin sorumluluğu")),
    LessonSummary("İdari Yargılama Hukuku", "İptal ve tam yargı davaları, süreler, kanun yolları", "İdari Yargılama özeti; görev ve yetki kurallarını, iptal ve tam yargı davalarını, dava açma sürelerini, yürütmenin durdurulmasını, ilk incelemeyi, karar türlerini ve kanun yollarını sınav odaklı bir sırayla toplar.", listOf("Görev ve yetki", "Dava türleri", "Süreler", "İlk inceleme", "Yürütmenin durdurulması", "Kararlar", "İstinaf ve temyiz")),
    LessonSummary("Medeni Hukuk", "Kişiler, aile, eşya ve miras hukuku", "Medeni Hukuk özeti; kişilik, yerleşim yeri, kişiliğin korunması, aile ilişkileri, ayni haklar, zilyetlik, tapu sicili ve miras hukukunun temel kurumlarını ana kavramlar ve tipik sınav ayrımları üzerinden ele alır.", listOf("Kişiler hukuku", "Aile hukuku", "Zilyetlik", "Mülkiyet", "Sınırlı ayni haklar", "Tapu sicili", "Mirasçılık", "Ölüme bağlı tasarruflar")),
    LessonSummary("Borçlar Hukuku", "Sözleşme, haksız fiil, sebepsiz zenginleşme", "Borçlar Hukuku özeti; borcun kaynaklarını, sözleşmenin kurulması ve geçerliliğini, irade bozukluklarını, temsil, ifa ve ifa engellerini, borcun sona ermesini ve özel borç ilişkilerinin temel mantığını bütüncül olarak açıklar.", listOf("Sözleşmenin kurulması", "Geçersizlik", "İrade bozuklukları", "Temsil", "İfa", "Temerrüt", "Haksız fiil", "Sebepsiz zenginleşme", "Borcun sona ermesi")),
    LessonSummary("Ticaret Hukuku", "Tacir, ticari işletme, şirketler, kıymetli evrak", "Ticaret Hukuku özeti; ticari işletme ve tacir kavramlarını, ticari iş hükümlerini, şirketlerin kuruluş ve organlarını, kıymetli evrakın temel ilkelerini ve ticari uyuşmazlıklarda sık sorulan ayrımları kapsar.", listOf("Ticari işletme", "Tacir", "Ticaret unvanı", "Haksız rekabet", "Şirketler hukuku", "Anonim şirket", "Limited şirket", "Kıymetli evrak")),
    LessonSummary("Ceza Hukuku", "Suç teorisi, kusurluluk, teşebbüs, iştirak", "Ceza Hukuku özeti; suçun maddi ve manevi unsurlarını, hukuka aykırılığı, kusurluluğu, hata hallerini, teşebbüs, iştirak, içtima ve yaptırım sistemini kavramsal bütünlük içinde inceler.", listOf("Suçun unsurları", "Kast ve taksir", "Hukuka uygunluk nedenleri", "Kusurluluk", "Hata", "Teşebbüs", "İştirak", "İçtima", "Yaptırımlar")),
    LessonSummary("Ceza Muhakemesi Hukuku", "Soruşturma, kovuşturma, koruma tedbirleri", "Ceza Muhakemesi özeti; soruşturma ve kovuşturmanın aktörlerini, delil rejimini, yakalama-gözaltı-tutuklama gibi koruma tedbirlerini, iddianameyi, duruşmayı, hüküm ve kanun yollarını sınav mantığıyla açıklar.", listOf("Muhakeme makamları", "Şüpheli ve sanık", "Müdafi", "Deliller", "Koruma tedbirleri", "İddianame", "Duruşma", "Hüküm", "Kanun yolları")),
    LessonSummary("Hukuk Muhakemeleri", "Dava şartları, ilk itirazlar, ispat ve kanun yolları", "Hukuk Muhakemeleri özeti; görev-yetki, dava şartları, ilk itirazlar, taraf ve dava arkadaşlığı, dava türleri, ispat, geçici hukuki korumalar, hüküm ve kanun yollarını sistematik biçimde toplar.", listOf("Görev ve yetki", "Dava şartları", "İlk itirazlar", "Taraflar", "Dava türleri", "İspat", "İhtiyati tedbir", "Hüküm", "İstinaf ve temyiz")),
    LessonSummary("İcra ve İflas Hukuku", "Takip yolları, haciz, satış, iflas", "İcra ve İflas özeti; ilamlı-ilamsız takip, ödeme emri, itiraz, haciz, satış, sıra cetveli, kambiyo senetlerine özgü takip, iflas ve konkordato başlıklarını birbirinden ayırarak anlatır.", listOf("İlamsız takip", "İlamlı takip", "İtiraz", "Haciz", "Satış", "Kambiyo takibi", "İflas", "Konkordato")),
    LessonSummary("İş ve Sosyal Güvenlik Hukuku", "İş sözleşmesi, fesih, çalışma süreleri, sosyal sigorta", "İş ve Sosyal Güvenlik özeti; işçi-işveren ilişkisini, iş sözleşmesini, ücret ve çalışma sürelerini, fesih rejimini, kıdem-ihbar sonuçlarını, iş güvencesini ve sosyal sigortaların temel yapısını kapsar.", listOf("İş sözleşmesi", "Ücret", "Çalışma ve dinlenme süreleri", "Fesih", "İş güvencesi", "Kıdem ve ihbar", "Toplu iş hukuku", "Sosyal sigortalar")),
    LessonSummary("Vergi Hukuku", "Vergilendirme, mükellefiyet, tarh, tebliğ, tahakkuk", "Vergi Hukuku özeti; vergilendirme yetkisini, vergi ödevini, mükellef ve sorumluyu, vergiyi doğuran olayı, tarh-tebliğ-tahakkuk-tahsil aşamalarını, vergi hatalarını ve uyuşmazlık yollarını düzenli bir akışla açıklar.", listOf("Verginin anayasal ilkeleri", "Mükellef ve sorumlu", "Vergiyi doğuran olay", "Tarh", "Tebliğ", "Tahakkuk", "Tahsil", "Vergi hataları", "Vergi uyuşmazlıkları")),
    LessonSummary("Milletlerarası Hukuk", "Kaynaklar, devletler, antlaşmalar, uyuşmazlıklar", "Milletlerarası Hukuk özeti; uluslararası hukukun kaynaklarını, devletin unsurlarını, tanıma ve halefiyet meselelerini, antlaşmalar hukukunu, devletin sorumluluğunu ve uyuşmazlıkların barışçıl çözüm yollarını temel çerçevede ele alır.", listOf("Kaynaklar", "Devlet", "Tanıma", "Antlaşmalar", "Yetki alanları", "Devlet sorumluluğu", "Uluslararası örgütler", "Uyuşmazlıkların çözümü")),
    LessonSummary("İnsan Hakları Hukuku", "Temel hak rejimi, AİHS, AİHM", "İnsan Hakları özeti; hakların sınıflandırılması, sınırlama rejimi, pozitif-negatif yükümlülükler, AİHS sistemi, AİHM'e başvuru koşulları ve temel hak başlıklarını sınavda ayırt edilecek kriterlerle açıklar.", listOf("Hakların sınıflandırılması", "Sınırlama rejimi", "AİHS sistemi", "AİHM başvurusu", "Yaşam hakkı", "Adil yargılanma", "Özel hayat", "İfade özgürlüğü")),
    LessonSummary("Hukuk Felsefesi ve Sosyolojisi", "Hukuk düşüncesi, adalet, pozitivizm, doğal hukuk", "Bu özet; doğal hukuk, hukuki pozitivizm, adalet teorileri, hukuk-toplum ilişkisi, norm ve meşruiyet tartışmaları ile başlıca hukuk düşüncesi yaklaşımlarını kavramsal karşılaştırmalarla ele alır.", listOf("Doğal hukuk", "Hukuki pozitivizm", "Adalet teorileri", "Norm kavramı", "Hukuk ve ahlak", "Hukuk ve toplum", "Meşruiyet"))
)

class ArenaV3Activity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent { ArenaV3App() }
    }
}

@Composable
private fun ArenaV3App() {
    var entered by rememberSaveable { mutableStateOf(false) }
    MaterialTheme(colorScheme = darkColorScheme(primary = V3Red, background = V3Black, surface = V3Panel, onSurface = V3Text)) {
        if (!entered) V3Entry { entered = true } else V3Shell()
    }
}

@Composable
private fun V3Entry(onEnter: () -> Unit) {
    Box(
        Modifier.fillMaxSize().background(
            Brush.verticalGradient(listOf(Color(0xFF140304), V3Black, Color(0xFF090909)))
        )
    ) {
        Column(
            Modifier.fillMaxSize().systemBarsPadding().padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(Modifier.height(28.dp))
            Text("INSPIRED FROM", color = V3Muted, letterSpacing = 4.sp, fontWeight = FontWeight.Bold)
            Text("ZEUS", color = V3Red, fontSize = 54.sp, fontWeight = FontWeight.Black, letterSpacing = 3.sp)
            Spacer(Modifier.height(34.dp))
            Text("ϟ", color = V3Red, fontSize = 132.sp, fontWeight = FontWeight.Black)
            Text("HMGS\nARENA", color = V3Text, fontSize = 52.sp, lineHeight = 50.sp, fontWeight = FontWeight.Black, textAlign = TextAlign.Center)
            Spacer(Modifier.height(12.dp))
            Text("PER ASPERA AD ASTRA", color = V3Text, fontWeight = FontWeight.Bold)
            Text("Zorluklardan yıldızlara", color = V3Muted)
            Spacer(Modifier.weight(1f))
            Button(
                onClick = onEnter,
                modifier = Modifier.fillMaxWidth().height(62.dp),
                shape = RoundedCornerShape(16.dp),
                colors = ButtonDefaults.buttonColors(containerColor = V3Red, contentColor = Color.White)
            ) { Text("ARENAYA GİR", fontSize = 20.sp, fontWeight = FontWeight.Black) }
        }
    }
}

@Composable
private fun V3Shell() {
    var tab by rememberSaveable { mutableStateOf(V3Tab.HOME) }
    Scaffold(
        containerColor = V3Black,
        bottomBar = { V3BottomBar(tab) { tab = it } }
    ) { pad ->
        Box(Modifier.padding(pad).fillMaxSize().background(Brush.verticalGradient(listOf(Color(0xFF0B0D10), V3Black)))) {
            when (tab) {
                V3Tab.HOME -> HomeV3(onLessons = { tab = V3Tab.LESSONS }, onArena = { tab = V3Tab.ARENA })
                V3Tab.LESSONS -> LessonsV3()
                V3Tab.ARENA -> ArenaExamV3()
                V3Tab.REPORTS -> ReportsV3()
                V3Tab.PROFILE -> ProfileV3()
            }
        }
    }
}

@Composable
private fun V3BottomBar(selected: V3Tab, onSelect: (V3Tab) -> Unit) {
    Surface(color = Color(0xFF0A0D10), border = BorderStroke(1.dp, Color.White.copy(alpha = .08f))) {
        Row(Modifier.fillMaxWidth().navigationBarsPadding().height(78.dp).padding(horizontal = 4.dp), verticalAlignment = Alignment.CenterVertically) {
            V3Tab.entries.forEach { tab ->
                val arena = tab == V3Tab.ARENA
                val active = tab == selected
                Column(
                    Modifier.weight(1f).clickable { onSelect(tab) }.padding(vertical = 8.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Box(
                        Modifier.size(if (arena) 42.dp else 34.dp).background(
                            when { arena -> V3Red; active -> V3Red.copy(alpha = .18f); else -> Color.Transparent },
                            CircleShape
                        ), contentAlignment = Alignment.Center
                    ) { Text(tab.icon, color = if (arena || active) Color.White else V3Muted, fontSize = if (arena) 23.sp else 19.sp) }
                    Spacer(Modifier.height(3.dp))
                    Text(tab.label, color = if (arena || active) V3Red else V3Muted, fontSize = 10.sp, fontWeight = if (active || arena) FontWeight.Black else FontWeight.Medium)
                }
            }
        }
    }
}

@Composable
private fun V3Page(title: String, subtitle: String? = null, content: @Composable ColumnScope.() -> Unit) {
    Column(Modifier.fillMaxSize().systemBarsPadding().verticalScroll(rememberScrollState()).padding(18.dp)) {
        Text("HMGS ARENA", color = V3Red, fontSize = 28.sp, fontWeight = FontWeight.Black)
        Text("PER ASPERA AD ASTRA", color = V3Muted, fontSize = 12.sp, letterSpacing = 1.5.sp)
        Spacer(Modifier.height(22.dp))
        Text(title, color = V3Text, fontSize = 25.sp, fontWeight = FontWeight.Black)
        if (subtitle != null) Text(subtitle, color = V3Muted, fontSize = 14.sp)
        Spacer(Modifier.height(16.dp))
        content()
        Spacer(Modifier.height(30.dp))
    }
}

@Composable
private fun DarkCard(title: String, body: String, red: Boolean = false, onClick: (() -> Unit)? = null) {
    Surface(
        modifier = Modifier.fillMaxWidth().padding(bottom = 12.dp).then(if (onClick != null) Modifier.clickable { onClick() } else Modifier),
        color = if (red) Color(0xFF19090A) else V3Panel,
        shape = RoundedCornerShape(18.dp),
        border = BorderStroke(1.dp, if (red) V3Red else Color.White.copy(alpha = .08f))
    ) {
        Column(Modifier.padding(18.dp)) {
            Text(title, color = if (red) V3Red else V3Text, fontSize = 18.sp, fontWeight = FontWeight.Black)
            Spacer(Modifier.height(6.dp))
            Text(body, color = V3Muted, fontSize = 14.sp, lineHeight = 20.sp)
        }
    }
}

@Composable
private fun HomeV3(onLessons: () -> Unit, onArena: () -> Unit) = V3Page("Ana Sayfa", "Hukuk dalları, Arena sınavı ve performans") {
    Text("DERSLER", color = V3Text, fontSize = 20.sp, fontWeight = FontWeight.Black)
    Spacer(Modifier.height(10.dp))
    lessonSummaries.take(6).chunked(2).forEach { row ->
        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(10.dp)) {
            row.forEach { lesson ->
                Surface(Modifier.weight(1f).clickable { onLessons() }, color = V3Panel, shape = RoundedCornerShape(16.dp), border = BorderStroke(1.dp, Color.White.copy(alpha = .08f))) {
                    Column(Modifier.padding(14.dp)) {
                        Text(lesson.title, color = V3Text, fontWeight = FontWeight.Bold, fontSize = 14.sp)
                        Spacer(Modifier.height(5.dp))
                        Text("Konu özetleri", color = V3Red, fontSize = 12.sp)
                        Text("Detaylı anlatım", color = V3Muted, fontSize = 11.sp)
                    }
                }
            }
        }
        Spacer(Modifier.height(10.dp))
    }
    TextButton(onClick = onLessons, modifier = Modifier.align(Alignment.End)) { Text("Tüm dersler  ›", color = V3Red) }
    Spacer(Modifier.height(8.dp))
    Text("ARENA", color = V3Text, fontSize = 20.sp, fontWeight = FontWeight.Black)
    DarkCard("⛨  ARENA", "Deneme sınavları • Gerçek sınav deneyimi • 120 soru / 155 dakika", red = true, onClick = onArena)
    Text("BAŞARI LİGİ", color = V3Text, fontSize = 20.sp, fontWeight = FontWeight.Black)
    Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
        listOf("Sıralaman\n—", "Doğru\n—", "Puanın\n—").forEach { label ->
            Surface(Modifier.weight(1f), color = V3Panel2, shape = RoundedCornerShape(14.dp)) {
                Text(label, Modifier.padding(vertical = 16.dp, horizontal = 8.dp), color = V3Text, textAlign = TextAlign.Center, fontWeight = FontWeight.Bold)
            }
        }
    }
}

@Composable
private fun LessonsV3() {
    var selected by remember { mutableStateOf<LessonSummary?>(null) }
    if (selected != null) {
        val lesson = selected!!
        V3Page(lesson.title, "Geniş ders özeti") {
            DarkCard("Genel Çerçeve", lesson.overview)
            Text("KONU HARİTASI", color = V3Red, fontWeight = FontWeight.Black)
            Spacer(Modifier.height(8.dp))
            lesson.topics.forEachIndexed { index, topic -> DarkCard("${index + 1}. $topic", "Bu başlık için kavramlar, istisnalar, sınavda karıştırılan ayrımlar ve kısa tekrar notları burada toplanır.") }
            OutlinedButton(onClick = { selected = null }, modifier = Modifier.fillMaxWidth(), border = BorderStroke(1.dp, V3Red)) { Text("DERSLERE DÖN", color = V3Red) }
        }
        return
    }
    V3Page("Dersler", "Her hukuk dalı için geniş özet ve konu haritası") {
        lessonSummaries.forEach { lesson -> DarkCard(lesson.title, lesson.short, onClick = { selected = lesson }) }
    }
}

@Composable
private fun ArenaExamV3() {
    val context = androidx.compose.ui.platform.LocalContext.current
    val bank = remember { runCatching { QuestionRepository.load(context) }.getOrDefault(emptyList()) }
    val eligible = remember(bank) { bank.filter { it.options.size == 5 } }
    var session by remember { mutableStateOf<List<Question>?>(null) }
    session?.let { NativeExamSession(questions = it, onExit = { session = null }); return }
    val ready = eligible.size >= 120
    V3Page("ARENA", "Kırmızı Arena modu • Deneme sınavları") {
        Surface(Modifier.fillMaxWidth(), color = Color(0xFF19090A), shape = RoundedCornerShape(22.dp), border = BorderStroke(2.dp, V3Red)) {
            Column(Modifier.padding(22.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                Box(Modifier.size(82.dp).background(V3Red, CircleShape), contentAlignment = Alignment.Center) { Text("⛨", color = Color.White, fontSize = 42.sp) }
                Spacer(Modifier.height(12.dp))
                Text("ARENA", color = V3Red, fontSize = 32.sp, fontWeight = FontWeight.Black)
                Text("Deneme Sınavları", color = V3Text, fontSize = 18.sp, fontWeight = FontWeight.Bold)
                Text("120 soru • 155 dakika • 5 seçenek", color = V3Muted)
            }
        }
        Spacer(Modifier.height(14.dp))
        DarkCard("Sınav Disiplini", "Süre bitince otomatik sonlandırma, 60. soruda zaman kontrolü ve cevapların sınav sonuna kadar saklanması.")
        Text(if (ready) "Arena hazır: ${eligible.size} uygun soru" else "Arena için 120 adet 5 seçenekli soru gerekir. Uygun soru: ${eligible.size}", color = if (ready) V3Red else Color(0xFFFFB0B0), fontWeight = FontWeight.Bold)
        Spacer(Modifier.height(14.dp))
        Button(onClick = { session = eligible.shuffled().take(120) }, enabled = ready, modifier = Modifier.fillMaxWidth().height(60.dp), colors = ButtonDefaults.buttonColors(containerColor = V3Red), shape = RoundedCornerShape(16.dp)) { Text("ARENA'YI BAŞLAT", fontWeight = FontWeight.Black) }
    }
}

@Composable
private fun ReportsV3() = V3Page("Raporlar", "Performans ve gelişim") {
    DarkCard("Başarı Oranı", "Ders ve konu bazında doğru, yanlış ve boş cevapların karşılaştırması burada gösterilecek.")
    DarkCard("Zayıf Konular", "Düşük başarı yüzdesine sahip başlıklar otomatik olarak tekrar listesine alınacak.")
    DarkCard("Arena Geçmişi", "Deneme süresi, netler, boşlar, başarı yüzdesi ve kişisel rekorlar burada tutulacak.")
}

@Composable
private fun ProfileV3() = V3Page("Profil", "Uygulama ve cihaz ayarları") {
    DarkCard("Sistem Gereksinimleri", "Android 10 veya üzeri • Telefon ve tablet uyumlu • Hedef Android 16")
    DarkCard("Görsel Tema", "Kırmızı-siyah Arena konsepti • yüksek kontrast • büyük dokunma alanları")
    DarkCard("Uygulama Sürümü", "HMGS Arena Native V3")
}
