# Mini Katalog Uygulaması

Flutter günlük eğitimi kapsamında geliştirilmiş basit bir ürün katalog uygulaması.
Ürün listeleme (GridView), arama, ürün detayı, sepete ekleme/çıkarma ve sayfalar arası
veri taşıma (Route Arguments) özelliklerini içerir. Ekstra paket kullanılmamıştır.

## Kullanılan Flutter Sürümü
Flutter 3.x (Dart 3.x) — kendi sürümünüzü `flutter --version` ile yazın.

## Çalıştırma Adımları
1. Repoyu klonlayın: `git clone <repo-url>`
2. Klasöre girin: `cd mini_katalog`
3. Eksik platform klasörleri varsa: `flutter create .`
4. Bağımlılıkları yükleyin: `flutter pub get`
5. Emulator/cihaz bağlayıp çalıştırın: `flutter run`

## Proje Yapısı
- `lib/models/` — Product modeli (fromJson/toJson) ve Cart (state)
- `lib/screens/` — Ana sayfa, ürün detayı, sepet
- `assets/products.json` — JSON simülasyonu ürün verisi
- `assets/images/banner.png` — Banner görseli

## Ekran Görüntüleri
![Ekran görüntüsü](./screenshots/screenshots/Ekran görüntüsü 2026-10-24 231105.png)


not:yaparken bazı yerleri daha basit olması için yapay zekadan destek aldım kusura bakmayım saygılarımla. 
