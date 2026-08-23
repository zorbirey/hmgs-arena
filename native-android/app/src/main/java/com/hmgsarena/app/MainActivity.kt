package com.hmgsarena.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.ImageLoader
import coil.compose.AsyncImage
import coil.decode.SvgDecoder
import coil.request.ImageRequest

private val Gold = Color(0xFFF0C965)
private val Navy = Color(0xFF010712)
private val Panel = Color(0xE6122235)

enum class ArenaTab(val label: String) { ARENA("Arena"), STUDY("Çalışma"), EXAM("Deneme"), WEAK("Zayıf"), RANK("Sıralama"), SETTINGS("Ayarlar") }

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
    MaterialTheme(colorScheme = darkColorScheme(primary = Gold, background = Navy, surface = Color(0xFF071525))) {
        if (entered) ArenaShell() else EntryScreen { entered = true }
    }
}

@Composable
private fun ZeusImage(modifier: Modifier, contentScale: ContentScale, alpha: Float = 1f) {
    val context = LocalContext.current
    val loader = remember { ImageLoader.Builder(context).components { add(SvgDecoder.Factory()) }.build() }
    AsyncImage(
        model = ImageRequest.Builder(context).data("file:///android_asset/zeus_hmgs.svg").crossfade(false).build(),
        imageLoader = loader,
        contentDescription = "Zeus",
        contentScale = contentScale,
        modifier = modifier.alpha(alpha)
    )
}

@Composable
private fun EntryScreen(onEnter: () -> Unit) {
    BoxWithConstraints(Modifier.fillMaxSize().background(Navy)) {
        val tablet = maxWidth >= 600.dp
        ZeusImage(Modifier.fillMaxSize(), ContentScale.Crop)
        Box(Modifier.fillMaxSize().background(Color.Black.copy(alpha = .24f)))
        Column(
            Modifier.fillMaxSize().systemBarsPadding().padding(horizontal = if (tablet) 72.dp else 24.dp, vertical = 28.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(Modifier.weight(1f))
            Surface(color = Color(0xD9071525), shape = RoundedCornerShape(24.dp), modifier = Modifier.widthIn(max = 560.dp)) {
                Column(Modifier.padding(if (tablet) 32.dp else 22.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                    Text("HMGS ARENA", color = Gold, fontSize = if (tablet) 38.sp else 30.sp, fontWeight = FontWeight.Black)
                    Text("PER ASPERA AD ASTRA", color = Color.White, fontWeight = FontWeight.Bold)
                    Text("Zorluklardan yıldızlara", color = Gold)
                    Spacer(Modifier.height(22.dp))
                    Button(onClick = onEnter, modifier = Modifier.fillMaxWidth().height(60.dp), shape = RoundedCornerShape(18.dp)) {
                        Text("ARENAYA GİR", fontSize = 20.sp, fontWeight = FontWeight.Black)
                    }
                }
            }
            Spacer(Modifier.height(28.dp))
        }
    }
}

@Composable
private fun ArenaShell() {
    var tab by rememberSaveable { mutableStateOf(ArenaTab.ARENA) }
    Scaffold(
        containerColor = Color.Transparent,
        bottomBar = {
            NavigationBar(containerColor = Color(0xFA06192D)) {
                ArenaTab.entries.forEach { item ->
                    NavigationBarItem(
                        selected = tab == item,
                        onClick = { tab = item },
                        icon = { Text(when (item) { ArenaTab.ARENA -> "⌂"; ArenaTab.STUDY -> "▤"; ArenaTab.EXAM -> "◷"; ArenaTab.WEAK -> "◈"; ArenaTab.RANK -> "♛"; ArenaTab.SETTINGS -> "⚙" }) },
                        label = { Text(item.label, fontSize = 10.sp) }
                    )
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
                    ArenaTab.RANK -> Ranking()
                    ArenaTab.SETTINGS -> SettingsPage()
                }
            }
        }
    }
}

@Composable
private fun Watermark(content: @Composable () -> Unit) {
    Box(Modifier.fillMaxSize().background(Color(0xFF06111E))) {
        ZeusImage(Modifier.fillMaxSize().align(Alignment.Center), ContentScale.Fit, .10f)
        content()
    }
}

@Composable
private fun Page(title: String, content: @Composable ColumnScope.() -> Unit) {
    Column(Modifier.fillMaxSize().systemBarsPadding().verticalScroll(rememberScrollState()).padding(18.dp)) {
        Text(title, color = Gold, fontSize = 28.sp, fontWeight = FontWeight.Black)
        Spacer(Modifier.height(16.dp))
        content()
        Spacer(Modifier.height(30.dp))
    }
}

@Composable
private fun ArenaCard(title: String, subtitle: String, onClick: (() -> Unit)? = null) {
    Card(
        Modifier.fillMaxWidth().padding(bottom = 12.dp).then(if (onClick != null) Modifier.clickable { onClick() } else Modifier),
        shape = RoundedCornerShape(18.dp),
        colors = CardDefaults.cardColors(containerColor = Panel)
    ) {
        Column(Modifier.padding(18.dp)) {
            Text(title, fontSize = 19.sp, fontWeight = FontWeight.ExtraBold)
            Spacer(Modifier.height(5.dp))
            Text(subtitle, color = Color.White.copy(alpha = .75f))
        }
    }
}

@Composable
private fun ArenaHome(go: (ArenaTab) -> Unit) = Page("HMGS ARENA") {
    ArenaCard("Günlük Meydan Okuma", "Yeni sorular, seri ve XP sistemi için ana arena alanı.") { go(ArenaTab.STUDY) }
    ArenaCard("Çalışma Merkezi", "Ders, konu ve zorluk seçerek odaklı çalışma.") { go(ArenaTab.STUDY) }
    ArenaCard("Deneme Sınavları", "HMGS sınav psikolojisine uygun süreli deneme.") { go(ArenaTab.EXAM) }
    ArenaCard("Zayıf Konular", "Performansa göre tekrar alanı.") { go(ArenaTab.WEAK) }
}

@Composable
private fun StudyCenter() {
    val context = LocalContext.current
    val bank = remember { runCatching { QuestionRepository.load(context) }.getOrDefault(emptyList()) }
    var subject by rememberSaveable { mutableStateOf("Tüm dersler") }
    var difficulty by rememberSaveable { mutableStateOf("Dengeli") }
    var session by remember { mutableStateOf<List<Question>?>(null) }

    session?.let { questions ->
        QuizSession(questions = questions, title = "Çalışma Turu", showExplanations = true, onExit = { session = null })
        return
    }

    val subjects = remember(bank) { listOf("Tüm dersler") + bank.map { it.subject }.distinct().sorted() }
    val filtered = bank.filter { q ->
        (subject == "Tüm dersler" || q.subject == subject) &&
            (difficulty == "Dengeli" || q.difficulty == difficultyKey(difficulty))
    }

    Page("Çalışma Merkezi") {
        ArenaCard("HMGS Çalışma Arenası", "Ders ve zorluk seç. Gerçek soru havuzundan 20 soruluk tur başlat.")
        Text("Yüklü soru: ${bank.size}", color = Gold, fontWeight = FontWeight.Bold)
        Spacer(Modifier.height(12.dp))
        Text("1. Ders seç", color = Gold, fontWeight = FontWeight.Bold)
        FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            subjects.forEach { FilterChip(selected = subject == it, onClick = { subject = it }, label = { Text(it) }) }
        }
        Spacer(Modifier.height(12.dp))
        Text("2. Zorluk seç", color = Gold, fontWeight = FontWeight.Bold)
        FlowRow(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            listOf("Dengeli", "Çok Kolay", "Kolay", "Orta", "Zor", "Çok Zor").forEach {
                FilterChip(selected = difficulty == it, onClick = { difficulty = it }, label = { Text(it) })
            }
        }
        Spacer(Modifier.height(16.dp))
        ArenaCard("Uygun soru", "${filtered.size} soru • $subject • $difficulty")
        Button(
            onClick = { session = filtered.shuffled().take(20) },
            enabled = filtered.isNotEmpty(),
            modifier = Modifier.fillMaxWidth().height(58.dp)
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
        QuizSession(questions = questions, title = "HMGS Tam Deneme", showExplanations = false, onExit = { session = null })
        return
    }

    Page("Deneme Sınavları") {
        ArenaCard("HMGS Tam Deneme", "120 çoktan seçmeli soru • 5 seçenek • 155 dakika • hedef 77,5 sn/soru")
        ArenaCard("Sınav psikolojisi modu", "Sınav sırasında reklam yok. Süre bitince otomatik kapanır. Sonuç ekranı deneme sonunda açılır.")
        val ready = eligible.size >= 120
        Text(
            if (ready) "Deneme havuzu hazır: ${eligible.size} uygun soru" else "Deneme için 120 adet 5 seçenekli soru gerekir. Şu an uygun soru: ${eligible.size}",
            color = if (ready) Gold else MaterialTheme.colorScheme.error,
            fontWeight = FontWeight.Bold
        )
        Spacer(Modifier.height(16.dp))
        Button(
            onClick = { session = eligible.shuffled().take(120) },
            enabled = ready,
            modifier = Modifier.fillMaxWidth().height(58.dp)
        ) { Text("155 DAKİKALIK DENEMEYİ BAŞLAT", fontWeight = FontWeight.Black) }
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
            ArenaCard(title, "${questions.size} soruda $correct doğru • Başarı %${if (questions.isEmpty()) 0 else (correct * 100 / questions.size)}")
            Button(onClick = onExit, modifier = Modifier.fillMaxWidth()) { Text("GERİ DÖN") }
        }
        return
    }

    val q = questions[index]
    Page(title) {
        LinearProgressIndicator(progress = { (index + 1f) / questions.size }, modifier = Modifier.fillMaxWidth())
        Spacer(Modifier.height(12.dp))
        Text("Soru ${index + 1}/${questions.size} • ${q.subject} • ${q.topic}", color = Gold, fontWeight = FontWeight.Bold)
        Spacer(Modifier.height(12.dp))
        Text(q.question, fontSize = 20.sp, fontWeight = FontWeight.ExtraBold)
        Spacer(Modifier.height(14.dp))
        q.options.forEachIndexed { i, option ->
            val answered = selected != null
            val isCorrect = i == q.correctIndex
            val container = when {
                answered && isCorrect -> Color(0x6632A852)
                answered && selected == i && !isCorrect -> Color(0x66C93C3C)
                else -> Panel
            }
            Card(
                Modifier.fillMaxWidth().padding(bottom = 8.dp).clickable(enabled = !answered) {
                    selected = i
                    if (i == q.correctIndex) correct++
                },
                colors = CardDefaults.cardColors(containerColor = container)
            ) {
                Text("${('A'.code + i).toChar()}) $option", Modifier.padding(16.dp), fontSize = 16.sp)
            }
        }
        if (selected != null) {
            if (showExplanations) {
                ArenaCard("Çözüm / Açıklama", "${q.explanation}\nKaynak: ${q.sourceLabel} ${q.sourceRef}")
            }
            Button(
                onClick = {
                    if (index == questions.lastIndex) finished = true
                    else { index++; selected = null }
                },
                modifier = Modifier.fillMaxWidth().height(54.dp)
            ) { Text(if (index == questions.lastIndex) "SONUCU GÖR" else "SONRAKİ SORU") }
        }
        TextButton(onClick = onExit, modifier = Modifier.fillMaxWidth()) { Text("OTURUMDAN ÇIK") }
    }
}

@Composable private fun WeakTopics() = Page("Zayıf Konular") {
    ArenaCard("Kişisel zayıf konu analizi", "Başarı oranı düşük ders ve konu başlıkları önceliklendirilir.")
    ArenaCard("Bilgi Kartları", "Yanlış sorunun aynısı yerine aynı konudan farklı soru ve kısa konu kartları sunulur.")
}

@Composable private fun Ranking() = Page("Sıralama") {
    ArenaCard("Arena Sıralaması", "Puan, seri ve deneme performansına göre sıralama alanı.")
    ArenaCard("Kişisel Rekor", "En yüksek seri ve deneme başarıları burada tutulacak.")
}

@Composable private fun SettingsPage() = Page("Profil / Ayarlar") {
    ArenaCard("Sistem Gereksinimleri", "Android 10 veya üzeri • Telefon ve tablet uyumlu • En iyi deneyim için güncel Android sürümü önerilir.")
    ArenaCard("Görsel motor", "Zeus kapak ve filigranları APK içindeki yerel assetlerden yüklenir. Web/PWA önbelleğine bağlı değildir.")
    ArenaCard("Uyumluluk", "Minimum API 29 (Android 10) • Hedef API 36 (Android 16)")
}
