# HMGS Arena Native Android

Bu klasör HMGS Arena'nın saf Android (Kotlin + Jetpack Compose) sürümüdür.

- Minimum Android: 10 (API 29)
- Hedef Android: 16 (API 36)
- Telefon ve tablet responsive düzen
- Zeus görseli uygulama içine yerel asset olarak gömülü
- Giriş ekranında ARENAYA GİR zorunlu
- İç ekranlarda sabit Zeus filigranı

## Çalıştırma
Android Studio ile `native-android` klasörünü proje olarak açın. JDK 17 kullanın ve `app` yapılandırmasını çalıştırın.

CI her push/PR'da debug APK üretir.
