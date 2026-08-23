package com.hmgsarena.app

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay

private const val EXAM_TOTAL_SECONDS = 155 * 60
private const val HALF_TIME_SECONDS = 77 * 60 + 30
private const val TARGET_SECONDS_PER_QUESTION = 77.5
private val ExamGold = Color(0xFFF0C965)
private val ExamPanel = Color(0xE6122235)

@Composable
fun NativeExamSession(
    questions: List<Question>,
    onExit: () -> Unit
) {
    var index by remember { mutableIntStateOf(0) }
    val answers = remember { mutableStateMapOf<Int, Int>() }
    var remainingSeconds by rememberSaveable { mutableIntStateOf(EXAM_TOTAL_SECONDS) }
    var questionSeconds by rememberSaveable { mutableIntStateOf(0) }
    var finished by rememberSaveable { mutableStateOf(false) }
    var timeExpired by rememberSaveable { mutableStateOf(false) }
    var showHalfTimeWarning by rememberSaveable { mutableStateOf(false) }
    var halfTimeWarningShown by rememberSaveable { mutableStateOf(false) }

    LaunchedEffect(finished) {
        while (!finished && remainingSeconds > 0) {
            delay(1000)
            remainingSeconds--
            questionSeconds++
            if (!halfTimeWarningShown && index >= 59 && remainingSeconds < EXAM_TOTAL_SECONDS - HALF_TIME_SECONDS) {
                halfTimeWarningShown = true
                showHalfTimeWarning = true
            }
            if (remainingSeconds <= 0) {
                timeExpired = true
                finished = true
            }
        }
    }

    if (showHalfTimeWarning) {
        AlertDialog(
            onDismissRequest = {},
            title = { Text("Zaman Uyarısı") },
            text = { Text("60. soruya ulaştın ancak sınav süresinin yarısı olan 77 dakika 30 saniyeyi aştın. Kalan sorularda temponu artır.") },
            confirmButton = { Button(onClick = { showHalfTimeWarning = false }) { Text("DEVAM ET") } }
        )
    }

    if (finished) {
        val correct = questions.indices.count { answers[it] == questions[it].correctIndex }
        val blank = questions.size - answers.size
        val wrong = answers.size - correct
        val used = EXAM_TOTAL_SECONDS - remainingSeconds
        ExamResult(
            correct = correct,
            wrong = wrong,
            blank = blank,
            total = questions.size,
            usedSeconds = used,
            timeExpired = timeExpired,
            onExit = onExit
        )
        return
    }

    val q = questions[index]
    val selected = answers[index]
    val targetRemaining = TARGET_SECONDS_PER_QUESTION - questionSeconds
    val urgent = selected == null && targetRemaining in 0.0..10.0

    Column(
        Modifier
            .fillMaxSize()
            .background(if (urgent && questionSeconds % 2 == 0) Color(0x552B0000) else Color.Transparent)
            .systemBarsPadding()
            .verticalScroll(rememberScrollState())
            .padding(16.dp)
    ) {
        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
            Text("${index + 1} / ${questions.size}", color = ExamGold, fontWeight = FontWeight.Black)
            Column(horizontalAlignment = androidx.compose.ui.Alignment.End) {
                Text(formatTime(remainingSeconds), fontWeight = FontWeight.Black, fontSize = 18.sp)
                Text(
                    if (targetRemaining >= 0) "Hedef ${formatTime(targetRemaining.toInt())}" else "+${formatTime((-targetRemaining).toInt())}",
                    color = if (targetRemaining <= 10) MaterialTheme.colorScheme.error else Color.White.copy(alpha = .7f),
                    fontSize = 12.sp
                )
            }
        }
        Spacer(Modifier.height(8.dp))
        LinearProgressIndicator(progress = { (index + 1f) / questions.size }, modifier = Modifier.fillMaxWidth())
        Spacer(Modifier.height(18.dp))
        Text("${q.subject} • ${q.topic}", color = ExamGold, fontWeight = FontWeight.Bold)
        Spacer(Modifier.height(10.dp))
        Text(q.question, fontSize = 20.sp, fontWeight = FontWeight.ExtraBold)
        Spacer(Modifier.height(16.dp))

        q.options.forEachIndexed { optionIndex, option ->
            Card(
                Modifier
                    .fillMaxWidth()
                    .padding(bottom = 8.dp)
                    .clickable { answers[index] = optionIndex },
                colors = CardDefaults.cardColors(
                    containerColor = if (selected == optionIndex) Color(0xFF263B52) else ExamPanel
                ),
                shape = RoundedCornerShape(14.dp)
            ) {
                Text("${('A'.code + optionIndex).toChar()}) $option", Modifier.padding(16.dp), fontSize = 16.sp)
            }
        }

        if (urgent) {
            Text("Bu soru için hedef sürenin son 10 saniyesindesin.", color = MaterialTheme.colorScheme.error, fontWeight = FontWeight.Bold)
            Spacer(Modifier.height(8.dp))
        }

        Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            OutlinedButton(
                onClick = { if (index > 0) { index--; questionSeconds = 0 } },
                enabled = index > 0,
                modifier = Modifier.weight(1f)
            ) { Text("ÖNCEKİ") }
            Button(
                onClick = {
                    if (index == questions.lastIndex) finished = true
                    else { index++; questionSeconds = 0 }
                },
                modifier = Modifier.weight(1f)
            ) { Text(if (index == questions.lastIndex) "BİTİR" else "SONRAKİ") }
        }
        TextButton(onClick = { finished = true }, modifier = Modifier.fillMaxWidth()) { Text("SINAVI ŞİMDİ BİTİR") }
    }
}

@Composable
private fun ExamResult(
    correct: Int,
    wrong: Int,
    blank: Int,
    total: Int,
    usedSeconds: Int,
    timeExpired: Boolean,
    onExit: () -> Unit
) {
    val success = if (total == 0) 0.0 else correct * 100.0 / total
    Column(Modifier.fillMaxSize().systemBarsPadding().verticalScroll(rememberScrollState()).padding(18.dp)) {
        Text("Deneme Sonucu", color = ExamGold, fontSize = 28.sp, fontWeight = FontWeight.Black)
        Spacer(Modifier.height(16.dp))
        if (timeExpired) {
            Card(colors = CardDefaults.cardColors(containerColor = ExamPanel), modifier = Modifier.fillMaxWidth()) {
                Text("155 dakikalık toplam süre sona erdiği için sınav otomatik olarak bitirildi.", Modifier.padding(16.dp), fontWeight = FontWeight.Bold)
            }
            Spacer(Modifier.height(12.dp))
        }
        Card(colors = CardDefaults.cardColors(containerColor = ExamPanel), modifier = Modifier.fillMaxWidth()) {
            Column(Modifier.padding(20.dp)) {
                Text("%${"%.1f".format(success)}", fontSize = 40.sp, fontWeight = FontWeight.Black, color = ExamGold)
                Text("Doğru cevap oranı")
                Spacer(Modifier.height(18.dp))
                ResultLine("Doğru", correct.toString())
                ResultLine("Yanlış", wrong.toString())
                ResultLine("Boş", blank.toString())
                ResultLine("Kullanılan süre", formatTime(usedSeconds))
            }
        }
        Spacer(Modifier.height(12.dp))
        Text("Bu sonuç çalışma analizidir; ÖSYM tarafından hesaplanan resmi sınav puanı değildir.", color = Color.White.copy(alpha = .72f))
        Spacer(Modifier.height(18.dp))
        Button(onClick = onExit, modifier = Modifier.fillMaxWidth().height(54.dp)) { Text("DENEMELERE DÖN") }
    }
}

@Composable private fun ResultLine(label: String, value: String) {
    Row(Modifier.fillMaxWidth().padding(vertical = 5.dp), horizontalArrangement = Arrangement.SpaceBetween) {
        Text(label); Text(value, fontWeight = FontWeight.Bold)
    }
}

private fun formatTime(totalSeconds: Int): String {
    val safe = totalSeconds.coerceAtLeast(0)
    val hours = safe / 3600
    val minutes = (safe % 3600) / 60
    val seconds = safe % 60
    return if (hours > 0) "%02d:%02d:%02d".format(hours, minutes, seconds) else "%02d:%02d".format(minutes, seconds)
}
