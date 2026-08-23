package com.hmgsarena.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
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
            primary = androidx.compose.ui.graphics.Color(0xFFF0C965),
            background = androidx.compose.ui.graphics.Color(0xFF010712),
            surface = androidx.compose.ui.graphics.Color(0xFF071525)
        )
    ) {
        if (entered) ArenaHome() else EntryScreen(onEnter = { entered = true })
    }
}

@Composable
private fun ZeusImage(
    modifier: Modifier,
    contentScale: ContentScale,
    alpha: Float = 1f
) {
    val context = LocalContext.current
    val imageLoader = remember {
        ImageLoader.Builder(context)
            .components { add(SvgDecoder.Factory()) }
            .build()
    }

    AsyncImage(
        model = ImageRequest.Builder(context)
            .data("file:///android_asset/zeus_hmgs.svg")
            .crossfade(false)
            .build(),
        imageLoader = imageLoader,
        contentDescription = "Zeus",
        contentScale = contentScale,
        modifier = modifier.alpha(alpha)
    )
}

@Composable
private fun EntryScreen(onEnter: () -> Unit) {
    BoxWithConstraints(
        modifier = Modifier
            .fillMaxSize()
            .background(androidx.compose.ui.graphics.Color(0xFF010712))
    ) {
        val tablet = maxWidth >= 600.dp

        ZeusImage(
            modifier = Modifier.fillMaxSize(),
            contentScale = ContentScale.Crop
        )

        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(androidx.compose.ui.graphics.Color.Black.copy(alpha = 0.22f))
        )

        Column(
            modifier = Modifier
                .fillMaxSize()
                .systemBarsPadding()
                .padding(horizontal = if (tablet) 72.dp else 24.dp, vertical = 28.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Spacer(Modifier.weight(1f))

            Surface(
                color = androidx.compose.ui.graphics.Color(0xCC071525),
                shape = RoundedCornerShape(24.dp),
                tonalElevation = 10.dp,
                modifier = Modifier.widthIn(max = if (tablet) 560.dp else 420.dp)
            ) {
                Column(
                    modifier = Modifier.padding(if (tablet) 32.dp else 22.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text(
                        text = "HMGS ARENA",
                        color = androidx.compose.ui.graphics.Color(0xFFF0C965),
                        fontSize = if (tablet) 34.sp else 28.sp,
                        fontWeight = FontWeight.Black,
                        textAlign = TextAlign.Center
                    )
                    Spacer(Modifier.height(10.dp))
                    Text(
                        text = "Hazırsan arenaya gir",
                        color = androidx.compose.ui.graphics.Color.White,
                        fontSize = if (tablet) 19.sp else 16.sp,
                        textAlign = TextAlign.Center
                    )
                    Spacer(Modifier.height(22.dp))
                    Button(
                        onClick = onEnter,
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(if (tablet) 62.dp else 56.dp),
                        shape = RoundedCornerShape(18.dp)
                    ) {
                        Text(
                            "ARENAYA GİR",
                            fontSize = if (tablet) 20.sp else 17.sp,
                            fontWeight = FontWeight.ExtraBold
                        )
                    }
                }
            }
            Spacer(Modifier.height(if (tablet) 46.dp else 26.dp))
        }
    }
}

@Composable
private fun ArenaHome() {
    BoxWithConstraints(
        modifier = Modifier
            .fillMaxSize()
            .background(androidx.compose.ui.graphics.Color(0xFF06111E))
    ) {
        val tablet = maxWidth >= 600.dp

        ZeusImage(
            modifier = Modifier
                .fillMaxHeight()
                .widthIn(max = if (tablet) 650.dp else maxWidth)
                .align(Alignment.Center),
            contentScale = ContentScale.Crop,
            alpha = 0.11f
        )

        Column(
            modifier = Modifier
                .fillMaxSize()
                .systemBarsPadding()
                .padding(horizontal = if (tablet) 48.dp else 20.dp, vertical = 24.dp)
        ) {
            Text(
                text = "HMGS Arena",
                color = androidx.compose.ui.graphics.Color(0xFFF0C965),
                fontSize = if (tablet) 34.sp else 28.sp,
                fontWeight = FontWeight.Black
            )
            Spacer(Modifier.height(8.dp))
            Text(
                text = "Native Android temel sürümü",
                color = androidx.compose.ui.graphics.Color.White.copy(alpha = 0.85f),
                fontSize = if (tablet) 18.sp else 15.sp
            )
            Spacer(Modifier.height(28.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(14.dp)
            ) {
                HomeCard("Çalışma", "Soru ve konu çalışma merkezi", Modifier.weight(1f), tablet)
                if (tablet) HomeCard("Deneme", "90 soruluk denemeler", Modifier.weight(1f), tablet)
            }
            if (!tablet) {
                Spacer(Modifier.height(14.dp))
                HomeCard("Deneme", "90 soruluk denemeler", Modifier.fillMaxWidth(), tablet)
            }
            Spacer(Modifier.height(14.dp))
            HomeCard("Profil / Ayarlar", "Android 10 veya üzeri desteklenir", Modifier.fillMaxWidth(), tablet)
        }
    }
}

@Composable
private fun HomeCard(title: String, subtitle: String, modifier: Modifier, tablet: Boolean) {
    Card(
        modifier = modifier,
        shape = RoundedCornerShape(20.dp),
        colors = CardDefaults.cardColors(
            containerColor = androidx.compose.ui.graphics.Color(0xD9122235)
        )
    ) {
        Column(Modifier.padding(if (tablet) 24.dp else 18.dp)) {
            Text(title, color = androidx.compose.ui.graphics.Color.White, fontWeight = FontWeight.Bold, fontSize = if (tablet) 21.sp else 18.sp)
            Spacer(Modifier.height(6.dp))
            Text(subtitle, color = androidx.compose.ui.graphics.Color.White.copy(alpha = 0.72f), fontSize = if (tablet) 16.sp else 14.sp)
        }
    }
}
