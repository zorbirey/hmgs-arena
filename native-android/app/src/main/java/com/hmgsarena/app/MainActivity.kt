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
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.ImageLoader
import coil.compose.AsyncImage
import coil.decode.SvgDecoder
import coil.request.ImageRequest

private val Gold = Color(0xFFF4CC69)
private val GoldSoft = Color(0xFFD7AE51)
private val Navy = Color(0xFF020811)
private val Navy2 = Color(0xFF071522)
private val Panel = Color(0xF0132232)
private val Panel2 = Color(0xF0192A3D)
private val TextPrimary = Color(0xFFF7F4EA)
private val TextSecondary = Color(0xFFCAD2DB)

enum class ArenaTab(val label: String) {
    ARENA("Arena"), STUDY("Çalışma"), EXAM("Deneme"), WEAK("Zayıf"), RANK("Sıralama"), SETTINGS("Profil")
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent { HmgsArenaApp() }
    }
}

@Composable
private fun HmgsArenaApp() {
    var entered by rememberSaveable { mutableStateOf(false) }
    MaterialTheme(
        colorScheme = darkColorScheme(
            primary = Gold,
            onPrimary = Color(0xFF241600),
            background = Navy,
            surface = Navy2,
            onSurface = TextPrimary
        )
    ) {
        if (entered) ArenaShell() else EntryScreen { entered = true }
    }
}

@Composable
private fun SvgAsset(path: String, modifier: Modifier, contentScale: ContentScale, alpha: Float = 1f) {
    val context = LocalContext.current
    val loader = remember { ImageLoader.Builder(context).components { add(SvgDecoder.Factory()) }.build() }
    AsyncImage(
        model = ImageRequest.Builder(context).data("file:///android_asset/$path").crossfade(false).build(),
        imageLoader = loader,
        contentDescription = null,
        contentScale = contentScale,
        modifier = modifier.alpha(alpha)
    )
}

@Composable
private fun EntryScreen(onEnter: () -> Unit) {
    BoxWithConstraints(Modifier.fillMaxSize().background(Navy)) {
        val tablet = maxWidth >= 600.dp
        SvgAsset("zeus_cover_v2.svg", Modifier.fillMaxSize(), ContentScale.Crop)
        Box(
            Modifier.fillMaxSize().background(
                Brush.verticalGradient(
                    listOf(Color.Black.copy(alpha = .05f), Color.Transparent, Navy.copy(alpha = .34f), Navy.copy(alpha = .92f))
                )
            )
        )
        Column(
            Modifier.fillMaxSize().systemBarsPadding().padding(horizontal = if (tablet) 72.dp else 22.dp, vertical = 20.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text("INSPIRED FROM", color = TextSecondary, fontSize = if (tablet) 24.sp else 16.sp, fontWeight = FontWeight.Bold, letterSpacing = 3.sp)
            Text("ZEUS", color = Gold, fontSize = if (tablet) 58.sp else 42.sp, fontWeight = FontWeight.Black, letterSpacing = 3.sp)
            Spacer(Modifier.weight(1f))
            Surface(
                color = Color(0xE8091624),
                shape = RoundedCornerShape(28.dp),
                border = BorderStroke(1.dp, Gold.copy(alpha = .36f)),
                modifier = Modifier.fillMaxWidth().widthIn(max = 620.dp)
            ) {
                Column(Modifier.padding(if (tablet) 34.dp else 24.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                    Text("HMGS ARENA", color = Gold, fontSize = if (tablet) 40.sp else 31.sp, fontWeight = FontWeight.Black, textAlign = TextAlign.Center)
                    Spacer(Modifier.height(6.dp))
                    Text("PER ASPERA AD ASTRA", color = TextPrimary, fontSize = if (tablet) 20.sp else 16.sp, fontWeight = FontWeight.Bold)
                    Text("Zorluklardan yıldızlara", color = GoldSoft, fontSize = if (tablet) 18.sp else 15.sp)
                    Spacer(Modifier.height(24.dp))
                    Button(
                        onClick = onEnter,
                        modifier = Modifier.fillMaxWidth().height(if (tablet) 66.dp else 60.dp),
                        shape = RoundedCornerShape(18.dp),
                        colors = ButtonDefaults.buttonColors(containerColor = Gold, contentColor = Color(0xFF261800))
                    ) {
                        Text("ARENAYA GİR", fontSize = if (tablet) 22.sp else 19.sp, fontWeight = FontWeight.Black)
                    }
                }
            }
            Spacer(Modifier.height(12.dp))
        }
    }
}

@Composable
private fun ArenaShell() {
    var tab by rememberSaveable { mutableStateOf(ArenaTab.ARENA) }
    val bottomTabs = listOf(ArenaTab.ARENA, ArenaTab.STUDY, ArenaTab.EXAM, ArenaTab.WEAK, ArenaTab.SETTINGS)

    Scaffold(
        containerColor = Color.Transparent,
        bottomBar = {
            Surface(color = Color(0xFF061523), tonalElevation = 6.dp) {
                Row(
                    Modifier.fillMaxWidth().navigationBarsPadding().height(68.dp).padding(horizontal = 6.dp),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceEvenly
                ) {
                    bottomTabs.forEach { item ->
                        val selected = tab == item
                        Box(
                            Modifier.weight(1f).padding(horizontal = 3.dp).background(
                                if (selected) Gold.copy(alpha = .14f) else Color.Transparent,
                                RoundedCornerShape(16.dp)
                            ).clickable { tab = item }.padding(vertical = 12.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            Text(
                                item.label,
                                color = if (selected) Gold else TextSecondary,
                                fontWeight = if (selected) FontWeight.Black else FontWeight.SemiBold,
                                fontSize = 12.sp,
                                textAlign = TextAlign.Center
                            )
                        }
                    }
                }
            }
        }
    ) { pad ->
        Watermark {
            Box(Modifier.padding(pad).fillMaxSize()) {
                when (tab) {
                    ArenaTab.ARENA -> ArenaHome { tab = it }
                    ArenaTab.STUDY -> StudyCenter()
                    ArenaTab.EXAM -> ExamHome()
                    ArenaTab.WEAK -> WeakTopics()
                    ArenaTab.RANK -> Ranking { tab = ArenaTab.ARENA }
                    ArenaTab.SETTINGS -> SettingsPage()
                }
            }
        }
    }
}

@Composable
private fun Watermark(content: @Composable () -> Unit) {
    Box(Modifier.fillMaxSize().background(Brush.verticalGradient(listOf(Color(0xFF061421), Color(0xFF020912))))) {
        SvgAsset(
            "zeus_watermark_v2.svg",
            Modifier.width(330.dp).height(500.dp).align(Alignment.BottomEnd).offset(x = 58.dp, y = 36.dp),
            ContentScale.Fit,
            .055f
        )
        content()
    }
}

@Composable
private fun Page(title: String, subtitle: String? = null, content: @Composable ColumnScope.() -> Unit) {
    Column(
        Modifier.fillMaxSize().systemBarsPadding().verticalScroll(rememberScrollState()).padding(horizontal = 18.dp, vertical = 14.dp)
    ) {
        Text(title, color = Gold, fontSize = 29.sp, fontWeight = FontWeight.Black)
        if (subtitle != null) {
            Spacer(Modifier.height(4.dp))
            Text(subtitle, color = TextSecondary, fontSize = 14.sp)
        }
        Spacer(Modifier.height(18.dp))
        content()
        Spacer(Modifier.height(28.dp))
    }
}

@Composable
private fun ArenaCard(title: String, subtitle: String, onClick: (() -> Unit)? = null, accent: Boolean = false) {
    Surface(
        modifier = Modifier.fillMaxWidth().padding(bottom = 12.dp).then(if (onClick != null) Modifier.clickable { onClick() } else Modifier),
        shape = RoundedCornerShape(20.dp),
        color = if (accent) Panel2 else Panel,
        border = BorderStroke(1.dp, if (accent) Gold.copy(alpha = .35f) else Color.White.copy(alpha = .06f))
    ) {
        Column(Modifier.padding(19.dp)) {
            Text(title, color = if (accent) Gold else TextPrimary, fontSize = 19.sp, fontWeight = FontWeight.ExtraBold)
            Spacer(Modifier.height(6.dp))
            Text(subtitle, color = TextSecondary, fontSize = 15.sp, lineHeight = 21.sp)
        }
    }
}

@Composable
private fun ArenaHome(go: (ArenaTab) -> Unit) = Page("HMGS ARENA", "Bugünkü çalışma rotanı seç") {
    ArenaCard("Günlük Meydan Okuma", "Seri, XP ve günlük hedef sisteminin ana arena alanı.", { go(ArenaTab.STUDY) }, true)
    ArenaCard("Çalışma Merkezi", "Ders ve zorluk seçerek gerçek soru havuzundan odaklı tur başlat.") { go(ArenaTab.STUDY) }
    ArenaCard("Deneme Sınavları", "155 dakikalık HMGS sınav psikolojisine uygun tam deneme.") { go(ArenaTab.EXAM) }
    ArenaCard("Zayıf Konular", "Yanlışların ve düşük başarı oranlarının yoğunlaştığı konuları tekrar et.") { go(ArenaTab.WEAK) }
    ArenaCard("Arena Sıralaması", "Puan, seri ve deneme performansını görüntüle.") { go(ArenaTab.RANK) }
}

@Composable
private fun StudyCenter() {
    val context = LocalContext.current
    val bank = remember { runCatching { QuestionRepository.load(context) }.getOrDefault(emptyList()) }
    var subject by rememberSaveable { mutableStateOf("Tüm dersler") }
    var difficulty by rememberSaveable { mutableStateOf("Dengeli") }
    var session by remember { mutableStateOf<List<Question>?>(null) }

    session?.let { questions ->
        QuizSession(questions, "Çalışma Turu", true) { session = null }
        return
    }

    val subjects = remember(bank) { listOf("Tüm dersler") + bank.map { it.subject }.distinct().sorted() }
    val filtered = bank.filter { q ->
        (subject == "Tüm dersler" || q.subject == subject) && (difficulty == "Dengeli" || q.difficulty == difficultyKey(difficulty))
    }

    Page("Çalışma Merkezi", "Ders → zorluk → 20 soruluk tur") {
        ArenaCard("Soru havuzu", "${bank.size} soru yüklü • Seçimine uygun ${filtered.size} soru", accent = true)
        Text("Ders seç", color = Gold, fontWeight = FontWeight.Bold)
        Spacer(Modifier.height(8.dp))
        FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalArrangement = Arrangement.spacedBy(6.dp)) {
            subjects.forEach { FilterChip(selected = subject == it, onClick = { subject = it }, label = { Text(it) }) }
        }
        Spacer(Modifier.height(16.dp))
        Text("Zorluk seç", color = Gold, fontWeight = FontWeight.Bold)
        Spacer(Modifier.height(8.dp))
        FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalArrangement = Arrangement.spacedBy(6.dp)) {
            listOf("Dengeli", "Çok Kolay", "Kolay", "Orta", "Zor", "Çok Zor").forEach {
                FilterChip(selected = difficulty == it, onClick = { difficulty = it }, label = { Text(it) })
            }
        }
        Spacer(Modifier.height(18.dp))
        Button(
            onClick = { session = filtered.shuffled().take(20) },
            enabled = filtered.isNotEmpty(),
            modifier = Modifier.fillMaxWidth().height(58.dp),
            shape = RoundedCornerShape(18.dp)
        ) { Text("ÇALIŞMAYA BAŞLA", fontWeight = FontWeight.Black) }
    }
}

private fun difficultyKey(label: String) = when (label) {
    "Çok Kolay" -> "cok_kolay"
    "Kolay" -> "kolay"
    "Orta" -> "orta"
    "Zor" -> "zor"
    "Çok Zor" -> "cok_zor"
    else -> ""
}

@Composable
private fun ExamHome() {
    val context = LocalContext.current
    val bank = remember { runCatching { QuestionRepository.load(context) }.getOrDefault(emptyList()) }
    val eligible = remember(bank) { bank.filter { it.options.size == 5 } }
    var session by remember { mutableStateOf<List<Question>?>(null) }

    session?.let { questions ->
        NativeExamSession(questions = questions, onExit = { session = null })
        return
    }

    val ready = eligible.size >= 120
    Page("Deneme Sınavları", "Tam sınav modu") {
        ArenaCard("HMGS Tam Deneme", "120 soru • 5 seçenek • 155 dakika • hedef 77,5 sn/soru", accent = true)
        ArenaCard("Sınav psikolojisi", "Süre bitince otomatik sonlandırma, 60. soruda zaman kontrolü ve son 10 saniye cevapsız soru uyarısı.")
        Text(
            if (ready) "Deneme havuzu hazır: ${eligible.size} uygun soru" else "120 adet 5 seçenekli soru gerekli. Şu an uygun soru: ${eligible.size}",
            color = if (ready) Gold else MaterialTheme.colorScheme.error,
            fontWeight = FontWeight.Bold
        )
        Spacer(Modifier.height(16.dp))
        Button(
            onClick = { session = eligible.shuffled().take(120) },
            enabled = ready,
            modifier = Modifier.fillMaxWidth().height(58.dp),
            shape = RoundedCornerShape(18.dp)
        ) { Text("DENEMEYİ BAŞLAT", fontWeight = FontWeight.Black) }
    }
}

@Composable
private fun QuizSession(questions: List<Question>, title: String, showExplanations: Boolean, onExit: () -> Unit) {
    var index by remember { mutableIntStateOf(0) }
    var selected by remember { mutableStateOf<Int?>(null) }
    var correct by remember { mutableIntStateOf(0) }
    var finished by remember { mutableStateOf(false) }

    if (finished) {
        Page("Sonuç") {
            ArenaCard(title, "${questions.size} soruda $correct doğru • Başarı %${if (questions.isEmpty()) 0 else (correct * 100 / questions.size)}", accent = true)
            Button(onClick = onExit, modifier = Modifier.fillMaxWidth()) { Text("GERİ DÖN") }
        }
        return
    }

    val q = questions[index]
    Page(title, "Soru ${index + 1}/${questions.size} • ${q.subject} • ${q.topic}") {
        LinearProgressIndicator(progress = { (index + 1f) / questions.size }, modifier = Modifier.fillMaxWidth())
        Spacer(Modifier.height(16.dp))
        Surface(shape = RoundedCornerShape(18.dp), color = Panel, border = BorderStroke(1.dp, Color.White.copy(alpha = .06f))) {
            Text(q.question, Modifier.padding(18.dp), color = TextPrimary, fontSize = 20.sp, fontWeight = FontWeight.ExtraBold, lineHeight = 28.sp)
        }
        Spacer(Modifier.height(14.dp))
        q.options.forEachIndexed { i, option ->
            val answered = selected != null
            val isCorrect = i == q.correctIndex
            val container = when {
                answered && isCorrect -> Color(0xAA164D2C)
                answered && selected == i && !isCorrect -> Color(0xAA61252A)
                else -> Panel2
            }
            Surface(
                Modifier.fillMaxWidth().padding(bottom = 9.dp).clickable(enabled = !answered) {
                    selected = i
                    if (i == q.correctIndex) correct++
                },
                shape = RoundedCornerShape(16.dp),
                color = container,
                border = BorderStroke(1.dp, Color.White.copy(alpha = .07f))
            ) {
                Text("${('A'.code + i).toChar()})  $option", Modifier.padding(16.dp), color = TextPrimary, fontSize = 16.sp)
            }
        }
        if (selected != null) {
            if (showExplanations) ArenaCard("Çözüm / Açıklama", "${q.explanation}\nKaynak: ${q.sourceLabel} ${q.sourceRef}", accent = true)
            Button(
                onClick = {
                    if (index == questions.lastIndex) finished = true else { index++; selected = null }
                },
                modifier = Modifier.fillMaxWidth().height(54.dp)
            ) { Text(if (index == questions.lastIndex) "SONUCU GÖR" else "SONRAKİ SORU") }
        }
        TextButton(onClick = onExit, modifier = Modifier.fillMaxWidth()) { Text("OTURUMDAN ÇIK") }
    }
}

@Composable
private fun WeakTopics() = Page("Zayıf Konular", "Performansa göre tekrar") {
    ArenaCard("Kişisel zayıf konu analizi", "Başarı oranı düşük ders ve konu başlıkları burada önceliklendirilecek.", accent = true)
    ArenaCard("Bilgi Kartları", "Yanlış sorunun aynısını tekrar etmek yerine aynı konudan farklı soru ve kısa konu kartları gösterilecek.")
}

@Composable
private fun Ranking(onBack: () -> Unit) = Page("Arena Sıralaması", "Performans ve kişisel rekorlar") {
    ArenaCard("Sıralama", "Puan, seri ve deneme performansına göre sıralama alanı.", accent = true)
    ArenaCard("Kişisel Rekor", "En yüksek seri ve deneme başarıları burada tutulacak.")
    OutlinedButton(onClick = onBack, modifier = Modifier.fillMaxWidth()) { Text("ARENAYA DÖN") }
}

@Composable
private fun SettingsPage() = Page("Profil / Ayarlar", "Uygulama ve cihaz bilgileri") {
    ArenaCard("Sistem Gereksinimleri", "Android 10 veya üzeri • Telefon ve tablet uyumlu • Güncel Android sürümü önerilir.", accent = true)
    ArenaCard("Görsel motor", "Kapak ve filigran ayrı yerel assetlerden yüklenir; web/PWA önbelleğine bağlı değildir.")
    ArenaCard("Uyumluluk", "Minimum API 29 (Android 10) • Hedef API 36 (Android 16)")
}
