# Claude Design Brief: free-task Product Design

## Ne zaman kullanilacak?

Bu brief, PRD tamamlandiktan sonra ve teknik tasarimdan once kullanilmalidir.

Amac yalnizca dar bir MVP ekrani cizdirmek degil; free-task icin genel urun tasarim omurgasini, design system yonunu, navigasyon mantigini ve Faz 2/Faz 3'e genisleyebilecek deneyim yapisini netlestirmektir.

Detay seviyesi ikiye ayrilmalidir:

1. Genel urun tasarimi: tum fazlari kapsayan urun dili, navigasyon felsefesi, component sistemi, tema/token yapisi, guvenlik/offline iletisim dili ve genisleme modeli.
2. Detayli ekran tasarimi: MVP kapsamindaki ekranlar icin ayrintili layout, state, component ve mikro metin spesifikasyonu.

Faz 2 ve Faz 3 icin tam ekran tasarimlari degil, "ileride genisleme planı" istenir. Boylece bugunku tasarim gelecekte kirilmaz ama MVP de sismez.

## Claude Design'a verilecek dosyalar

1. `docs/project/prd.md`
   - Ana urun ve faz kapsamidir.
   - MVP, Faz 2 ve Faz 3 ayrimini buradan oku.

2. `docs/project/claude-design-brief.md`
   - Tasarim gorevinin talimat dosyasidir.
   - Claude repo okuyabiliyorsa bu dosyanin tamamini takip etmeli.

3. Varsa sonradan eklenecek tasarim referanslari
   - Logo, renk tercihi, font tercihi, sevdigin uygulama ekranlari.
   - Su an zorunlu degil.

Bu dosyalar disinda ek varsayim yapilmamalidir. PRD'de olmayan buyuk ozellikler ana tasarima eklenmemelidir.

## Faz kapsamı

### MVP - Detayli tasarlanacak

- Bireysel kullanici.
- Mobil oncelikli cok platformlu uygulama.
- Yerel sifreli kasa / E2EE prensibi.
- Offline kullanilabilir gorev yonetimi.
- Gorev CRUD, alt gorevler, zamanlama, tekrar, deadline, zamansiz havuz.
- Gunluk liste, takvim/tarih secici, basit istatistik.
- JSON/Markdown export, free-task JSON import.
- Light/dark tema ve temel gorunum tercihleri.
- Basit yerel tarih/saat ayrıştırma.

### Faz 2 - Genisleme planı tasarlanacak

- Self-host senkronizasyon.
- Docker Compose ile kurulum deneyimi.
- SaaS alternatifi.
- Cihazlar arasi E2EE sync.
- Multi-user, roller, aile/takim gorevleri.
- Daha guclu import.
- Kapsamli istatistik paneli.
- Ileri tema sistemi ve topluluk temalari.

Faz 2 icin ayrintili MVP ekran spesifikasyonu istenmez; ancak mevcut navigasyon, ayarlar, guvenlik yuzeyleri ve component sistemi Faz 2'ye nasil genisler aciklanmalidir.

### Faz 3 - Genisleme planı tasarlanacak

- Bulut ve lokal AI saglayicilari.
- AI destekli planlama, sesli komut, gorsel analiz.
- Human-in-the-loop AI gorev onayi.
- Agent/plugin altyapisi.
- Ozellestirilebilir system prompt ve kullanici baglam penceresi.
- REST/GraphQL API, webhooks, otomasyon entegrasyonlari.
- Gorev agaci / DAG / skill-tree gorunumu.
- Opsiyonel oyunlastirma, puan ve leaderboard.

Faz 3 icin ana MVP tasarimina AI veya platform karmaşasi eklenmez. Ancak design system, bilgi mimarisi ve component dili bu guclu ozellikleri sonradan kaldirabilecek sekilde planlanir.

## Claude Design'dan istenecek cikti

- Tum fazlari dusunen genel urun tasarim omurgasi.
- MVP icin mobil oncelikli uygulama ekranlari.
- Marketing/landing page degil, gercek uygulama deneyimi.
- Low-fidelity akis mantigi + high-fidelity ilk gorsel yon.
- Light ve dark tema yonu.
- Sade uretkenlik araci hissi; yogun, okunakli, dikkat dagitmayan deneyim.
- E2EE ve offline kullanilabilirlik gibi guven/guvenlik durumlarinin UI'da nasil anlatilacagi.
- Faz 2 ve Faz 3'e gecildiginde navigasyonun, ayarlarin, component sisteminin ve durum tasarimlarinin nasil genisleyecegi.

## MVP'de oncelikli ekranlar

1. Ilk acilis ve yerel sifreli kasa kurulumu.
2. Locked vault / kasa kilitli ekranı.
3. Bugun/Gunluk liste.
4. Yeni gorev ekleme bottom sheet veya tam ekran formu.
5. Gorev detay ve alt gorevler.
6. Zamanlama/tekrar kuralı duzenleme.
7. Havuz/Zamansiz gorevler.
8. Takvim veya tarih secici.
9. Istatistik ozeti.
10. Ayarlar: gizlilik, export/import, tema, tamamlanan gorev davranisi.
11. Offline, bos liste, hata, permission denied, import error ve metadata fetch failed durumlari.

## Faz 2/Faz 3 icin genisleme yuzeyleri

Claude, asagidaki yuzeyleri detayli ekran gibi cizmek zorunda degil; fakat MVP tasariminin bunlara nasil genisleyecegini anlatmalidir:

- Sync status ve cihazlar arasi senkronizasyon durumu.
- Self-host/SaaS secimi ve hesap/sunucu baglanti ayarlari.
- Cihaz ekleme, kurtarma ve E2EE anahtar guven modeli.
- Aile/takim alanlari, rol degistirme, atanan gorevler.
- Gelismis istatistik paneli.
- Tema magazasi veya tema import/export.
- AI komut girişi, AI onay ekranı, AI tarafindan uretilen gorev onizlemesi.
- Agent/plugin yonetimi.
- API key, webhook ve otomasyon ayarlari.
- Gorev agaci / bagimlilik gorunumu.
- Oyunlastirma yuzeyleri ana deneyimi bozmadan nerede durur.

## Claude Design icin nihai kopyalanabilir prompt

```text
Bu repo free-task projesinin planlama reposu. Önce yalnızca şu dosyaları kaynak kabul ederek oku:

1. docs/project/prd.md
2. docs/project/claude-design-brief.md

Bu iki dosya bu tasarım çalışmasının tek kaynak gerçekliğidir. Bu dosyaların dışında ek varsayım yapma ve PRD’deki faz kapsamını bozma.

Görevin:
free-task için genel ürün tasarım omurgasını ve mobil öncelikli ilk uygulama tasarımını oluştur.

Sadece dar MVP ekranları üretme. Önce free-task’in tüm fazlara dayanacak genel ürün tasarım yönünü, design system yaklaşımını, navigasyon mantığını, güvenlik/offline iletişim dilini ve Faz 2/Faz 3’e genişleme modelini tanımla. Ancak detaylı ekran spesifikasyonlarını MVP kapsamındaki ekranlarla sınırla. Faz 2/Faz 3 için tam ekran tasarımı değil, ileride genişleme notları ve bilgi mimarisi etkileri üret.

Önemli kapsam:
- MVP: bireysel kullanıcı, mobil öncelikli görev/rutin yönetimi, yerel şifreli kasa, offline kullanılabilirlik, görev CRUD, alt görevler, zamanlama, tekrar, deadline, zamansız havuz, takvim, basit istatistik, import/export, light/dark tema.
- Faz 2: self-host sync, SaaS alternatifi, cihazlar arası E2EE sync, multi-user, roller, gelişmiş import, gelişmiş istatistik, ileri tema sistemi.
- Faz 3: AI sağlayıcıları, lokal AI, ses/görsel girdiler, human-in-the-loop AI görev onayı, agent/plugin sistemi, API/webhooks, görev ağacı, opsiyonel oyunlaştırma.

Tasarım öncelikleri:
- Bu bir landing page veya marketing sitesi değil; gerçek kullanılabilir görev/rutin yönetimi uygulaması olacak.
- Mobil öncelikli düşün, ama genel tasarım omurgası desktop/web genişlemesine de engel olmasın.
- Sade, hızlı, dikkat dağıtmayan üretkenlik aracı hissi ver.
- Offline kullanılabilirlik hissi net olmalı.
- E2EE / yerel şifreli kasa güven hissi vermeli ama kullanıcıyı korkutmamalı.
- Günlük kullanımda yoğun bilgiyi okunaklı göstermeli.
- Tek elle kullanım rahat olmalı.
- Swipe aksiyonları olabilir ama her swipe için görünür buton alternatifi de olmalı.
- Aşırı dekoratif gradient/orb, marketing hero, kart içinde kart ve gereksiz illüstrasyon kullanma.
- Faz 2/Faz 3 özelliklerini MVP ana ekranlarına şimdiden doldurma; bunun yerine yapının nasıl genişleyeceğini anlat.

Önce repo bağlamını kısaca özetle:
- Okuduğun dosyalar.
- MVP kapsamı.
- Faz 2 kapsamı.
- Faz 3 kapsamı.
- Tasarım için aldığın ana kararlar.

Sonra şu çıktıları üret:

1. Genel ürün tasarım omurgası
- Product design north star.
- Ürün tonu ve kişiliği.
- Light/dark tema stratejisi.
- E2EE, offline, sync ve AI gibi teknik kavramların kullanıcıya nasıl sade anlatılacağı.
- MVP’den Faz 2/Faz 3’e kırılmadan büyüyecek tasarım prensipleri.

2. Tasarım yönü
- 2 alternatif öner:
  - Quiet productivity
  - Customizable power-user light
- Her biri için renk, tipografi, spacing, ikon, yoğunluk ve hareket hissini anlat.
- Sonunda tek önerilen yönü seç ve nedenini açıkla.

3. Fazlara göre bilgi mimarisi ve navigasyon
- MVP mobil ana navigasyon modelini öner.
- Faz 2’ye geçince navigasyona hangi alanlar eklenir?
- Faz 3’e geçince AI, agent, API/webhook, görev ağacı ve oyunlaştırma yüzeyleri nerede konumlanır?
- Hangi şeyler ana navigasyonda, hangileri ayarlarda, hangileri detay ekranlarında veya command/input yüzeylerinde kalmalı?

4. MVP ana ekran spesifikasyonları
Her ekran için layout, ana bileşenler, primary/secondary aksiyonlar, state’ler ve mikro metinleri yaz:
- İlk açılış ve yerel şifreli kasa kurulumu
- Locked vault / kasa kilitli ekranı
- Bugün / günlük liste
- Yeni görev ekleme
- Görev detay ve alt görevler
- Zamanlama / tekrar kuralı düzenleme
- Havuz / zamansız görevler
- Takvim veya tarih seçici
- İstatistik özeti
- Ayarlar: gizlilik, export/import, tema, tamamlanan görev davranışı

5. Faz 2 genişleme notları
MVP tasarımı bozulmadan şu yüzeylerin nasıl ekleneceğini açıkla:
- Sync status
- Self-host/SaaS bağlantı ayarları
- Cihaz ekleme ve E2EE kurtarma akışı
- Multi-user, roller, aile/takım alanları
- Gelişmiş istatistik
- İleri tema sistemi ve topluluk temaları

6. Faz 3 genişleme notları
MVP ve Faz 2 tasarımı bozulmadan şu yüzeylerin nasıl ekleneceğini açıkla:
- AI komut girişi
- AI görev önerisi ve human-in-the-loop onay ekranı
- Görsel/ses girdisi
- Agent/plugin yönetimi
- API key ve webhook ayarları
- Görev ağacı / DAG görünümü
- Opsiyonel oyunlaştırma ve leaderboard

7. Durum tasarımları
Şunları ayrıca belirt:
- Empty
- Loading
- Offline
- Error
- Success
- Permission denied
- Locked vault
- Import error
- Metadata fetch failed
- Sync conflict future state
- AI suggestion pending future state

8. Component sistemi
Şu component’leri tanımla ve hangilerinin Faz 2/Faz 3’te nasıl genişleyeceğini yaz:
- Task row/card
- Priority/effort indicator
- Tag chip
- Recurrence badge
- Deadline warning
- Subtask row
- Bottom sheet form controls
- Calendar/date picker
- Settings rows/toggles
- Privacy/security status elements
- Sync status badge
- Role/member chip
- AI suggestion preview
- Task dependency node

9. Design tokens
Light ve dark tema için:
- Color tokens
- Typography scale
- Spacing scale
- Radius
- Shadow/elevation
- Divider kuralları
- Icon stili
- Density modes: default ve compact

10. Flutter uygulanabilirlik ve erişilebilirlik kontrolü
- Flutter ile uygulanması zor veya riskli olabilecek UI kararlarını işaretle.
- Ekran okuyucu, kontrast, büyük metin, tek elle kullanım ve erişilebilirlik notlarını ekle.
- Mobile-first tasarımın desktop/web’e nasıl uyarlanabileceğini kısaca belirt.

11. Repo çıktısı
Eğer repo içinde dosya oluşturabiliyorsan sonucu şuraya yaz:
docs/design/claude-v1/design-summary.md

Eğer görsel ekran export edebiliyorsan şu isimlerle kaydet:
- docs/design/claude-v1/screens/01-vault-setup.png
- docs/design/claude-v1/screens/02-today.png
- docs/design/claude-v1/screens/03-add-task.png
- docs/design/claude-v1/screens/04-task-detail.png
- docs/design/claude-v1/screens/05-repeat-editor.png
- docs/design/claude-v1/screens/06-settings.png
- docs/design/claude-v1/screens/07-phase-expansion-map.png

En sonda “Codex’e geri verilecek tasarım özeti” başlığı aç ve UX flow dokümanına aktarılması gereken kararları madde madde yaz.
```

## Claude ciktisini geri getirirken

Claude Design ciktisini su sekilde kaydetmek iyi olur:

- `docs/design/claude-v1/design-summary.md`
- `docs/design/claude-v1/screens/01-vault-setup.png`
- `docs/design/claude-v1/screens/02-today.png`
- `docs/design/claude-v1/screens/03-add-task.png`
- `docs/design/claude-v1/screens/04-task-detail.png`
- `docs/design/claude-v1/screens/05-repeat-editor.png`
- `docs/design/claude-v1/screens/06-settings.png`
- `docs/design/claude-v1/screens/07-phase-expansion-map.png`

Bu ciktidan sonra Codex'te sira:

1. `$ux-flow-planner` ile `docs/project/ux-flows.md` olusturmak.
2. Tasarim kararlarini teknik kisitlarla birlikte `$technical-design` dokumanina aktarmak.
3. Faz genisleme kararlarini `$data-permissions` dokumaninda roller, E2EE, sync, AI ve API izinleriyle eslestirmek.
4. Sonra `$implementation-plan`, `$test-plan`, `$launch-plan` sirasina devam etmek.
