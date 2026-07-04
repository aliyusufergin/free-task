# PRD: free-task

## 1. Dokuman Bilgisi

| Alan | Deger |
| --- | --- |
| Durum | Taslak / Onay bekliyor |
| Sahip | Ali Yusuf Ergin |
| Tarih | 2026-07-04 |
| Hedef surum | MVP |
| Kaynak konusma/kapsam | Kullanici fikri, duzenlenmis ozellik listesi ve 2026-07-04 kapsam kararları |
| GitHub repo | https://github.com/aliyusufergin/free-task |

## 2. Yonetici Ozeti

free-task, once bireysel kullanim icin tasarlanan, mobil oncelikli, cok platformlu ve gizlilik odakli bir gorev/rutin yonetim uygulamasidir. Urunun ilk surumu, kullanicinin internet baglantisi olmasa bile gunluk gorevlerini, rutinlerini, alt gorevlerini, tekrarlarini, zamanlamalarini ve arsivini guvenilir sekilde yonetmesini hedefler.

Uygulama "populer olmak" icin degil, sahibinin gercek ihtiyacina cevap veren sade bir uretkenlik araci olarak baslayacaktir. Baskalari kullanirsa kullanir ilkesi korunur; bu nedenle ilk urun kararlarinda veri ozgurlugu, yerel kontrol, sade arayuz ve guvenilirlik ticari buyume hedeflerinin onune konur.

MVP, self-host senkronizasyonu, SaaS, coklu kullanici, kapsamli AI ajanlari ve liderlik tablosu gibi buyuk platform ozelliklerini kapsamaz. Ancak mimari, bu ozelliklerin ileride eklenebilmesi icin veri modeli, sifreleme sinirlari ve moduler yapi acisindan hazirlanir.

## 3. Problem Tanimi

### Mevcut Durum

Kullanici, gorevlerini ve rutinlerini farkli araclarla takip edebilir: basit not uygulamalari, takvimler, Todoist benzeri SaaS urunleri, Linear/Jira gibi is odakli araclar veya yerel todo uygulamalari. Bu araclarin bir kismi gereksiz karmasik, bir kismi gizlilik acisindan fazla bulut bagimli, bir kismi da cevrimdisi kullanim ve uzun vadeli veri tasima konusunda zayiftir.

### Kullanici Acisi

- Gorev verisinin tamamen kullanicinin kontrolunde olmamasi.
- Internet olmadiginda temel kullanim deneyiminin bozulmasi.
- Rutin, tekrar eden gorev, deadline ve zamansiz gorevlerin tek yerde sadece yonetilememesi.
- AI ozelliklerinin gizlilik ve kontrol kaybi yaratmasi.
- Kisisellestirme isteyince uygulamanin ya cok sinirli ya da gereksiz karmasik olmasi.
- Uygulamadan ayrilmak istendiginde veriyi temiz ve acik formatta disari alamama.

### Neden Simdi

Kisisel uretkenlik araclari yaygin olsa da gizlilik, yerel calisma, acik kaynak/self-host vizyonu ve AI entegrasyonlarini ayni anda kullanici kontrolunde tutan sade bir urun alani hala guclu bir firsat sunuyor. free-task, once tek kullanicinin gercek kullanimindan dogan bir cekirdek deneyim kuracak; sonra bu temelin uzerine senkronizasyon, self-host, AI ve ajan katmanlari eklenecektir.

## 4. Hedefler ve Basari Metrikleri

| Hedef | Metrik | Basari Esigi | Olcum Yontemi |
| --- | --- | --- | --- |
| Gunluk kullanimda guvenilir olmak | Gunluk gorev ekleme/tamamlama akisi | Kullanici 14 gun boyunca ana akislari veri kaybi olmadan kullanabilir | Yerel dogfooding notlari, hata kayitlari |
| Offline kullanilabilirlik saglamak | Internet yokken calisan cekirdek ozellikler | Gorev CRUD, takvim/gun listesi, tekrar hesaplama, arama ve export internet olmadan calisir | Manuel offline test senaryolari |
| Gizliligi urun kapisi yapmak | Sifrelenmemis hassas veri sızıntısı | Gorev icerigi, notlar ve exportlar varsayilan olarak sifreleme politikasina uyar | Guvenlik checklist'i, kod incelemesi |
| Sade ama yeterince guclu MVP uretmek | Ilk surum kapsam disiplini | Faz 2/3 ozellikleri MVP teslimini bloke etmez | PRD ve implementation plan kontrolu |
| Veri ozgurlugu saglamak | Import/export calisirligi | Kullanici verisini JSON ve Markdown formatinda disari alabilir | Manuel test, otomasyon testi |

## 5. Hedef Disi Konular

- MVP'de SaaS urunu yayinlamak.
- MVP'de self-host senkronizasyon sunucusu sunmak.
- MVP'de aile/takim rolleri ve coklu kullanici destegi vermek.
- MVP'de bulut AI servisleriyle otomatik planlama yapmak.
- MVP'de otonom ajan/plugin sistemi kurmak.
- MVP'de liderlik tablosu veya rekabet odakli oyunlastirma yapmak.
- MVP'de public marketing sitesi, odeme sistemi veya buyume hunisi kurmak.
- MVP'de webhooks, public API veya GraphQL/REST platformu sunmak.

## 6. Kullanicilar, Personalar ve Roller

| Rol/Persona | Ihtiyac | Yetkiler | Notlar |
| --- | --- | --- | --- |
| Bireysel kullanici / Owner | Kendi gorevlerini, rutinlerini ve gunluk planini yonetmek | Tum yerel veriyi olusturur, duzenler, siler, export eder, sifreleme ayarlarini yonetir | MVP'nin birincil personasidir |
| Gelecek: Aile/takim admini | Ortak ve kisiye ozel gorev atamak | Kullanici, grup, rol, ortak gorev ve izin yonetimi | Faz 2 |
| Gelecek: Aile/takim uyesi | Kendisine atanan gorevleri gormek ve tamamlamak | Kendi gorevlerini tamamlar, belirli alanlari duzenler | Faz 2 |
| Gelecek: Entegrasyon/API kullanicisi | Harici araclarla otomasyon yapmak | API token, webhook, event abonelikleri | Faz 3 |

## 7. Mevcut Baglam ve Tasarim Paketi Bulgulari

### Repo/Urun Baglami

- Calisma klasoru baslangicta bos proje alani olarak gorundu.
- Yerel klasor ilk kontrolde Git reposu olarak hazir degildi.
- Kullanici GitHub reposunu web uzerinden olusturdu: `aliyusufergin/free-task`.
- Mevcut uygulama kodu, README, paket yonetimi, CI veya framework dosyasi bulunmadi.

### Tasarim Paketi veya UI Sistemi

- Mevcut tasarim paketi, UI kit, marka rehberi, logo, tema token dosyasi veya component sistemi bulunmadi.
- Ilk tasarim kararlari PRD ve sonraki UX flow dokumaninda belirlenecek.

### Tasarim Kararlari

- Ton: sade, hizli, dikkat dagitmayan uretkenlik araci.
- Ozellestirme: MVP'de light/dark tema ve temel gorunum tercihleri; topluluk temalari ve ileri tema sistemi sonraki faz.
- Platform onceligi: mobil cihazlarda rahat kullanim. Masaustu ve web hedefleri teknik tasarimda dogrulanacak, ancak MVP tasarimi mobil oncelikli olacak.

## 8. Kapsam

### MVP Kapsami

1. Mobil oncelikli cok platformlu uygulama temeli.
2. Yerel, sifreli veri deposu.
3. Offline kullanilabilir cekirdek gorev yonetimi.
4. Gorev CRUD: ekleme, duzenleme, silme, arsivleme.
5. Gorev detaylari: baslik, aciklama, not, link, medya referansi, onem/zorluk, etiket.
6. Alt gorevler.
7. Zamanlama tipleri:
   - Gun/saat aralikli gorev.
   - Zamansiz/havuz gorevi.
   - Tekrar eden rutin.
   - Deadline'li ve tamamlanana kadar gorunen gorev.
8. Mobil hizli aksiyonlar: tamamla, ertele, arsivle.
9. Gunluk liste ve basit takvim gorunumu.
10. Tamamlanan gorevleri gizleme veya ustu cizili gosterme ayari.
11. Basit istatistikler: tamamlanan gorev sayisi, seri, rutin uyumu.
12. Veri export: JSON ve Markdown.
13. Veri import: free-task JSON; diger araclar icin sonraki faza hazir import altyapisi.
14. Yerel dogal dil tarih/saat ayrishtirma: "yarin 15:00" gibi basit girdiler.
15. Link yapistirildiginda kullanici onayi ile baslik/metadata cekme. Offline veya hata durumunda link ham haliyle saklanir.
16. Yerel bildirimler: deadline ve rutin hatirlaticilari icin opt-in, cihaz ici local notifications.

### Sonraki Faz

**Faz 2 - Senkronizasyon ve paylasimli kullanim**

- Self-host senkronizasyon sunucusu.
- Docker Compose ile kolay kurulum.
- SaaS alternatifi.
- Multi-user, roller ve yetkilendirme.
- Cihazlar arasi E2EE senkronizasyon.
- Daha guclu import: Todoist, Apple Reminders, Linear vb.
- Kapsamli istatistik paneli.
- Ileri tema sistemi ve topluluk temalari.

**Faz 3 - AI, ajanlar ve platformlasma**

- Bulut AI saglayicilari: OpenAI, Anthropic vb.
- Lokal AI: Ollama, llama.cpp vb.
- AI destekli planlama, sesli komut, gorsel analiz.
- Human-in-the-loop onayli AI gorev olusturma.
- Agent/plugin altyapisi.
- Ozellestirilebilir system prompt ve kullanici baglam penceresi.
- REST/GraphQL API, webhooks, otomasyon entegrasyonlari.
- Gorev agaci / DAG / skill-tree gorunumu.
- Opsiyonel oyunlastirma, puan ve leaderboard.

### Kapsam Disi

- Ilk surumda buyume, reklam, odeme veya enterprise satis altyapisi.
- Ilk surumda uzaktan veri saklama.
- Ilk surumda AI'nin kullanici verisini harici modele gondermesi.
- Ilk surumda takim/aile rekabeti veya sosyal ozellikler.

## 9. Kullanici Akislari

### Birincil Akis

1. Kullanici uygulamayi acar.
2. Ilk acilista lokal kasa/sifreleme kurulumu yapar.
3. Gunluk liste ekraninda bugunun gorevlerini gorur.
4. Yeni gorev ekler veya hizli giris alanina dogal dille basit bir ifade yazar.
5. Uygulama tarihi/saat araligini yerel olarak onerir.
6. Kullanici oneriyi onaylar veya duzenler.
7. Gorev listede dogru bolumde gorunur.
8. Kullanici gorevi tamamlar, erteler, duzenler veya arsivler.
9. Tamamlama ve rutin istatistikleri yerel olarak guncellenir.

### Alternatif Akislar

- Kullanici zamansiz gorev ekler; gorev "Havuz" gorunumunde kalir.
- Kullanici tekrar eden rutin kurar; uygulama ilgili gunlerde yeni ornekleri gosterir.
- Kullanici deadline'li gorev ekler; tamamlanana kadar gunluk listede gorunur.
- Kullanici alt gorev ekler; ana gorevin tamamlanma durumu alt gorevlerle iliskili hesaplanir.
- Kullanici internet yokken link ekler; metadata daha sonra istege bagli cekilir.
- Kullanici export alir; dosya sifreli veya acik format olarak secilebilir.

### Hata ve Geri Donus Akislari

- Sifre/kasa acilamadi: kullaniciya kurtarma secenekleri ve veri kaybi riski acikca gosterilir.
- Import basarisiz: hangi satir/alanin sorunlu oldugu raporlanir, mevcut veri bozulmaz.
- Tekrar kuralı hatali: uygulama kuralı kabul etmez ve duzeltilebilir alanlari gosterir.
- Link metadata cekilemedi: gorev kaydi basarisiz olmaz, sadece metadata bos kalir.
- Cihaz tarihi/saat dilimi degisti: gorevlerin yerel timezone davranisi korunur ve riskli tekrarlar kullaniciya bildirilir.

## 10. Fonksiyonel Gereksinimler

| ID | Oncelik | Gereksinim | Aciklama | Kabul Kriterleri |
| --- | --- | --- | --- | --- |
| FR-001 | Must | Yerel sifreli kasa kurulumu | Ilk acilista veri kasasi olusturulur | Kullanici sifreleme kurulumu yapmadan gorev icerigi kalici depoya yazilmaz |
| FR-002 | Must | Gorev olusturma | Baslik zorunlu, diger alanlar opsiyonel | Yeni gorev listeye eklenir ve uygulama yeniden acildiginda korunur |
| FR-003 | Must | Gorev duzenleme | Baslik, aciklama, zamanlama, etiket, onem ve durum duzenlenebilir | Duzenleme sonrasinda liste ve detay ekranlari tutarli guncellenir |
| FR-004 | Must | Gorev silme ve arsivleme | Silme geri alinir veya onay ister; arsiv kalici saklama icindir | Yanlislikla veri kaybi riski azaltılır |
| FR-005 | Must | Alt gorevler | Gorevlerin alt gorevleri olabilir | Alt gorev tamamlandiginda ana gorev ilerlemesi guncellenir |
| FR-006 | Must | Zaman aralikli gorev | Baslangic ve bitis zamani verilebilir | Gunluk gorunumde dogru saat blogunda gorunur |
| FR-007 | Must | Zamansiz gorev havuzu | Gunu veya saati olmayan gorevler ayrica listelenir | Havuzdaki gorev gunluk listeyi kalabaliklastirmaz |
| FR-008 | Must | Tekrar eden rutin | Gunluk, haftalik ve ozel periyotlar desteklenir | Rutin ornekleri beklenen gunlerde uretilir |
| FR-009 | Must | Deadline'li gorev | Tamamlanana kadar listede kalir | Gorev tamamlaninca aktif listeden kalkar |
| FR-010 | Must | Offline kullanilabilirlik | Cekirdek ozellikler internet olmadan calisir | Ucak modu testinde CRUD, liste, tekrar ve export calisir |
| FR-011 | Must | Export | JSON ve Markdown export | Export dosyasi tekrar import edilebilir veya okunabilir |
| FR-012 | Should | Import | free-task JSON import | Import mevcut veriyi bozmadan yeni kayitlar ekler veya eslestirir |
| FR-013 | Should | Basit NLP parser | Basit Turkce tarih/saat ifadelerini ayristirir | "yarin 15:00" gibi girdiler dogru oneriler uretir |
| FR-014 | Should | Link metadata | Link basligi kullanici onayi ile cekilir | Basarisiz metadata cekimi gorev kaydini engellemez |
| FR-015 | Should | Basit istatistikler | Tamamlama, seri ve rutin uyumu gorunur | Istatistikler yerel veriden hesaplanir |
| FR-016 | Should | Tema tercihleri | Light/dark ve temel gorunum ayarlari | Tercihler yeniden acilista korunur |
| FR-017 | Could | Medya ekleri | Gorsel referansi veya dosya ekleri | Ekler sifreleme/veri tasima modeline uyarsa etkinlesir |
| FR-018 | Could | Gorev agaci icin veri hazirligi | Bagimlilik alanlari veri modelinde dusunulur | UI Faz 3'e kalsa bile veri modeli engel cikarmaz |

## 11. User Stories

| ID | Rol | Hikaye | Deger | Kabul Kriterleri |
| --- | --- | --- | --- | --- |
| US-001 | Bireysel kullanici | Gunluk gorevlerimi hizlica eklemek istiyorum, boylece planimi baska araca bolmem | Hız | Baslikla gorev ekleme 2-3 adimdan uzun surmez |
| US-002 | Bireysel kullanici | Rutinlerimi tekrar kurallariyla takip etmek istiyorum, boylece her gun yeniden yazmam | Sureklilik | Tekrar eden gorev beklenen gunlerde listelenir |
| US-003 | Bireysel kullanici | Internet yokken de gorevlerimi gormek istiyorum, boylece uygulama gun icinde boşa dusmez | Guvenilirlik | Ucak modunda ana akişlar calisir |
| US-004 | Bireysel kullanici | Verimin sifreli tutuldugunu bilmek istiyorum, boylece gorev notlarima guvenebilirim | Gizlilik | Gorev icerigi sifreleme politikasi disinda kalici yazilmaz |
| US-005 | Bireysel kullanici | Verimi disari almak istiyorum, boylece araca kilitlenmem | Veri ozgurlugu | JSON ve Markdown export alinabilir |
| US-006 | Bireysel kullanici | Tamamlanan gorevleri istersem gizlemek istersem ustu cizili gormek istiyorum | Kisisellestirme | Ayar degistiginde liste davranisi aninda uygulanir |

## 12. Veri Modeli ve Icerik

### Ana Varliklar

| Varlik | Alanlar | Iliskiler | Yasam Dongusu |
| --- | --- | --- | --- |
| UserProfile | id, ad, locale, timezone, tercihleri | LocalVault ile iliskili | Olusturulur, duzenlenir, export edilir |
| LocalVault | id, encryption_version, created_at, key_metadata | Tum yerel verinin guvenlik kapsami | Ilk acilista olusturulur |
| Task | id, title, description, status, priority, effort, due_at, start_at, end_at, schedule_type, created_at, updated_at | Subtask, Tag, Attachment, RecurrenceRule | Aktif, tamamlandi, ertelendi, arsivlendi, silindi |
| Subtask | id, task_id, title, status, order | Task'a bagli | Olusturulur, tamamlanir, silinir |
| RecurrenceRule | id, task_id, frequency, interval, days, until, count | Task ile bire bir/coklu | Rutin hesaplamasinda kullanilir |
| Tag | id, name, color | Task ile coklu iliski | Olusturulur, duzenlenir, silinir |
| Attachment | id, task_id, type, local_uri, metadata | Task'a bagli | Eklenir, export edilir veya silinir |
| LinkPreview | id, task_id, url, title, fetched_at | Task'a bagli | Kullanici onayi ile guncellenir |
| CompletionEvent | id, task_id, completed_at, source | Istatistikler icin | Tamamlama sirasinda olusur |
| AppPreference | key, value | UserProfile ile iliskili | Ayarlar ekranindan guncellenir |

### Veri Saklama, Silme ve Export

- Gorev icerigi, notlar, etiketler ve istatistikler varsayilan olarak yerel sifreli depoda saklanir.
- Export iki modda tasarlanir: okunabilir acik export ve sifreli yedek export.
- Silme islemi MVP'de en azindan onay veya kisa sureli geri alma davranisi icermelidir.
- Arşiv, veri silmeden aktif gorunumden cikarma amaciyla kullanilir.
- Gelecek senkronizasyon modelinde sunucu tarafı plaintext gorev icerigi gormemelidir.

## 13. API, Entegrasyon ve Bagimliliklar

| Bagimlilik | Amac | Kritik Akis | Hata Davranisi | Kaynak |
| --- | --- | --- | --- | --- |
| Flutter/Dart aday stack | Mobil oncelikli cok platformlu uygulama | UI, state, build, platform paketleri | Teknik tasarimda alternatiflerle dogrulanacak | https://docs.flutter.dev/ |
| Yerel SQLite aday depolama | Cihaz ustunde kalici veri | Gorev CRUD, arama, tekrar hesaplari | Sifreleme ve migration modeli dogrulanmadan uygulanmayacak | https://docs.flutter.dev/cookbook/persistence/sqlite |
| SQLCipher aday sifreleme | Yerel veritabani sifreleme | LocalVault ve gorev icerigi | Platform destegi ve lisans uyumu teknik tasarimda dogrulanacak | https://www.zetetic.net/sqlcipher/ |
| Link metadata cekimi | Gorevde link basligi gostermek | Kullanici link eklediginde | Offline/hata durumunda link ham haliyle kalir | TBD |
| AI saglayicilari | MVP disi | Faz 3 planlama/ajan ozellikleri | Kullanici onayi ve E2EE politikasina uymadan etkinlesmez | TBD |

## 14. UX/UI Gereksinimleri

### Ekranlar

- Ilk acilis ve kasa/sifreleme kurulumu.
- Bugun/Gunluk liste.
- Havuz/Zamansiz gorevler.
- Takvim veya tarih secici.
- Gorev olusturma/duzenleme.
- Gorev detay ve alt gorevler.
- Rutin/tekrar kuralı duzenleme.
- Arama ve filtreler.
- Istatistik ozeti.
- Ayarlar: tema, tamamlanan gorev davranisi, export/import, gizlilik.

### Durumlar

- Loading: Yerel kasa aciliyor, import isleniyor veya metadata cekiliyor.
- Empty: Bugun gorev yok, havuz bos, arsiv bos.
- Error: Kasa acilamadi, import gecersiz, tekrar kuralı gecersiz, metadata alinamadi.
- Success: Gorev eklendi, tamamlandi, export alindi, import tamamlandi.
- Permission denied: Dosya/medya izni reddedildi, bildirim izni reddedildi.

### Erisilebilirlik ve Responsive Davranis

- Mobil cihazlarda tek elle kullanilabilir ana aksiyonlar.
- Metin boyutu sistem ayarlarina makul olcude uyumlu olmalı.
- Kontrast light/dark modda okunabilir olmalı.
- Swipe aksiyonlarinin buton alternatifi bulunmalı.
- Dinamik saat/tarih secimi ekran okuyucu ile kullanilabilir olmalı.
- Masaustu/web gorunumleri teknik olarak hedeflense de MVP UX kararlarinda mobil oncelik korunur.

## 15. Guvenlik, Gizlilik ve Yetkilendirme

### Auth

- MVP'de uzaktan hesap sistemi yoktur.
- Yerel kasa acma, cihaz kilidi/biometric veya kullanici sifresiyle desteklenebilir.
- Hesap, login, OAuth, SSO ve magic link Faz 2'de senkronizasyon/SaaS ile birlikte degerlendirilir.

### Yetki Modeli

- MVP'de tek yerel owner modeli vardir.
- Faz 2'de owner, admin, member ve viewer gibi roller eklenecektir.
- Yetki modeli sonraki fazda E2EE senkronizasyon ile uyumlu tasarlanmalıdır.

### Veri Guvenligi

- E2EE bastan zorunlu urun prensibidir.
- MVP'de pratik karsiligi: yerel gorev verisi sifreli depolanır, export/yedekler icin sifreli mod sunulur ve herhangi bir dis servise plaintext gorev icerigi gonderilmez.
- Faz 2 senkronizasyonda istemci tarafinda sifrelenmis veri sunucuya gonderilir; sunucu gorev icerigini okuyamaz.
- Anahtar yonetimi, kurtarma, cihaz degistirme ve kayip sifre davranisi teknik tasarimda ayrintilandirilmalıdır.
- Mobil guvenlik icin OWASP MASVS Storage, Cryptography ve Privacy bolumleri referans alinmalıdır.

### Abuse Prevention ve Rate Limit

- MVP yerel oldugu icin klasik sunucu rate limit kapsami yoktur.
- Faz 2/3'te API, webhook ve AI entegrasyonlari icin rate limit, token scope, abuse prevention ve audit log gerekecektir.

## 16. Analytics ve Izleme

| Event | Ne Zaman Tetiklenir | Ozellikler | Amac |
| --- | --- | --- | --- |
| task_created | Gorev eklendiginde | schedule_type, has_due_date, has_recurrence | Yerel kullanim ozeti |
| task_completed | Gorev tamamlandiginda | task_type, completion_source | Tamamlama ve seri hesaplari |
| task_postponed | Gorev ertelendiginde | old_date, new_date | Erteleme aliskanliklarini anlamak |
| routine_completed | Rutin tamamlandiginda | recurrence_id, streak | Rutin uyumu |
| export_created | Export alindiginda | format, encrypted | Veri ozgurlugu kontrolu |
| import_completed | Import tamamlandiginda | source, success_count, error_count | Migration kalitesi |

MVP'de analytics yerel ve kullaniciya gorunur olmalıdır. Uzaktan telemetry varsayilan olarak kapali kabul edilir. Gelecekte hata raporlama veya anonim telemetry eklenirse acik riza, kapatma ayari ve veri minimizasyonu gerekir.

## 17. Non-Functional Requirements

| Kategori | Gereksinim | Hedef |
| --- | --- | --- |
| Performans | Ana liste hizli acilmali | Tipik cihazda 1 saniyenin altinda algilanan acilis hedefi |
| Performans | Gorev ekleme akisi hafif olmali | Kullanici 2-3 saniye icinde basit gorev ekleyebilmeli |
| Guvenilirlik | Veri kaybi onlenmeli | Her yazma islemi atomik veya kurtarilabilir olmalı |
| Offline | Cekirdek islevler internetsiz calismali | CRUD, liste, tekrar, arama, export |
| Guvenlik | Sifrelenmemis kalici hassas veri yazilmamali | Kod inceleme ve test checklist'i |
| Gizlilik | Harici servise veri gonderimi varsayilan kapali | Kullanici onayi olmadan link/AI/telemetry yok |
| Tasınabilirlik | Veri disari alinabilir olmalı | JSON ve Markdown |
| Erisilebilirlik | Temel mobil erisilebilirlik | Ekran okuyucu, kontrast, buton alternatifi |
| Lokalizasyon | Turkce + Ingilizce | Cihaz dili varsayilani ve Ayarlar'dan dil degistirme |
| Bakim | Fazlara ayrilmis mimari | Sync/AI/API sonradan eklenebilir |

## 18. Edge Case'ler ve Hata Senaryolari

- Kullanici kasa sifresini unutur.
- Cihaz saati veya timezone degisir.
- Tekrar eden gorev ayni gunde birden fazla kez olusur.
- Deadline gecmis ama gorev tamamlanmamistir.
- Alt gorev tamamlandi ama ana gorev tamamlanmamistir.
- Import dosyasinda duplicate id veya bozuk alan vardir.
- Export dosyasi buyuk veya medya referanslari eksiktir.
- Link metadata cekimi timeout olur.
- Uygulama yazma islemi sirasinda kapanir.
- Kasa migration'i yarida kalir.
- Kullanici tamamlanan gorevleri gizle/ustunu ciz tercihini degistirir.
- Bildirim izni reddedilir.
- E2EE anahtar/kurtarma karari kullanici tarafinda anlasilmazsa veri kaybi riski dogar.

## 19. Rollout Plani

### Yayin Stratejisi

- Ilk asama: yerel dogfooding, tek kullanici.
- Ikinci asama: GitHub uzerinden teknik kullanicilar icin kaynak kod ve kurulum denemesi.
- Ucuncu asama: paketlenmis mobil/desktop build veya test kanali.

### Beta / Pilot

- Kapali beta zorunlu degil.
- Kullanici kendi kullanimindan geri bildirim cikarir.
- Eger baskalari deneyecekse, E2EE ve veri kaybi riskleri icin acik uyari gerekir.

### Migration

- MVP'de free-task JSON import/export temel migration hattidir.
- Todoist, Apple Reminders, Linear ve Markdown import sonraki faza birakilir.

### Support ve Feedback

- Ilk kanal GitHub Issues olabilir.
- Kullanici dokumantasyonu ve self-host dokumantasyonu Faz 2'de genisletilir.

## 20. Riskler ve Azaltma Plani

| Risk | Etki | Olasilik | Azaltma |
| --- | --- | --- | --- |
| MVP kapsamının buyumesi | Teslim gecikir | Yuksek | Self-host, SaaS, AI ajanlari ve multi-user Faz 2/3'e kilitlenir |
| E2EE'nin erken karmasiklik yaratmasi | Mimari yavaslar | Yuksek | MVP'de yerel sifreli kasa ve net anahtar modeliyle baslanir |
| Flutter desktop/web paket uyumu sorunlari | Platform kapsami daralir | Orta | Mobil oncelik, desktop/web teknik tasarimda dogrulama |
| Yerel veride migration hatalari | Veri kaybi | Orta | Migration testleri, yedek ve geri alma planı |
| AI gizlilik politikasiyla celisir | Guven kaybi | Orta | MVP'de harici AI yok, Faz 3 icin human-in-the-loop ve E2EE politikasi |
| Custom tema sistemi karmasiklasir | UX dagilir | Orta | MVP'de temel tema, ileri tema Faz 2/3 |
| Kullanici sifresini unutursa veri kurtarma zorlu | Veri kaybi | Orta | Kurtarma tasarimi teknik tasarimda netlestirilir, kullaniciya acik uyari |

## 21. Acik Sorular

| Soru | Sahip | Karar Tarihi | Etki |
| --- | --- | --- | --- |
| Lisans ne olacak? | Kullanici | TBD | Acik kaynak kullanimi |
| App store dagitimi hedefleniyor mu? | Kullanici | TBD | Yayın ve build sureci |

### Karara Baglanan Konular

| Konu | Karar | Tarih |
| --- | --- | --- |
| UI dili | Turkce + Ingilizce | 2026-07-04 |
| Mobil platform onceligi | Android + iOS es zamanli | 2026-07-04 |
| Stack | Flutter/Dart adayligi teknik tasarimda baglayici MVP karari olarak benimsendi; SQLCipher adapter spike'i uygulama oncesi risk azaltma gorevi | 2026-07-04 |
| Sifre/kurtarma modeli | Parola + biyometrik + kurtarma anahtari | 2026-07-04 |
| Yerel bildirimler | MVP'ye dahil; opt-in ve cihaz ici local notifications | 2026-07-04 |

## 22. Uygulama Oncesi Karar Listesi

- SQLCipher adapter paket olgunlugunu Android+iOS spike ile dogrula.
- E2EE icin anahtar turetme, saklama, recovery ve export politikasini uygulama oncesi teknik spike ile netlestir.
- Local notification lock screen gizlilik varsayilanini sec.
- GitHub repo icin `.gitignore`, lisans, README ve katkı notlarini planla.

## 23. Gerekli Resmi Dokumantasyon ve Skill'ler

### Kontrol Edilen Resmi Kaynaklar

- Flutter Docs: https://docs.flutter.dev/ - cok platformlu uygulama, UI, state, persistence ve build kararları icin.
- Flutter Supported Platforms: https://docs.flutter.dev/platform-integration/supported-platforms - mobil, desktop ve web hedeflerinin resmi durumunu dogrulamak icin.
- Dart Overview: https://dart.dev/overview - Dart'in cok platformlu istemci dili olarak uygunlugunu degerlendirmek icin.
- Flutter SQLite Cookbook: https://docs.flutter.dev/cookbook/persistence/sqlite - yerel kalici veri yaklasimi icin.
- SQLCipher: https://www.zetetic.net/sqlcipher/ - yerel veritabani sifreleme ve platform destegi icin.
- OWASP MASVS: https://mas.owasp.org/MASVS/ - mobil uygulama storage, cryptography ve privacy guvenlik beklentileri icin.

### Kullanilmasi Onerilen Codex Skill'leri

- `$ux-flow-planner`: PRD'den ekranlar, akışlar, durumlar ve mobil oncelikli UX kararlarini cikarmak icin.
- `$technical-design`: Flutter/Dart, yerel veri, sifreleme, sync'e hazir mimari, build ve deployment kararlarini netlestirmek icin.
- `$data-permissions`: veri modeli, E2EE, local vault, roller, retention, privacy ve audit gereksinimlerini ayrintilandirmak icin.
- `$implementation-plan`: milestone, issue, repo kurulumu, toolchain ve ilk sprint planini cikarmak icin.
- `$test-plan`: offline, sifreleme, migration, veri kaybi, mobil UX ve erisilebilirlik testlerini planlamak icin.
- `$launch-plan`: dogfooding, GitHub release, beta, support, rollback ve post-launch olcum planı icin.

### Kullanıcıdan Istenen Kaynaklar

- Varsa logo, isim alternatifi veya marka tercihi.
- Lisans tercihi: MIT, Apache-2.0, GPL/AGPL veya karar bekliyor.
