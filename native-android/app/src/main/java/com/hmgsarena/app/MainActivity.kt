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
import androidx.compose.ui.text.style.TextAlign
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
        super.onCreate(savedInstanceState); enableEdgeToEdge(); setContent { HmgsArenaApp() }
    }
}

@Composable private fun HmgsArenaApp() {
    var entered by rememberSaveable { mutableStateOf(false) }
    MaterialTheme(colorScheme = darkColorScheme(primary = Gold, background = Navy, surface = Color(0xFF071525))) {
        if (entered) ArenaShell() else EntryScreen { entered = true }
    }
}

@Composable private fun ZeusImage(modifier: Modifier, contentScale: ContentScale, alpha: Float = 1f) {
    val context = LocalContext.current
    val loader = remember { ImageLoader.Builder(context).components { add(SvgDecoder.Factory()) }.build() }
    AsyncImage(model = ImageRequest.Builder(context).data("file:///android_asset/zeus_hmgs.svg").crossfade(false).build(), imageLoader = loader, contentDescription = "Zeus", contentScale = contentScale, modifier = modifier.alpha(alpha))
}

@Composable private fun EntryScreen(onEnter: () -> Unit) {
    BoxWithConstraints(Modifier.fillMaxSize().background(Navy)) {
        val tablet = maxWidth >= 600.dp
        ZeusImage(Modifier.fillMaxSize(), ContentScale.Crop)
        Box(Modifier.fillMaxSize().background(Color.Black.copy(alpha=.24f)))
        Column(Modifier.fillMaxSize().systemBarsPadding().padding(horizontal=if(tablet)72.dp else 24.dp, vertical=28.dp), horizontalAlignment=Alignment.CenterHorizontally) {
            Spacer(Modifier.weight(1f)); Surface(color=Color(0xD9071525), shape=RoundedCornerShape(24.dp), modifier=Modifier.widthIn(max=560.dp)) {
                Column(Modifier.padding(if(tablet)32.dp else 22.dp), horizontalAlignment=Alignment.CenterHorizontally) {
                    Text("HMGS ARENA", color=Gold, fontSize=if(tablet)38.sp else 30.sp, fontWeight=FontWeight.Black)
                    Text("PER ASPERA AD ASTRA", color=Color.White, fontWeight=FontWeight.Bold); Text("Zorluklardan yıldızlara", color=Gold)
                    Spacer(Modifier.height(22.dp)); Button(onClick=onEnter, modifier=Modifier.fillMaxWidth().height(60.dp), shape=RoundedCornerShape(18.dp)) { Text("ARENAYA GİR", fontSize=20.sp, fontWeight=FontWeight.Black) }
                }
            }; Spacer(Modifier.height(28.dp))
        }
    }
}

@Composable private fun ArenaShell() {
    var tab by rememberSaveable { mutableStateOf(ArenaTab.ARENA) }
    Scaffold(containerColor=Color.Transparent, bottomBar={ NavigationBar(containerColor=Color(0xFA06192D)) { ArenaTab.entries.forEach { item -> NavigationBarItem(selected=tab==item, onClick={tab=item}, icon={Text(when(item){ArenaTab.ARENA->"⌂";ArenaTab.STUDY->"▤";ArenaTab.EXAM->"◷";ArenaTab.WEAK->"◈";ArenaTab.RANK->"♛";ArenaTab.SETTINGS->"⚙"})}, label={Text(item.label, fontSize=10.sp)}) } } }) { pad ->
        Watermark { Box(Modifier.padding(pad).fillMaxSize()) { when(tab){ ArenaTab.ARENA->ArenaHome{tab=it}; ArenaTab.STUDY->StudyCenter(); ArenaTab.EXAM->ExamHome(); ArenaTab.WEAK->WeakTopics(); ArenaTab.RANK->Ranking(); ArenaTab.SETTINGS->SettingsPage() } } }
    }
}

@Composable private fun Watermark(content:@Composable()->Unit) { Box(Modifier.fillMaxSize().background(Color(0xFF06111E))) { ZeusImage(Modifier.fillMaxSize().align(Alignment.Center), ContentScale.Fit, .10f); content() } }

@Composable private fun Page(title:String, content:@Composable ColumnScope.()->Unit) { Column(Modifier.fillMaxSize().systemBarsPadding().verticalScroll(rememberScrollState()).padding(18.dp)) { Text(title, color=Gold, fontSize=28.sp, fontWeight=FontWeight.Black); Spacer(Modifier.height(16.dp)); content(); Spacer(Modifier.height(30.dp)) } }
@Composable private fun ArenaCard(title:String, subtitle:String, onClick:(()->Unit)?=null) { Card(Modifier.fillMaxWidth().padding(bottom=12.dp).then(if(onClick!=null) Modifier.clickable{onClick()} else Modifier), shape=RoundedCornerShape(18.dp), colors=CardDefaults.cardColors(containerColor=Panel)) { Column(Modifier.padding(18.dp)) { Text(title,fontSize=19.sp,fontWeight=FontWeight.ExtraBold); Spacer(Modifier.height(5.dp)); Text(subtitle,color=Color.White.copy(alpha=.75f)) } } }

@Composable private fun ArenaHome(go:(ArenaTab)->Unit) = Page("HMGS ARENA") { ArenaCard("Günlük Meydan Okuma","Yeni sorular, seri ve XP sistemi için ana arena alanı."){go(ArenaTab.STUDY)}; ArenaCard("Çalışma Merkezi","Ders, konu ve zorluk seçerek odaklı çalışma."){go(ArenaTab.STUDY)}; ArenaCard("Deneme Sınavları","HMGS sınav psikolojisine uygun süreli deneme."){go(ArenaTab.EXAM)}; ArenaCard("Zayıf Konular","Performansa göre tekrar alanı."){go(ArenaTab.WEAK)} }

@Composable private fun StudyCenter() { var subject by rememberSaveable{mutableStateOf("Tüm dersler")}; var difficulty by rememberSaveable{mutableStateOf("Dengeli")}; Page("Çalışma Merkezi") { ArenaCard("HMGS Çalışma Arenası","Ders → konu → zorluk seç. Odaklı çalışma turunu başlat."); Text("1. Ders seç",color=Gold,fontWeight=FontWeight.Bold); FlowRow(horizontalArrangement=Arrangement.spacedBy(8.dp)){ listOf("Tüm dersler","Anayasa","Medeni","Borçlar","Ceza","İdare","Ticaret").forEach{ FilterChip(selected=subject==it,onClick={subject=it},label={Text(it)}) } }; Spacer(Modifier.height(12.dp)); Text("2. Zorluk seç",color=Gold,fontWeight=FontWeight.Bold); FlowRow(horizontalArrangement=Arrangement.spacedBy(8.dp)){ listOf("Dengeli","Kolay","Orta","Zor").forEach{ FilterChip(selected=difficulty==it,onClick={difficulty=it},label={Text(it)}) } }; Spacer(Modifier.height(16.dp)); ArenaCard("Seçim","$subject › $difficulty"); Button(onClick={},modifier=Modifier.fillMaxWidth().height(58.dp)){Text("ÇALIŞMAYA BAŞLA",fontWeight=FontWeight.Black)} }

@Composable private fun ExamHome() = Page("Deneme Sınavları") { ArenaCard("HMGS Tam Deneme","120 çoktan seçmeli soru • 5 seçenek • 155 dakika • hedef 77,5 sn/soru"); ArenaCard("Sınav psikolojisi modu","Sınav sırasında reklam yok. Süre bitince otomatik kapanır. 60. soruda zaman kontrolü yapılır. Sonuç ekranı deneme sonunda açılır."); Button(onClick={},modifier=Modifier.fillMaxWidth().height(58.dp)){Text("155 DAKİKALIK DENEMEYİ BAŞLAT",fontWeight=FontWeight.Black)} }
@Composable private fun WeakTopics() = Page("Zayıf Konular") { ArenaCard("Kişisel zayıf konu analizi","Başarı oranı düşük ders ve konu başlıkları önceliklendirilir."); ArenaCard("Bilgi Kartları","Yanlış sorunun aynısı yerine aynı konudan farklı soru ve kısa konu kartları sunulur.") }
@Composable private fun Ranking() = Page("Sıralama") { ArenaCard("Arena Sıralaması","Puan, seri ve deneme performansına göre sıralama alanı."); ArenaCard("Kişisel Rekor","En yüksek seri ve deneme başarıları burada tutulacak.") }
@Composable private fun SettingsPage() = Page("Profil / Ayarlar") { ArenaCard("Sistem Gereksinimleri","Android 10 veya üzeri • Telefon ve tablet uyumlu • En iyi deneyim için güncel Android sürümü önerilir."); ArenaCard("Görsel motor","Zeus kapak ve filigranları APK içindeki yerel assetlerden yüklenir. Web/PWA önbelleğine bağlı değildir."); ArenaCard("Uyumluluk","Minimum API 29 (Android 10) • Hedef API 36 (Android 16)") }
