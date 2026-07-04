# UX Flow: free-task

## 1. Kaynak Kapsam

| Alan | Karar |
| --- | --- |
| Durum | Dogrulanmis ve genisletilmis UX flow dokumani |
| Tarih | 2026-07-04 |
| Kaynak gerceklik | `docs/project/prd.md`, `docs/project/claude-design-brief.md` |
| Tasarim referansi | `docs/design/claude-v1/design-summary.md`, `docs/design/claude-v1/screens/`, prototip `.dc.html` dosyalari |
| MVP kapsami | Bireysel kullanici, mobil oncelikli Android+iOS, yerel sifreli kasa, offline kullanilabilir gorev yonetimi, import/export, basit istatistik, local bildirimler |
| Faz 2 kapsami | Self-host/SaaS sync, cihazlar arasi E2EE sync, multi-user, roller, gelismis import, gelismis istatistik, ileri tema sistemi |
| Faz 3 kapsami | AI, ses/gorsel girdi, human-in-the-loop onay, agent/plugin, API/webhooks, DAG, opsiyonel oyunlastirma |

Bu dokuman Claude tasarim teslimatindaki `docs/project/ux-flows.md` taslagini dogrular ve genisletir. PRD faz sinirlari korunur: MVP akislari detaylidir; Faz 2 ve Faz 3 akislari genisleme plani olarak islenir.

## 2. Karar Verilen Acik Konular

| Konu | Karar | UX Etkisi |
| --- | --- | --- |
| UI dili | Iki dilli: Turkce ve Ingilizce | Tum mikro metinler localization key mantigiyla tasarlanacak. Ilk acilista cihaz diliyle baslanir; Ayarlar'da dil degistirme bulunur. Turkce ve Ingilizce metin uzunluklari buton/satir tasariminda test edilir. |
| Yerel bildirimler | MVP'ye dahil | Hatirlaticilar tamamen cihaz ici ve opt-in olur. Bildirim izni reddedilirse gorev akislari kilitlenmez; uygulama icinde deadline/rutin uyarilari devam eder. |
| Kurtarma/parola modeli | Parola + biyometrik + kurtarma anahtari | Ilk kurulumda parola zorunlu, biyometrik opsiyonel, kurtarma anahtari zorunlu onay adimi olarak tasarlanir. Kurtarma anahtari kaydedilmeden onboarding tamamlanmaz veya kullanici riski acikca onaylar. |
| Platform onceligi | Android + iOS es zamanli | UX, platform paritesiyle tasarlanir. Biyometrik kopya platforma gore "Face ID / Touch ID / Biyometrik" olur; bildirim izni, dosya secici ve paylasim sheet'i iki platformda dogrulanir. |

## 3. Tasarim Paketi Bulgulari

Claude tarafindan uretilen tasarim paketi repo icine alinmistir:

- Ana tasarim ozeti: `docs/design/claude-v1/design-summary.md`
- Handoff haritasi: `docs/design/claude-v1/README-handoff.md`
- 36 PNG ekran: `docs/design/claude-v1/screens/`
- Flutter tema tokenlari: `docs/design/claude-v1/flutter/free_task_theme.dart`
- Kontakt foyu: `docs/design/claude-v1/contact-sheet.html`
- Prototipler: `free-task Prototype.dc.html`, `free-task Sync Prototype.dc.html`, `free-task AI Prototype.dc.html`, `free-task Design.dc.html`

Baglayici tasarim kararlari:

- Tasarim yonu: Quiet Productivity.
- Power-user ihtiyaci: ayarlardan acilan compact density.
- Navigasyon: alt bar 4 sekme (Bugun, Takvim, Havuz, Ayarlar) + merkez FAB.
- Guven dili: "Uctan uca sifreli · Yerel" ve "Verilerin bu cihazdan cikmiyor."
- Task row: tum fazlarda temel is birimi.
- AI: Faz 3'te komut yuzeyi ve human-in-the-loop onay karti; ana navigasyonu kirmaz.
- Sync: Faz 2'de ust bar rozeti ve Ayarlar bolumu; MVP cekirdek akisi offline calisir.

## 4. Personalar ve Giris Noktalari

| Persona/Rol | Giris Noktasi | Ana Hedef | Kisitlar |
| --- | --- | --- | --- |
| Bireysel kullanici / Owner | Ilk acilis, Bugun, bildirim, quick add | Gunluk gorevlerini hizli, guvenli ve offline kullanilabilir sekilde yonetmek | Hesap yok, yerel kasa, parola/kurtarma sorumlulugu kullanicida |
| Gelecek: Aile/takim owner | Workspace switcher, Ayarlar > Roller | Ortak alan ve uyeleri yonetmek | Faz 2, E2EE sync ve roller netlesmeden MVP'ye girmez |
| Gelecek: Takim uyesi | Atanan gorevler, workspace | Kendisine atanan gorevleri tamamlamak | Faz 2 |
| Gelecek: Power user / otomasyon kullanicisi | Komut cubugu, Ayarlar > Otomasyon | AI, API, webhook ve ajanlarla is akisini genisletmek | Faz 3, human-in-the-loop ve scope izinleri zorunlu |

## 5. Navigasyon Modeli

### 5.1 MVP Mobil Navigasyon

Alt bar 4 sekme + merkez FAB:

`Bugun` · `Takvim` · `+` · `Havuz` · `Ayarlar`

- **Bugun:** Ana ekran. Zaman bloklari, rutinler, deadline'lar ve tamamlanan davranisi burada gorulur.
- **Takvim:** Tarih secimi, gun/hafta/ay gorunumu ve gelecek/gecmis gorev kontrolu.
- **FAB:** Yeni gorev bottom sheet'i. NLP-first hizli ekleme.
- **Havuz:** Zamansiz gorevlerin tutuldugu alan.
- **Ayarlar:** Gizlilik, kasa, dil, bildirimler, gorunum, import/export.

Istatistik MVP'de ayri alt bar sekmesi degildir; Bugun ust barindaki ikon ve ozet ciplerinden acilir.

### 5.2 Faz 2 Navigasyon Genislemesi

- Alt bar ayni kalir.
- Baslik alanina workspace switcher eklenir: Kisisel / Aile / Takim.
- Ust barda sync rozeti belirir: guncel, bekliyor, hata, offline.
- Ayarlar'a Sync, Cihazlar, Sunucu Baglantisi, Kurtarma Anahtari, Roller & Uyeler bolumleri eklenir.

### 5.3 Faz 3 Navigasyon Genislemesi

- AI ayri ana sekme olmaz.
- FAB'a basili tutma veya "/" komutu AI/komut cubugunu acar.
- Agent/plugin, API key ve webhook ayarlari Ayarlar > Otomasyon altinda yer alir.
- Gorev agaci/DAG, gorev detayindan veya opsiyonel agac gorunumunden acilir.
- Oyunlastirma Istatistik icinde opt-in katman olarak kalir.

## 6. Akis Envanteri

| ID | Akis | Faz | Ilgili ekran/prototip |
| --- | --- | --- | --- |
| F1 | Ilk acilis ve kasa kurulumu | MVP | 01, 16 |
| F2 | Uygulama kilidi acma | MVP | 09 |
| F3 | Gorev olusturma ve zamanlama | MVP | 03, 05 |
| F4 | Gorev tamamlama, duzenleme ve detay | MVP | 02, 04 |
| F5 | Havuzdan bugune cekme | MVP | 10, 02 |
| F6 | Takvimde gezinme | MVP | 11 |
| F7 | Istatistik goruntuleme | MVP | 08 |
| F8 | Ayarlar, dil, tema, bildirim, export/import | MVP | 06 |
| F9 | Yerel bildirim ve hatirlatici davranisi | MVP | 03, 06, 12 |
| F10 | Sync kurulumu ve cihaz ekleme | Faz 2 | 14, 15, 17, Sync Prototype |
| F11 | Kurtarma anahtari yonetimi | Faz 2/MVP onboarding | 16 |
| F12 | Ekip alani ve gorev atama | Faz 2 | 18, 19 |
| F13 | Sync cakisma cozumu | Faz 2 | 22 |
| F14 | AI komut, oneriler ve onay | Faz 3 | 24, 25, 33, AI Prototype |
| F15 | Ses/gorsel ile gorev onerisi | Faz 3 | 26, 27 |
| F16 | Otomasyon, API, webhook, agent/plugin | Faz 3 | 28, 29, 30 |
| F17 | Gorev bagimliliklari ve DAG | Faz 3 | 31 |

## 7. Birincil MVP Akisi

1. Kullanici uygulamayi ilk kez acar.
2. UI dili cihaz dilinden secilir; desteklenen diller Turkce ve Ingilizcedir. Kullanici bunu Ayarlar'da degistirebilir.
3. Kullanici yerel sifreli kasayi kurar: parola, parola tekrar, opsiyonel biyometrik, kurtarma anahtari kaydetme.
4. Kasa acildiktan sonra Bugun ekrani gorulur.
5. Kullanici FAB ile yeni gorev ekler.
6. NLP input tarih/saat/tekrar/deadline ipuclari uretir; kullanici onaylar veya duzenler.
7. Gorev uygun yere duser: Bugun, Takvim veya Havuz.
8. Kullanici gorevi tamamlar, erteler, arsivler, detayina girer veya alt gorevleri yonetir.
9. Tamamlama ve rutin verileri yerel istatistiklere yansir.
10. Hatirlatici gerekiyorsa yerel bildirim izni istenir; izin verilmezse uygulama ici uyarilar devam eder.

## 8. MVP Akislari

### F1 · Ilk Acilis ve Yerel Sifreli Kasa Kurulumu

**Amac:** Hesap veya sunucu gerektirmeden kullanicinin yerel sifreli kasasini kurmak.

**Giris:** Uygulama ilk kez acilir, yerel kasa yoktur.

**Adimlar:**

1. Kullanici ilk acilis ekraninda "free-task" ve "Uctan uca sifreli · Yerel" mesajini gorur.
2. Uygulama cihaz dilini algilar; Turkce/English desteklenir. Ilk ekranda dil degistirme kisa yolu bulunur.
3. Kullanici parola ve parola tekrar alanlarini doldurur.
4. Parola gucu ve eslesme inline gosterilir.
5. Cihaz destekliyorsa biyometrik toggle gosterilir.
6. Kullanici kurtarma anahtari adimina gecer.
7. 12 bloklu kurtarma anahtari gosterilir; kullanici kopyalar veya guvenli yere kaydeder.
8. Kullanici anahtar dogrulamasini tamamlar veya riski acikca onaylar.
9. Kasa olusturulur; loading state "Kasa aciliyor..." seklindedir.
10. Basariyla Bugun ekranina gecilir.

**Hata ve kenar durumlari:**

- Parolalar eslesmezse devam pasif kalir.
- Parola zayifsa kullanici uyarilir; minimum guvenlik esigi teknik tasarimda netlesir.
- Biyometrik yoksa toggle gizlenir.
- Kurtarma anahtari kaydedilmeden gecme, acik risk onayi ister.
- Kurulum yarida kesilirse sonraki acilista kasa olusmadiysa bastan baslar.

**Kabul kriterleri:**

- Kullanici kasayi kurmadan gorev icerigi kalici depoya yazilmaz.
- UI dili Turkce ve Ingilizce degistirilebilir.
- Kurtarma anahtari akisi parola unutma riskini net anlatir.

### F2 · Uygulama Kilidi Acma

**Giris:** Uygulama acilir veya otomatik kilit sonrasi kasa kilitlidir.

**Adimlar:**

1. Locked vault ekraninda kilit ikonu, parola alani ve biyometrik acma butonu gorulur.
2. Biyometrik basariliysa Bugun ekranina gecilir.
3. Biyometrik iptal/basarisizsa parola alanina donulur.
4. Parola dogruysa kasa acilir.
5. "Kurtarma secenekleri" kullaniciyi kurtarma anahtari akisiyle devam ettirir.

**Hata ve kenar durumlari:**

- Yanlis parola yikici mesaj vermez; artan bekleme uygulanabilir.
- Biyometrik ayar degistiyse parola zorunlu olur.
- Kurtarma anahtari yoksa kullaniciya verinin kurtarilamayacagi net anlatilir.

### F3 · Gorev Olusturma ve Zamanlama

**Giris:** Kullanici herhangi bir sekmede merkez FAB'a dokunur.

**Adimlar:**

1. Bottom sheet acilir; imlec NLP input alanindadir.
2. Kullanici gorev basligini veya dogal dil ifadesini yazar.
3. Yerel parser tarih, saat, deadline, tekrar veya etiket ipuclarini algilar.
4. Algilanan degerler duzenlenebilir cip olarak gosterilir.
5. Kullanici zamanlama tipini secer: zaman aralikli, zamansiz, tekrar eden, deadline.
6. Tekrar secilirse tekrar kuralı editoru acilir.
7. Kullanici oncelik, etiket, alt gorev, not, link ve opsiyonel hatirlatici ekler.
8. "Ekle" ile gorev kaydedilir.
9. Basari toast'i gosterilir: "Gorev eklendi · Geri al".

**Yerel bildirim karari:**

- Hatirlatici alanlari MVP'ye dahildir.
- Bildirim izni ilk gorevde degil, kullanici ilk hatirlatici eklediginde istenir.
- Bildirimler cihaz icidir; uzaktan push yoktur.
- Izin reddedilirse gorev kaydedilir, sadece bildirim kurulmaz.

**Hata ve kenar durumlari:**

- NLP algilayamazsa manuel alanlar kullanilir.
- Tekrar kuralı gecersizse kaydet pasif kalir.
- Link metadata offline ise sonradan denenebilir; gorev kaydi engellenmez.

### F4 · Gorev Tamamlama, Duzenleme ve Detay

**Giris:** Bugun, Takvim veya Havuz listesinde bir task row.

**Adimlar:**

1. Checkbox'a dokunulunca gorev tamamlanir.
2. Sayaç, rutin uyumu ve istatistikler yerel olarak guncellenir.
3. Toast "Gorev tamamlandi · Geri al" gosterir.
4. Satira dokununca detay ekrani acilir.
5. Detayda alt gorevler, not, link, zamanlama, tekrar, deadline ve hatirlatici gorulur.
6. Kullanici Tamamla, Ertele, Arsivle, Duzenle aksiyonlarini kullanir.

**Erisilebilirlik:**

- Swipe aksiyonlarinin buton alternatifi vardir.
- Checkbox hit area en az 44x44 px olur.
- Tamamlandi/tamamlanmadi durumu ekran okuyucuya okunur.

### F5 · Havuzdan Bugune Cekme

**Giris:** Kullanici Havuz sekmesine gider.

**Adimlar:**

1. Zamansiz gorevler etiket/oncelik/olusturma tarihine gore listelenir.
2. Kullanici "Bugune cek" butonunu veya swipe aksiyonunu kullanir.
3. Gorev bugunun listesine eklenir.
4. Toast "Bugune alindi · Geri al" gosterir.

**Kenar durum:** Havuz bos ise empty state "Havuz bos. Zamansiz fikirler burada birikir." gosterilir.

### F6 · Takvimde Gezinme

**Giris:** Kullanici Takvim sekmesine gider.

**Adimlar:**

1. Ay veya hafta gorunumu acilir.
2. Gun hucresindeki noktalar o gunde gorev oldugunu gosterir.
3. Deadline'li veya gecikmis gorevler semantik uyarilarla ayrisir.
4. Kullanici gun secer; altta secili gunun gorevleri listelenir.
5. Goreve dokunmak F4 detay akisini acar.

**Erisilebilirlik:** Tarih hucresi buton gibi okunur: "5 Temmuz, 3 gorev, 1 deadline".

### F7 · Istatistik Goruntuleme

**Giris:** Bugun ust barindaki istatistik ikonu veya ozet cipleri.

**Adimlar:**

1. Kullanici istatistik ozetini acar.
2. Tamamlanan gorev, seri ve rutin uyumu gorulur.
3. Basit haftalik bar veya heatmap yerel veriden hesaplanir.
4. Yeterli veri yoksa bos durum gosterilir.

**Kenar durum:** Istatistikler cihaz icinde hesaplanir; uzaktan telemetry varsayilan olarak yoktur.

### F8 · Ayarlar, Dil, Tema, Bildirim, Export/Import

**Giris:** Ayarlar sekmesi.

**Bolumler:**

- Gizlilik & Guvenlik: kasa, parola, biyometrik, otomatik kilit, kurtarma anahtari.
- Dil: Turkce, English, Sistem dili.
- Bildirimler: yerel hatirlaticilar, izin durumu, sessiz saatler.
- Gorunum: light/dark/system, density default/compact, tamamlanan gorev davranisi.
- Veri: JSON/Markdown export, free-task JSON import.

**Hata ve kenar durumlari:**

- Dosya izni reddedilirse izin neden gerekir aciklanir.
- Import hataliysa sorunlu satir/alan gosterilir, mevcut veri bozulmaz.
- Dil degisimi uygulama yeniden baslatmadan uygulanmalidir; teknik risk varsa teknik tasarimda belirtilir.

### F9 · Yerel Bildirim ve Hatirlatici Davranisi

**Giris:** Kullanici gorev olustururken veya detayda hatirlatici ekler.

**Adimlar:**

1. Kullanici "Hatirlatici" satirini acar.
2. Zaman secilir: gorev saatinde, X dakika once, ozel saat veya rutinle birlikte.
3. Uygulama ilk kez izin gerekiyorsa izin aciklamasini gosterir.
4. Sistem izin dialogu acilir.
5. Izin verildiyse local notification planlanir.
6. Izin reddedildiyse gorev kaydedilir ve uygulama ici uyarilar korunur.

**Prensipler:**

- Hatirlaticilar opt-in'dir.
- Varsayilan bildirim bombardimani yoktur.
- Offline ve hesap olmadan calisir.
- Faz 2'de sync ile cihazlar arasi bildirim cakismaalari teknik tasarimda ele alinacaktir.

## 9. Faz 2 Akislari

### F10 · Sync Kurulumu ve Cihaz Ekleme

**Tetik:** Ayarlar > Senkronizasyon.

**Adimlar:**

1. Kullanici mod secer: Yalnizca yerel, Self-host, SaaS.
2. Self-host/SaaS icin sunucu URL veya hesap baglantisi girilir.
3. Baglanti testi TLS, latency ve surum uyumunu kontrol eder.
4. Sync durumu ekrani cihazlari ve son senkron zamanini gosterir.
5. Yeni cihaz ekleme QR veya manuel kodla baslar.
6. E2EE el sıkışması tamamlanir.
7. Yeni cihaz listeye eklenir.

**Degismez ilke:** Sunucu plaintext gorev icerigi gormez.

### F11 · Kurtarma Anahtari Yonetimi

**Tetik:** Onboarding veya Ayarlar > Kurtarma anahtari.

**Adimlar:**

1. Kullanici 12 bloklu kurtarma anahtarini gorur.
2. Kopyalama, yazdirma veya guvenli yerde saklama onerilir.
3. Dogrulama adimi anahtar bloklarini tekrar yazdirir.
4. Kayip anahtar/parola riski net anlatilir.

**MVP iliskisi:** Kurtarma anahtari onboarding'de de vardir. Faz 2'de cihazlar arasi kurtarma ve sync el sıkışmasıyla genisler.

### F12 · Ekip Alani ve Gorev Atama

**Tetik:** Faz 2 workspace ozelligi etkin.

**Adimlar:**

1. Kullanici basliktaki workspace switcher ile Kisisel/Aile/Takim alanini secer.
2. Roller & Uyeler ekraninda owner/admin/member/viewer rolleri gorulur.
3. Gorev detayinda veya task row'da "Ata" aksiyonu kullanilir.
4. Atanan kullanici avatar cipiyle task row'da gorunur.

**Kenar durum:** Kisisel alan varsayilan ve tam offline kalir.

### F13 · Sync Cakisma Cozumu

**Tetik:** Ayni gorev iki cihazda farkli sekilde degisir.

**Adimlar:**

1. Sync rozeti hata/cakisma durumunu gosterir.
2. Cakisma ekraninda iki surum yan yana gorulur.
3. Kullanici "Bu surumu tut", "Digerini tut" veya "Ikisini de tut" secer.
4. Cozumden sonra sync yeniden denenir.

## 10. Faz 3 Akislari

### F14 · AI Komut, Oneriler ve Onay

**Tetik:** FAB'a basili tutma veya "/" komutu.

**Adimlar:**

1. Komut yuzeyi acilir: metin, ses ve gorsel modlari.
2. Kullanici planlama veya gorev olusturma istegi yazar.
3. AI onerileri kesikli kenarlikli onerı kartlari olarak gelir.
4. Kullanici her oneriyi reddeder, duzenler veya onaylar.
5. Yalnizca onaylanan gorevler listeye kalici yazilir.

**Degismez ilke:** Onaylanmayan AI ciktilari sayimlara girmez ve kalici gorev olmaz.

### F15 · Ses/Gorsel ile Gorev Onerisi

**Adimlar:**

1. Kullanici ses veya gorsel girdi modunu acar.
2. Izin gerekiyorsa permission state gosterilir.
3. Girdi cihazda veya kullanici tarafindan secilen saglayici sinirlarinda islenir.
4. Cikti F14 onay akisine duser.

### F16 · Otomasyon, API, Webhook, Agent/Plugin

**Tetik:** Ayarlar > Otomasyon.

**Adimlar:**

1. Kullanici agent/plugin listesini gorur.
2. Her ajan scope cipleri, etkin/pasif durumu ve audit log ile gosterilir.
3. API key olusturma scope secimiyle yapilir.
4. Webhook endpoint ve event abonelikleri eklenir.

**Prensip:** Hicbir ajan varsayilan otonom degildir; kullanici izni ve scope olmadan arac tetikleyemez.

### F17 · Gorev Bagimliliklari ve DAG

**Tetik:** Gorev detayinda Bagimliliklar veya agac gorunumu.

**Adimlar:**

1. Kullanici goreve bagimli onceki/sonraki gorevleri gorur.
2. Tamamlanmayan on kosullar kilitli node olarak gosterilir.
3. Node'a dokunmak ilgili gorev detayini acar.
4. Buyuk projelerde tam ekran agac gorunumu kullanilir.

## 11. Ekran Envanteri

| Ekran | Faz | Amac | Birincil Aksiyonlar | Veri | Durumlar |
| --- | --- | --- | --- | --- | --- |
| Kasa kurulumu | MVP | Yerel sifreli kasa olusturmak | Parola gir, biyometrik ac, kurtarma anahtari kaydet | LocalVault, security metadata | loading, error, success |
| Locked vault | MVP | Kasayi acmak | Biyometrik, parola, kurtarma | LocalVault | error, locked, permission |
| Bugun | MVP | Gunluk gorevleri yonetmek | Tamamla, ekle, detay, ertele | Task, CompletionEvent | empty, offline, success, error |
| Yeni gorev | MVP | Gorev eklemek | NLP input, zamanlama, hatirlatici, kaydet | Task, RecurrenceRule, Reminder | loading, validation error |
| Gorev detay | MVP | Gorevi ve alt gorevleri yonetmek | Tamamla, ertele, arsivle, duzenle | Task, Subtask, LinkPreview | metadata error, deadline warning |
| Tekrar editoru | MVP | Rutin kuralı kurmak | Frekans sec, gun sec, kaydet | RecurrenceRule | invalid rule, preview |
| Havuz | MVP | Zamansiz gorevleri toplamak | Bugune cek, filtrele | Task | empty, success |
| Takvim | MVP | Tarihe gore gorev gormek | Gun sec, bugune don | Task, RecurrenceRule | empty, dense day |
| Istatistik | MVP | Yerel trendleri gormek | Donem sec | CompletionEvent | insufficient data |
| Ayarlar | MVP | Gizlilik, dil, tema, veri | Dil degistir, export/import, bildirim ayarla | Preferences, Vault settings | permission, import error |
| Sync durumu | Faz 2 | Senkronu yonetmek | Senkronla, cihaz ekle | Device, SyncState | offline, conflict |
| Roller & uyeler | Faz 2 | Paylasimli alan yonetmek | Davet, rol degistir | User, Role, Workspace | permission denied |
| AI komut | Faz 3 | AI ile oneri uretmek | Komut yaz, onayla | AISuggestion | pending, error |
| Otomasyon/API | Faz 3 | Agent ve webhook yonetmek | Token olustur, scope sec | APIKey, Webhook, Agent | permission, rate limit |
| DAG | Faz 3 | Bagimli gorevleri gormek | Node sec, bagimlilik ekle | TaskDependency | locked, empty |

## 12. Durum Matrisi

| Ekran/Aksiyon | Loading | Empty | Error | Success | Permission |
| --- | --- | --- | --- | --- | --- |
| Kasa kurulumu | Kasa olusturuluyor | Yok | Parola eslesmiyor, zayif parola | Kasa olusturuldu | Biyometrik yok/kapali |
| Locked vault | Kasa aciliyor | Yok | Parola hatali | Kasa acildi | Biyometrik reddedildi |
| Bugun | Skeleton task row | Bugun gorev yok | Veri okunamadi, verilerin guvende | Gorev tamamlandi | Bildirim izni gerekli degil |
| Yeni gorev | Link metadata deneniyor | Yok | Gecersiz tekrar kuralı | Gorev eklendi | Bildirim/dosya izni reddedildi |
| Gorev detay | Link yukleniyor | Alt gorev yok | Metadata alinamadi | Guncellendi | Medya/dosya izni |
| Takvim | Gunler hesaplanıyor | Secili gun bos | Tekrar hesaplama hatasi | Tarih secildi | Yok |
| Istatistik | Grafik hesaplanıyor | Yeterli veri yok | Istatistik okunamadi | Donem degisti | Yok |
| Ayarlar export/import | Dosya hazirlaniyor | Yok | Import satir hatasi | Export alindi | Dosya izni reddedildi |
| Bildirim kurma | Hatirlatici planlaniyor | Yok | Zaman gecmis/gecersiz | Bildirim kuruldu | Bildirim izni reddedildi |
| Sync | Senkronlanıyor | Cihaz yok | Cakisma/baglanti hatasi | Guncel | Workspace yetkisi |
| AI onay | Oneriler uretiliyor | Oneri yok | Saglayici/izin hatasi | Oneri onaylandi | Mikrofon/kamera/AI scope |

## 13. Responsive ve Erisilebilirlik Gereksinimleri

- Dokunma hedefleri en az 44x44 px.
- Swipe aksiyonlarinin gorunur buton alternatifi bulunur.
- Buyuk metinde task row sarilabilir; metin kesilmez.
- Turkce ve Ingilizce metin uzunluklari icin butonlarda esnek genislik ve satir davranisi kullanilir.
- Ekran okuyucu etiketleri buton, checkbox, tarih hucresi ve task row durumlarini aciklar.
- Light/dark tema WCAG AA kontrast hedefini korur.
- Android ve iOS icin sistem izin akislari ayri test edilir.
- Local bildirimler izin reddinde alternatif uygulama ici uyariyla desteklenir.
- Desktop/web genislemesinde alt bar sol rail'e, bottom sheet sag panele donusebilir.

## 14. UX Riskleri ve Oneriler

| Risk | Etki | Oneri |
| --- | --- | --- |
| E2EE/kurtarma metni kullaniciyi korkutabilir | Onboarding terk edilir | Teknik terimi insan diliyle esle: "Verilerin bu cihazdan cikmiyor"; risk kutusunu kisa ve net tut |
| Kurtarma anahtari adimi fazla surtunme yaratabilir | Ilk kurulum uzar | Anahtar kaydetme zorunlu/erteleme karari teknik tasarimda risk odakli netlesmeli; erteleme varsa tekrar hatirlat |
| Iki dilli UI butonlari tasarimi bozabilir | Tasarim paritesi bozulur | Localization key ve en uzun EN/TR metinlerle UI testleri planla |
| Bildirim izni erken istenirse reddedilir | Hatirlatici kullanimi duser | Izin sadece kullanici ilk hatirlatici kurarken istenir |
| AI yuzeyleri ana deneyimi sisirebilir | MVP sadeligi bozulur | AI yalnizca Faz 3 command/input yuzeyi ve onay karti olarak kalir |
| Sync, offline ilkesini zedeleyebilir | Guven kaybi | Sync opt-in olur; offline cekirdek asla kilitlenmez |

## 15. Acik UX Sorulari

Bu turda README §6 sorulari cevaplandi ve dokumana islenmistir. Kalan UX sorulari teknik tasarima devredilir:

- Kurtarma anahtari kaydetmeden devam tamamen engellenecek mi, yoksa risk onayi ile ertelenebilecek mi?
- Parola minimum guvenlik esigi ne olacak?
- Yerel bildirimlerde varsayilan sessiz saatler olacak mi?
- Iki dilli ilk surumda uygulama ici metinlerin kaynak dili Turkce mi Ingilizce mi tutulacak?
- Desktop/web genislemesi MVP build kapsamina girecek mi, yoksa sadece tasarim uyumu mu korunacak?

## 16. Teknik Tasarima Handoff

`$technical-design` asagidaki UX kararlarini baglayici girdi olarak almalıdır:

- Platform: Android + iOS es zamanli, Flutter/Dart aday stack.
- UI dili: Turkce + Ingilizce, runtime dil degistirme ve sistem dili varsayilani.
- Local notification: MVP'de opt-in, cihaz ici, uzaktan push yok.
- Kasa modeli: parola + opsiyonel biyometrik + kurtarma anahtari.
- Navigasyon: alt bar 4 sekme + merkez FAB; Faz 2/3 omurga bozulmaz.
- E2EE/offline dili ve durumlari: UI copy ve veri modeli birlikte tasarlanmalı.
- Token kaynagi: `docs/design/claude-v1/flutter/free_task_theme.dart`.
- Gorsel referans: 36 PNG ekran ve 4 prototip HTML.
- Faz 2/3 ekranlari tasarim referansi olarak vardir; ancak uygulama planinda faz sinirlari korunmalıdır.

Sonraki adim: `$technical-design` ile mimari, veri katmani, sifreleme, local notification, localization, Flutter tema entegrasyonu ve fazlara gore moduler genisleme tasarimi.
