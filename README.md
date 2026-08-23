# HMGS ARENA

HMGS çalışma, deneme, XP/seviye ve sıralama uygulaması.

## PWA geliştirme akışı

Hızlı tasarım ve kullanım testleri `web-demo/` altındaki kurulabilir PWA üzerinden yapılır. Her denemede ekranda görünen sürüm kimliği `web-demo/version.js` dosyasında tutulur. Yeni bir deneme yayımlanmadan önce bu kimlik artırılır; service worker aynı kimlikle yeni önbellek oluşturup eski HMGS Arena önbelleklerini temizler.

Bu repo artık gerçek Flutter mobil uygulama iskeletini barındırır. Android ve iOS ortak Flutter kod tabanı hedeflenmektedir.

## Ürün ilkeleri
- Açılış: HMGS ARENA splash 3 sn → INSPIRED FROM ZEUS 3 sn → uygulama.
- Ana kullanım ekranları kaydırmasız tasarlanır; uzun içeriklerde sekme/sayfalama kullanılır.
- Soru sırasında doğru/yanlış geri bildirimi verilmez.
- Ücretsiz kullanıcı sonuçtan önce reklam görür; Premium kullanıcı sonucu doğrudan görür.
- Yanlış sorular test sonunda ayrı sayfalı inceleme ekranında gösterilir.
- XP kişisel ilerlemeyi; Arena Puanı başarı/sıralamayı temsil eder.
- Türkiye / il / kişisel sıralama ayrı görünümlerdir.
- ÖSYM soru metinleri kopyalanmaz; sorular özgün ve resmî mevzuat kaynaklıdır.
