# free-task — Ürün Tasarım Özeti (claude-v1)

> Kaynak: yalnızca `docs/project/prd.md` ve `docs/project/claude-design-brief.md`.
> Bu doküman PRD faz kapsamını bozmaz; MVP'yi detaylı, Faz 2/Faz 3'ü genişleme notu olarak tanımlar.
> Görsel ekranlar: `docs/design/claude-v1/screens/` (01–07). Yaşayan tasarım dosyası: `free-task Design.dc.html`.

---

## 0. Repo bağlamı (kısa özet)

- **Okunan dosyalar:** PRD (`prd.md`) ve tasarım brief'i (`claude-design-brief.md`). Repo'da mevcut uygulama kodu, UI kit, marka rehberi veya token dosyası yok — tasarım kararları sıfırdan bu iki dosyaya dayanılarak alınmıştır.
- **MVP kapsamı:** Bireysel kullanıcı; mobil öncelikli Android+iOS; PC/desktop ve web için resmi MVP release değil, uyumluluk guard'ı; yerel şifreli kasa (E2EE prensibi); offline çekirdek; görev CRUD + alt görev + zamanlama + tekrar + deadline + zamansız havuz; günlük liste + takvim + basit istatistik; JSON/Markdown export, free-task JSON import; basit yerel tarih/saat ayrıştırma; light/dark tema.
- **Faz 2 kapsamı:** self-host sync, SaaS alternatifi, cihazlar arası E2EE sync, multi-user + roller + aile/takım, gelişmiş import, gelişmiş istatistik paneli, ileri tema sistemi.
- **Faz 3 kapsamı:** bulut + lokal AI, ses/görsel girdi, human-in-the-loop AI görev onayı, agent/plugin, REST/GraphQL + webhooks, görev ağacı/DAG, opsiyonel oyunlaştırma.
- **Alınan ana tasarım kararları:**
  1. Yön = **Quiet Productivity** (aşağıda 2 alternatifle gerekçelendirildi).
  2. Navigasyon omurgası = **4 sekmeli alt bar + merkez FAB**; her faz bu omurgayı kırmadan büyür.
  3. Güç özellikleri (sync, AI, API) ana ekrana doldurulmaz; **Ayarlar** ve **komut/input yüzeyleri** üzerinden gelir.
  4. **Task row** her fazda temel birimdir; genişleme onun üzerine katman ekler (avatar, AI rozeti, bağımlılık düğümü).
  5. Güvenlik/offline dili **sakin ve sabit**: koruma hissi verir, korkutmaz.

---

## 1. Genel ürün tasarım omurgası

### 1.1 Product design north star
> **"Sessiz güven."** free-task, kullanıcının günü açıldığında ne yapacağını tek bakışta gösteren; internet, hesap veya buluta ihtiyaç duymadan güvenilir çalışan; verinin sahibinin kendisi olduğunu her ekranda sessizce hissettiren bir üretkenlik aracıdır. Uygulama dikkat çekmeye değil, dikkatten çekilmeye çalışır.

### 1.2 Ürün tonu ve kişiliği
- **Sakin, net, aceleci değil.** Renk ve hareket minimum; bilgi hiyerarşisi maksimum.
- **Dürüst.** Offline/şifreli/hata durumları gizlenmez, sade dille söylenir.
- **Saygılı.** Kullanıcıyı gamify etmez, bildirim bombardımanı yapmaz, "seri kırıldı" ile suçlamaz.
- **Teknik ama erişilebilir.** E2EE gibi kavramlar mühendis diliyle değil, "verilerin bu cihazdan çıkmıyor" gibi insan diliyle anlatılır.

### 1.3 Light/dark tema stratejisi
- **Tek token seti, iki tema haritası.** Tüm renkler semantik token'lara bağlanır (`--bg`, `--surface`, `--ink-1`, `--primary`…); tema değişince yalnızca eşleme değişir, layout/aralık sabit kalır.
- **Sıcak-nötr temel.** Beyazlar ve siyahlar hafif sıcak tonlu (saturasyon çok düşük); saf `#FFF`/`#000` yerine `#FAF9F6` / `#1B1815`. Uzun kullanımda göz yormaz.
- **Sistem varsayılan.** Tema tercihi: Açık / Koyu / **Sistem** (varsayılan). MVP'de üç seçenek yeterli; ileri tema sistemi Faz 2.
- **Aynı anlam, iki ton.** Primary teal, warning amber, danger red her iki temada aynı role sahip; koyuda lightness biraz artırılır (kontrast için).

### 1.4 Teknik kavramların sade dili
| Kavram | Ekranda görünen dil | Nerede |
| --- | --- | --- |
| E2EE / yerel şifreleme | "Uçtan uca şifreli · Yerel" + "Verilerin bu cihazdan çıkmıyor" | Ayarlar banner'ı, kasa kurulumu |
| Offline | Durum çubuğunda sessiz "ÇEVRİMDIŞI" etiketi; hiçbir işlev kilitlenmez | Global status |
| Anahtar / kurtarma | "Parolanı unutursan kasa açılamaz. Kurtarma anahtarını kaydet." | Kasa kurulumu, uyarı kutusu |
| Sync (Faz 2) | "Tüm cihazlarda güncel · 2 dk önce" | Üst bar rozeti |
| AI (Faz 3) | "Öneri — sen onaylamadan hiçbir şey eklenmez" | AI onay kartı |

Prensip: **teknik terim → kullanıcı faydası**. Terim gösterilecekse yanında ne anlama geldiği bir cümleyle verilir.

### 1.5 Kırılmadan büyüyen tasarım prensipleri
1. **Sabit omurga, değişken içerik.** Alt bar + FAB + task row her fazda aynı; yeni güç bu iskeletin içine yerleşir.
2. **Progressive disclosure.** Basit varsayılan önde; güç (tekrar kuralı, bağımlılık, AI) bir dokunuş derinde.
3. **Ayarlar = genişleme deposu.** Yeni yüzeyler önce Ayarlar altında bir bölüm olarak doğar, olgunlaşınca gerekiyorsa navigasyona çıkar.
4. **Her swipe'ın buton karşılığı var.** Erişilebilirlik ve keşfedilebilirlik için.
5. **Güven dili sabit.** Gizlilik/güvenlik anlatımı fazlar arası tutarlı kalır.

---

## 2. Tasarım yönü

### Alternatif A — Quiet Productivity  ✅ (SEÇİLEN)
- **Renk:** Sıcak-nötr kâğıt zemini (`#FAF9F6`), tek sakin teal accent (`#2C7D6D`), semantik amber/red. Az sayıda, düşük doygunlukta renk.
- **Tipografi:** Hanken Grotesk (UI, 400–700) + IBM Plex Mono (teknik etiket, saat, kod-benzeri meta). Net, hümanist grotesk; başlıklarda hafif negatif letter-spacing.
- **Spacing:** 4px tabanlı ölçek; cömert satır aralığı; kartlar arası 8px, bölüm arası 16px.
- **İkon:** 2px stroke, yuvarlatılmış uç, tek renk (currentColor). Dekoratif değil işlevsel.
- **Yoğunluk:** Rahat ama boş değil; günlük listede 3–4 görev ekranı doldurmadan okunur.
- **Hareket:** Minimal — sheet yukarı kayar, checkbox dolar, satır kaybolur. Spring yok, gösteriş yok.

### Alternatif B — Customizable Power-user Light
- **Renk:** Aynı nötr temel ama daha yüksek kontrast + kullanıcı tarafından değiştirilebilir accent paleti (mavi/mor/yeşil).
- **Tipografi:** Aynı gövde fontu + isteğe bağlı monospace-first "developer" görünüm.
- **Spacing:** Daha sıkı; **compact density** varsayılan; ekran başına daha çok görev.
- **İkon:** Aynı stil + klavye/komut ipuçları (⌘, /) görünür.
- **Yoğunluk:** Yüksek; tablo-benzeri hızlı tarama, çoklu filtre çipleri.
- **Hareket:** Anlık, "snappy"; keyboard-driven.

### Seçim ve gerekçe
**Quiet Productivity seçildi.** PRD'nin north star'ı "sade, hızlı, dikkat dağıtmayan, gizlilik odaklı, tek kullanıcı"dır; brief açıkça aşırı dekorasyon, marketing hero ve gereksiz karmaşadan kaçınmayı ister. Power-user yoğunluğu değerli ama **MVP tek kullanıcı** için erken karmaşıklıktır. Çözüm: Quiet Productivity'yi taban al, power-user ihtiyacını **compact density modu** olarak Ayarlar'a koy (B'nin en iyi parçasını bir toggle olarak taşı). Böylece MVP sakin kalır, güç kullanıcı isteyince açılır, Faz 2/3 tema sistemi B'nin özelleştirme vizyonunu tam karşılar.

---

## 3. Fazlara göre bilgi mimarisi ve navigasyon

### 3.1 MVP mobil ana navigasyon
**Alt bar (4 sekme) + merkez FAB:**

`[ Bugün ]   [ Takvim ]   ( + )   [ Havuz ]   [ Ayarlar ]`

- **Bugün** — birincil ekran: bugünün zaman bloklu + rutin + deadline görevleri, hızlı özet çipleri.
- **Takvim** — tarih seçici + güne/haftaya bakış; geçmiş/gelecek gezinme.
- **( + ) FAB** — merkez, tek elle ulaşılır; bottom sheet "Yeni görev" açar. Basılı tutma Faz 3'te komut/AI yüzeyine ayrılır.
- **Havuz** — zamansız görevler; günlük listeyi kalabalıklaştırmayan "yapılacaklar deposu".
- **Ayarlar** — gizlilik/güvenlik, görünüm, veri (export/import), hakkında.

**İstatistik** ayrı sekme değil: Bugün üst barındaki grafik ikonundan ve özet çiplerinden erişilir (MVP'de basit tutulur; Faz 2'de tam panele büyür).

### 3.2 Faz 2'ye geçince navigasyon
- Alt bar **aynı 4 sekme** kalır.
- Başlığa **workspace/alan switcher** girer ("Kişisel ▾ / Aile"). Multi-user ve ekip görevleri buradan seçilir.
- **Sync durumu** üst barda küçük bir rozet olarak belirir (ana akışı bölmez).
- Ayarlar'a yeni bölümler eklenir: **Senkronizasyon, Cihazlar, Kurtarma anahtarı, Roller & üyeler, Sunucu bağlantısı (self-host/SaaS)**.

### 3.3 Faz 3'e geçince navigasyon
- **AI ana ekrana doldurulmaz.** İki giriş noktası:
  1. **Komut çubuğu** — FAB'a basılı tutma veya "/" ile açılan input yüzeyi (metin + ses + görsel).
  2. **AI onay ekranı** — üretilen görevler her zaman human-in-the-loop bir önizleme kartıyla gelir.
- **Görev ağacı / DAG** — bir görevin detayından veya opsiyonel bir "Ağaç" görünümünden açılır (ana bara zorlanmaz).
- **Agent/plugin, API key, webhook** — tamamen Ayarlar altında ("Otomasyon" bölümü).
- **Oyunlaştırma** — varsa İstatistik içinde, sessiz ve opsiyonel; ana deneyimi bozmaz, leaderboard varsayılan kapalı.

### 3.4 Ne nerede kalmalı?
- **Ana navigasyonda:** günlük iş akışı (Bugün, Takvim, Havuz, hızlı ekleme).
- **Ayarlarda:** güvenlik, veri, sync, roller, tema, otomasyon/AI konfigürasyonu, API.
- **Detay ekranlarında:** alt görevler, tekrar kuralı, bağımlılıklar, link/medya.
- **Komut/input yüzeylerinde:** NLP hızlı ekleme, AI komutu, ses/görsel girdi.

---

## 4. MVP ana ekran spesifikasyonları

> Ölçek: 390×844 mobil. Dokunma hedefleri ≥ 44px. Ekran görselleri `screens/` altında.

### 4.1 İlk açılış ve yerel şifreli kasa kurulumu — `01-vault-setup.png`
- **Layout:** Kilit ikonu → başlık → açıklama → parola + parola (tekrar) → biyometrik toggle → güvenlik uyarı kutusu → primary + secondary buton. Dark örnekte gösterildi (light paritesi mevcut).
- **Ana bileşenler:** Parola alanları (girildikçe eşleşme durumu ring ile), "Face ID ile aç" toggle, kurtarma uyarısı (kalkan ikonu), durum çubuğunda "ÇEVRİMDIŞI".
- **Primary aksiyon:** "Kasayı oluştur". **Secondary:** "Nasıl çalışır?".
- **State'ler:** parola zayıf/eşleşmiyor (inline), biyometrik yok (toggle gizli), kurtarma anahtarı adımı (sonraki ekran).
- **Mikro metin:** "Görevlerin bu cihazda şifrelenir. Hesap yok, sunucu yok — anahtar yalnızca sende." / "Parolanı unutursan kasa açılamaz. Kurtarma anahtarını bir sonraki adımda kaydedeceksin."

### 4.2 Locked vault / kasa kilitli ekranı
- **Layout:** Ortada kilit ikonu, "Kasa kilitli" başlığı, parola alanı, "Face ID ile aç" birincil butonu, altta küçük "Kurtarma seçenekleri".
- **Ana bileşenler:** Tek parola girişi, biyometrik prompt tetiği, hata sayacı.
- **State'ler:** yanlış parola (nazik hata + kalan deneme yok — kilitleme yerine bekleme), biyometrik başarısız → parolaya düş, kurtarma akışı.
- **Mikro metin:** "Devam etmek için kasanı aç." / hata: "Parola hatalı. Tekrar dene veya kurtarma seçeneklerini kullan."

### 4.3 Bugün / günlük liste — `02-today.png`
- **Layout:** Durum çubuğu ("ŞİFRELİ") → başlık "Bugün" + tarih + istatistik/arama ikonları → 3 özet çipi (Bugün X/Y, Seri, Rutin) → zaman bölümlerine göre gruplu görev listesi (Sabah / Gün içi · Rutin) → tamamlananlar (üstü çizili/gizli) → alt bar + FAB.
- **Ana bileşenler:** Task row (checkbox + öncelik noktası + başlık + meta çipleri: saat, etiket, alt görev sayısı, tekrar/deadline rozeti), bölüm başlıkları, "Tamamlananları göster (n)".
- **Primary aksiyon:** görevi tamamla (checkbox); FAB ile yeni görev. **Secondary:** satıra dokun → detay; swipe → tamamla/ertele/arşivle (buton alternatifleriyle).
- **State'ler:** empty ("Bugün planın boş"), offline (etiket), loading (skeleton satırlar), tamamlanan davranışı (gizle/çiz ayarına göre).
- **Mikro metin:** özet "4 / 7", "12 🔥 Seri (gün)". Empty: "Bugün için görev yok. + ile ekle veya havuzdan çek."

### 4.4 Yeni görev ekleme — `03-add-task.png`
- **Layout:** Dimmed Bugün üstünde bottom sheet: grabber → NLP hızlı input (algılanan tarih/saat çipleri) → zamanlama tipi segmenti (Zaman aralıklı / Zamansız / Tekrar) → meta satırları (Öncelik, Etiket, Alt görev/not/link) → "Ekle".
- **Ana bileşenler:** NLP input + parse çipleri ("Yarın · 5 Tem", "15:00", "algılandı — düzenleyebilirsin"), segment control, satır listesi.
- **Primary aksiyon:** "Ekle". **Secondary:** çipe dokunup düzenle, tip değiştir, alt detay aç.
- **State'ler:** NLP algılamadı (çip yok, manuel gir), deadline modu (deadline alanı), tekrar modu (→ 4.5 açılır), offline (link metadata ertelenir).
- **Mikro metin:** placeholder "Ne yapman gerek? Örn: yarın 15:00 rapor gönder".

### 4.5 Görev detay ve alt görevler — `04-task-detail.png`
- **Layout:** Geri + düzenle + ⋯ → öncelik/etiket çipleri → başlık → zaman/tekrar meta çipleri → not kartı → link önizleme kartı → alt görev başlığı + ilerleme (2/4) + progress bar + alt görev satırları → yapışkan aksiyon çubuğu (Tamamla + Ertele + Arşivle).
- **Ana bileşenler:** Subtask row (checkbox + başlık, tamamlanınca üstü çizili), link preview (favicon placeholder + başlık + URL), progress bar.
- **Primary aksiyon:** "Tamamla". **Secondary:** ertele (saat ikonu), arşivle (kutu ikonu), düzenle, alt görev ekle.
- **State'ler:** metadata çekilemedi (link ham gösterilir), tüm alt görevler bitti (ana görev otomatik önerisi), deadline geçti (uyarı çipi).
- **Mikro metin:** "2 / 4", link fallback: "Başlık alınamadı — bağlantı olduğu gibi saklandı."

### 4.6 Zamanlama / tekrar kuralı düzenleme — `05-repeat-editor.png`
- **Layout:** Bottom sheet: başlık → frekans segmenti (Günlük/Haftalık/Aylık/Özel) → interval satırı (Her [−] 1 hafta [+]) → hafta günü seçici (Pzt–Paz çipleri) → bitiş (Asla / Tarihte / N tekrar sonra, radio) → canlı önizleme → "Kuralı kaydet".
- **Ana bileşenler:** Segment, stepper, gün çip grid, radio list, önizleme kutusu ("Sonraki: Pzt 6 Tem, Çar 8 Tem…").
- **Primary aksiyon:** "Kuralı kaydet". **Secondary:** frekans/gün değiştir.
- **State'ler:** geçersiz kural (kaydet pasif + düzeltme ipucu), özel periyot (ek alanlar), timezone değişimi uyarısı.
- **Mikro metin:** hata: "Bu kural geçerli değil — en az bir gün seç." Önizleme her değişiklikte güncellenir.

### 4.7 Havuz / zamansız görevler
- **Layout:** Bugün ile aynı task row dili, ama zaman/bölüm yok; öncelik ve etikete göre gruplanabilir; üstte "Havuz" başlığı + sıralama/filtre.
- **Ana bileşenler:** Task row (saat çipi olmadan), "Bugüne çek" hızlı aksiyonu (swipe/buton).
- **State'ler:** empty ("Havuz boş — zamansız fikirler burada birikir").

### 4.8 Takvim / tarih seçici
- **Layout:** Ay grid veya hafta şeridi → seçili günün görev listesi altta. Deadline'lı görevler işaretli.
- **Ana bileşenler:** Ay/hafta toggle, gün hücresi (nokta = görev var), seçili gün paneli.
- **State'ler:** boş gün, yoğun gün (nokta yığını), bugüne dön butonu. Ekran okuyucu için tarih seçimi buton-erişilebilir.

### 4.9 İstatistik özeti
- **Layout:** Üstte 3 büyük metrik (tamamlanan, seri, rutin uyumu) → basit haftalık bar/heatmap → rutin uyum listesi.
- **Ana bileşenler:** Metrik kart, hafif grafik (yerel veriden), rutin satırı + yüzde.
- **State'ler:** yeterli veri yok ("Birkaç gün sonra buraya trendlerin gelecek"), tümü yerel rozeti.
- **Not:** MVP'de sade; Faz 2'de tam panele büyür.

### 4.10 Ayarlar — `06-settings.png`
- **Layout:** Başlık → güvenlik durum banner'ı ("Uçtan uca şifreli · Yerel") → gruplu satırlar: Gizlilik & Güvenlik (Kasa & parola, Face ID, Otomatik kilit) / Görünüm (Tema Açık-Koyu-Sistem, Yoğunluk, Tamamlanan görevler) / Veri (Dışa aktar JSON·MD, İçe aktar).
- **Ana bileşenler:** Settings row, toggle, segment (tema), değer + chevron satırı, güvenlik durum elementi.
- **Primary aksiyonlar:** export/import, tema değiştir, kasa yönet.
- **State'ler:** export sürüyor (loading), import hata (hangi satır), izin reddedildi (dosya erişimi).
- **Mikro metin:** "Verilerin bu cihazdan çıkmıyor.", "Tamamlanan görevler: Üstü çizili göster".

---

## 5. Faz 2 genişleme notları

MVP tasarımı bozulmadan eklenir. **Bu faz için artık tam ekran tasarımları da mevcuttur** (`screens/14`–`23`); aşağıdaki notlar bilgi mimarisi ve component etkisini özetler.

- **Sync status** (`14-sync-status.png`): Üst barda küçük rozet (senkron/bekliyor/hata/offline) + Ayarlar'da "Senkronizasyon" bölümü, cihaz listesi, çakışma girişi, E2EE güvence dili. Task row'da hafif "senkronlanmadı" işareti. Alt bar değişmez.
- **Cihaz ekleme** (`15-device-pairing.png`): QR + manuel kod ile eşleştirme, süreli kod. **E2EE kurtarma anahtarı** (`16-recovery-key.png`): 12-blok anahtar, kopyala, "kaybedersen kurtarılamaz" uyarısı — MVP kasa kurulumu diliyle tutarlı.
- **Self-host / SaaS bağlantı** (`17-server-connection.png`): mod seçimi (Yalnızca yerel / Self-host / SaaS), sunucu URL, bağlantı testi (latency + TLS). Onboarding'e zorunlu adım eklenmez — opt-in.
- **Multi-user / roller** (`18-roles-members.png`, `19-workspace-assignment.png`): başlıkta workspace switcher (Kişisel/Aile), task row'a **atama avatarı** (role/member chip) + "Ata" aksiyonu, üye avatar yığını. Ayarlar → "Roller & üyeler" (owner/admin/member/viewer + davet). Kişisel alan varsayılan ve tam offline kalır.
- **Gelişmiş istatistik** (`20-advanced-stats.png`): dönem seçimi (Hafta/Ay/Çeyrek/Yıl), etiket bazlı dağılım çubuğu, kişi başına tamamlama kırılımı. Aynı metrik kart dili büyür; hesaplama yerel, yalnızca şifreli toplamlar paylaşılır.
- **İleri tema sistemi** (`21-theme-store.png`): "Tema mağazası / içe-dışa aktar" — etkin tema + topluluk temaları + `.json` import. Token seti semantik olduğu için tema paketleri sadece eşleme dosyasıdır; layout/kontrast korunur.
- **Sync conflict durumu** (`22-sync-conflict.png`): iki cihaz sürümü yan yana, "Seçileni tut / İkisini de tut".
- **Dark parite** (`23-faz2-dark-parity.png`): Sync, Roller, Sunucu, Gelişmiş istatistik koyu temada — tek token seti, iki harita.

---

## 6. Faz 3 genişleme notları

MVP ve Faz 2 bozulmadan eklenir. **Bu faz için de tam ekran tasarımları mevcuttur** (`screens/24`–`34`); AI yüzeyleri mor aksanla (#8878C9→#A594E0) ayrışır, human-in-the-loop kesikli kenarlık her iki temada korunur.

- **AI komut girişi** (`24-ai-command-bar.png`): FAB'a basılı tutma veya "/" → komut yüzeyi (metin / ses / görsel modları + önerilen promptlar). Ana ekran temiz kalır; AI bir *giriş modu*dur, ayrı sekme değil.
- **Human-in-the-loop onay** (`25-ai-approval.png`): üretilen görevler **öneri kartı**yla gelir (kesikli task row + "Öneri" rozeti + Reddet/Düzenle/Onayla). Onaylanmadan kalıcı yazılmaz — PRD gizlilik prensibiyle birebir. Ana listedeki bekleyen hali: `33-ai-pending.png`.
- **Ses girdisi** (`26-voice-input.png`): dalga formu + canlı transkript + "ses cihazda işlenir, kayıt saklanmaz" güvencesi. **Görsel/kamera girdisi** (`27-image-input.png`): fotoğraftan madde çıkarımı → seçilebilir öneri listesi. İzin reddi MVP kalıbıyla anlatılır.
- **Agent / plugin yönetimi** (`28-agent-plugin.png`): Ayarlar → "Otomasyon": yüklü ajanlar, izin kapsamı (scope) çipleri, etkinleştir/duraklat, audit log. Varsayılan hiçbir ajan otonom değildir.
- **API key & webhook** (`29-api-webhook.png`): token oluştur/scope/iptal, webhook endpoint + event aboneliği (toggle), rate limit görünürlüğü.
- **AI davranışı** (`30-system-prompt.png`): sağlayıcı seçimi (Yerel/Bulut), özelleştirilebilir system prompt, **bağlam penceresi** kontrolü (AI hangi veriyi görür — notlar varsayılan gizli).
- **Görev ağacı / DAG** (`31-task-tree-dag.png`): bağımlılık düğümleri + bağlantı çizgileri + durum (bitti/sürüyor/kilitli) skill-tree görünümü. **Task dependency node** bileşeni (bkz. §8). Veri modeli MVP'de zaten bağımlılığa hazır (FR-018).
- **Opsiyonel oyunlaştırma** (`32-gamification.png`): İstatistik içinde sessiz katman; seviye/XP/rozet opt-in toggle, leaderboard varsayılan kapalı + yerel; ana günlük akışa girmez.
- **Dark parite** (`34-faz3-dark-parity.png`): AI onay, Agent, System prompt, İlerleme koyu temada.

---

## 7. Durum tasarımları

| Durum | UI davranışı | Örnek mikro metin |
| --- | --- | --- |
| **Empty** | Sakin illüstrasyonsuz mesaj + tek net aksiyon | "Bugün için görev yok. + ile ekle." / "Havuz boş." |
| **Loading** | İskelet satırlar (spinner yerine), kasa açılırken kilit animasyonu | "Kasa açılıyor…" |
| **Offline** | Durum çubuğunda sessiz "ÇEVRİMDIŞI"; hiçbir çekirdek işlev kilitlenmez | "Çevrimdışı — her şey çalışıyor, senkron sonra." (Faz 2) |
| **Error** | Inline, yıkıcı olmayan; veri korunur | "Bir şey ters gitti. Verilerin güvende." |
| **Success** | Kısa, geçici toast + geri al | "Görev eklendi · Geri al" |
| **Permission denied** | Neden + nasıl açılacağı; işlevi tamamen kesmez | "Bildirim izni kapalı. Ayarlar'dan açabilirsin." |
| **Locked vault** | Tam ekran kilit; yalnızca aç akışı | "Kasa kilitli. Devam etmek için aç." |
| **Import error** | Hangi satır/alan sorunlu; mevcut veri bozulmaz | "3. satır okunamadı. Diğer 128 kayıt hazır — yine de içe aktar?" |
| **Metadata fetch failed** | Görev kaydı başarısız olmaz; link ham kalır | "Başlık alınamadı — bağlantı olduğu gibi saklandı." |
| **Sync conflict** (Faz 2) | İki sürümü yan yana, kullanıcı seçer/birleştirir | "Bu görev iki cihazda değişti. Hangisini tutalım?" |
| **AI suggestion pending** (Faz 3) | Öneri kartı, onaya kadar kalıcı değil | "Öneri — sen onaylamadan eklenmez." |

---

## 8. Component sistemi ve faz genişlemesi

| Component | MVP tanımı | Faz 2 genişlemesi | Faz 3 genişlemesi |
| --- | --- | --- | --- |
| **Task row/card** | Checkbox + öncelik noktası + başlık + meta çipleri | + atama avatarı, senkron işareti | + AI "Öneri" rozeti, bağımlılık göstergesi |
| **Priority/effort indicator** | Renkli nokta (P1 red / P2 amber / P3 gri) + opsiyonel effort barı | filtre/sıralama kriteri | AI'nın önerdiği öncelik ipucu |
| **Tag chip** | Renkli, düşük doygunluk, tıklanınca filtre | paylaşılan/kişisel etiket ayrımı | AI otomatik etiketleme önerisi |
| **Recurrence badge** | "Her gün / Her hafta Pzt" küçük çip + döngü ikonu | — | akıllı tekrar önerisi |
| **Deadline warning** | Amber→red eskalasyon çipi ("Son 2 gün") | — | risk tahmini |
| **Subtask row** | Checkbox + başlık + ilerleme | atama | DAG düğümüne dönüşebilir |
| **Bottom sheet form controls** | Segment, stepper, radio, satır, NLP input | sync/rol alanları | ses/görsel/komut girdisi |
| **Calendar / date picker** | Ay/hafta + gün noktaları | çok kişi katman | AI planlama önerisi overlay |
| **Settings rows/toggles** | Satır + toggle + segment + değer/chevron | Sync, Cihazlar, Roller bölümleri | Otomasyon, AI, API bölümleri |
| **Privacy/security status** | "Uçtan uca şifreli · Yerel" banner + status | sync güven durumu, cihaz güveni | AI veri sınırı göstergesi |
| **Sync status badge** | *(yok — Faz 2'de doğar)* | üst bar rozeti + Ayarlar durumu | — |
| **Role/member chip** | *(yok — Faz 2'de doğar)* | avatar + rol rengi | AI ajan "kimlik" çipi |
| **AI suggestion preview** | *(yok — Faz 3'te doğar)* | — | öneri kartı + Onayla/Düzenle/Reddet |
| **Task dependency node** | *(veri hazır, UI yok)* | — | DAG/skill-tree düğümü + bağlantı çizgisi |

**İlke:** hiçbir bileşen sonraki fazda sıfırdan yazılmaz; hepsi MVP dilinin üstüne katman ekler.

---

## 9. Design tokens (Light & Dark)

### 9.1 Color tokens
| Token | Light | Dark | Kullanım |
| --- | --- | --- | --- |
| `--bg` | `#FAF9F6` | `#1B1815` | Ekran zemini |
| `--surface` | `#FFFFFF` | `#242019` | Kart, satır |
| `--surface-sunken` | `#F1EFEA` | `#151310` | Segment yuvası, input |
| `--ink-1` | `#26231F` | `#ECE8E1` | Birincil metin |
| `--ink-2` | `#6A645C` | `#ABA398` | İkincil metin |
| `--ink-3` | `#9C958B` | `#6F6A61` | Placeholder, pasif |
| `--border` | `#E6E2DA` | `#34302A` | Kart/divider |
| `--primary` | `#2C7D6D` | `#4FB39A` | Aksiyon, tamamlama |
| `--primary-tint` | `#E4F1ED` | `#17332C` | Primary zemin |
| `--warning` | `#B7791F` | `#D9A441` | Deadline yaklaşıyor |
| `--danger` | `#B4442F` | `#D9694F` | Yüksek öncelik, hata |
| **Öncelik** | P1 `#B4442F` · P2 `#B7791F` · P3 `#9C958B` | koyu paritesi | Nokta göstergesi |

Accent'ler tek chroma/lightness ailesinde; nötrler hafif sıcak (saturasyon ≤ 0.02).

### 9.2 Typography scale
| Rol | Boyut / satır | Ağırlık | Font |
| --- | --- | --- | --- |
| Display (ekran başlığı) | 28 / 30 | 700 | Hanken Grotesk |
| Title | 24 / 29 | 700 | Hanken Grotesk |
| Section | 20 / 24 | 700 | Hanken Grotesk |
| Body | 15 / 22 | 400–500 | Hanken Grotesk |
| Body-strong | 15 / 22 | 600 | Hanken Grotesk |
| Caption | 12–13 / 16 | 500 | Hanken Grotesk |
| Meta/mono (saat, kod, etiket başlığı) | 11–12 / 16 | 500 | IBM Plex Mono |

### 9.3 Spacing scale
`4 · 8 · 12 · 16 · 20 · 24 · 32` (4px tabanı). Satır içi padding 13–14px, kartlar arası 8px, bölümler arası 16px, ekran kenar boşluğu 18–22px.

### 9.4 Radius
`6` (küçük çip/checkbox) · `10–12` (input, satır, buton) · `14` (kart) · `16` (FAB) · `26` (bottom sheet üst köşe) · `40` (cihaz çerçevesi).

### 9.5 Shadow / elevation
- **e0:** yok (düz satır, border ile ayrım).
- **e1:** `0 1px 3px rgba(0,0,0,.08)` — seçili segment, hafif kalkma.
- **e2 (FAB):** `0 8px 18px -6px rgba(44,125,109,.6)`.
- **e3 (sheet/modal):** `0 -12px 40px -12px rgba(0,0,0,.30)`.
Gölge minimum; hiyerarşi öncelikle **border + zemin tonu** ile kurulur.

### 9.6 Divider kuralları
Kart içi ayrım: `1px` `--border` (light `#F1EFEA` iç çizgi, dış `#E6E2DA`). Bölümler arasında çizgi yerine boşluk + mono başlık. Divider'lar tam genişlik değil, içerik hizasında.

### 9.7 Icon stili
2px stroke, yuvarlatılmış uç/köşe, `currentColor`, 18–24px. Dolgu yalnızca durum noktaları için. Emoji sadece nötr/duygusal işaret gerektiğinde çok sınırlı (ör. seri 🔥) — marka değil.

### 9.8 Density modes
- **Default:** satır yüksekliği ~68px, cömert padding.
- **Compact:** satır ~52px, meta çipleri tek satıra sıkışır, bölüm başlıkları inceltilir. Ayarlar → Görünüm → Yoğunluk. (Power-user ihtiyacını buradan karşılar.)

---

## 10. Flutter uygulanabilirlik ve erişilebilirlik

### 10.1 Flutter'da riskli/dikkat gereken kararlar
- **Bottom sheet + NLP input:** `showModalBottomSheet` + klavye ile birlikte yükselen içerik; `MediaQuery.viewInsets` yönetimi gerekir. Riskli değil ama klavye/parse çipi senkronu test edilmeli.
- **Swipe aksiyonları:** `Dismissible` veya `flutter_slidable`; **her swipe'ın görünür buton alternatifi** zorunlu (erişilebilirlik + keşif).
- **Segment / stepper / radio:** yerel Cupertino/Material yerine token'lı custom widget; iki tema için tek kaynak.
- **Backdrop blur (alt bar `backdrop-filter`):** Flutter'da `BackdropFilter` maliyetli olabilir — düşük uçlu cihazda düz yarı saydam zemine düşülebilir (performans NFR: <1sn açılış).
- **Canlı tarih önizlemesi & NLP:** yerel Türkçe ayrıştırma cihaz timezone'una duyarlı olmalı; DST/timezone değişimi görsel uyarı ister (PRD edge case).
- **Şifreli DB (SQLCipher):** UI değil ama form akışı (kasa kurulumu/kilit) bu katmana bağlı; loading/error state'leri gerçek gecikmelere göre tasarlandı.
- **Heatmap/grafik:** özel çizim (`CustomPainter`) veya hafif paket; MVP'de basit barla sınırlı tutuldu.

### 10.2 Erişilebilirlik notları
- **Ekran okuyucu:** her ikon-buton `Semantics` label'lı; checkbox durumu ("tamamlandı/tamamlanmadı") sesli; tarih seçici buton-erişilebilir.
- **Kontrast:** metin/zemin ≥ WCAG AA; öncelik yalnızca renge bağlı değil — şekil/etiket ile de ayrışır (renk körlüğü).
- **Büyük metin:** `textScaleFactor`'a makul uyum; satırlar sarılabilir, kesme yok; sabit yükseklikler yerine min-height.
- **Tek elle kullanım:** birincil aksiyonlar (FAB, tamamla, aç) alt %60'ta; üst köşe yalnızca ikincil.
- **Dokunma hedefi:** ≥ 44×44px (checkbox görsel 22px ama hit alanı 44px).
- **Hareket:** "reduce motion" ile sheet/geçişler sadeleşir.

### 10.3 Mobile-first → desktop/web uyarlaması
- Alt bar → **sol kenar rail**; FAB → rail üstünde "+" veya klavye kısayolu.
- Tek kolon → **iki/üç kolon** (liste + detay + opsiyonel takvim), master-detail.
- Bottom sheet → **sağ yan panel** veya orta modal.
- Compact density masaüstünde varsayılan olabilir; token seti aynı kalır, yalnızca layout kırılımları eklenir. MVP kararları mobil önceliği korur.
- Bu bölüm resmi MVP PC/desktop release taahhüdü değildir; scaffold sonrası desktop/web smoke build ile uyumluluk riski izlenir.

---

## 11. Repo çıktısı

- **Özet dokümanı:** `docs/design/claude-v1/design-summary.md` (bu dosya).
- **Codex handoff / README:** `docs/design/claude-v1/README-handoff.md` (tüm çıktı haritası + son iş).
- **UX akışları:** `docs/project/ux-flows.md` (F1–F16 taslağı, `$ux-flow-planner` girdisi).
- **Flutter token'ları:** `docs/design/claude-v1/flutter/free_task_theme.dart` (§9 → ThemeData).
- **Kontakt föyü:** `docs/design/claude-v1/contact-sheet.html` (36 ekran, basılabilir, A3 yatay).
- **Ekranlar:** `docs/design/claude-v1/screens/` (01–36 PNG).
- **Ekranlar:** `docs/design/claude-v1/screens/`
  - Brief listesi: `01-vault-setup.png` · `02-today.png` · `03-add-task.png` · `04-task-detail.png` · `05-repeat-editor.png` · `06-settings.png` · `07-phase-expansion-map.png`
  - Ek MVP ekranları: `08-stats.png` (İstatistik) · `09-locked-vault.png` (Kasa kilitli) · `10-pool.png` (Havuz) · `11-calendar.png` (Takvim)
  - Referans levhaları: `12-states.png` (durum tasarımları) · `13-dark-parity.png` (dark parite seti)
  - **Faz 2 ekranları:** `14-sync-status` · `15-device-pairing` · `16-recovery-key` · `17-server-connection` · `18-roles-members` · `19-workspace-assignment` · `20-advanced-stats` · `21-theme-store` · `22-sync-conflict` · `23-faz2-dark-parity`
  - **Faz 3 ekranları:** `24-ai-command-bar` · `25-ai-approval` · `26-voice-input` · `27-image-input` · `28-agent-plugin` · `29-api-webhook` · `30-system-prompt` · `31-task-tree-dag` · `32-gamification` · `33-ai-pending` · `34-faz3-dark-parity`
- **Yaşayan tasarım (interaktif, tüm ekranlar + token + harita):** `free-task Design.dc.html` (proje kökü).
- **İnteraktif prototipler:** `free-task Prototype.dc.html` (MVP), `free-task AI Prototype.dc.html` (Faz 3 AI-onay), `free-task Sync Prototype.dc.html` (Faz 2 sync).

---

## Codex'e geri verilecek tasarım özeti

> UX flow dokümanına (`docs/project/ux-flows.md`, `$ux-flow-planner`) ve sonraki Codex adımlarına aktarılacak kararlar.

**Ürün yönü & prensipler**
- Tasarım yönü **Quiet Productivity**; power-user ihtiyacı ayrı yön değil, **compact density toggle** ile karşılanır.
- North star: **"Sessiz güven"** — offline + yerel şifreli + dikkat dağıtmayan.
- Tüm renkler **semantik token**; light/dark tek set, iki eşleme. Font: **Hanken Grotesk + IBM Plex Mono**.

**Navigasyon (fazlar arası sabit omurga)**
- MVP: **alt bar 4 sekme (Bugün · Takvim · Havuz · Ayarlar) + merkez FAB**. İstatistik = Bugün üst barından.
- Faz 2: alt bar aynı; başlıkta **workspace switcher**, üst barda **sync rozeti**; yeni yüzeyler **Ayarlar** altında.
- Faz 3: **AI komut çubuğu FAB'a basılı tutma / "/"**; öneriler **human-in-the-loop onay kartı**; API/agent Ayarlar → Otomasyon; DAG görev detayından.
- Kural: yeni güç → önce **Ayarlar veya komut yüzeyi**, ana bara değil.

**MVP ekran akış kararları (ux-flow için)**
1. İlk açılış → **zorunlu kasa kurulumu** (parola + kurtarma anahtarı + opsiyonel biyometrik) → Bugün.
2. Locked vault her açılışta/otomatik kilitten sonra; biyometrik → parola fallback → kurtarma.
3. Ekleme akışı **NLP-first** (yarın 15:00 …), parse çipleri düzenlenebilir; tip: zaman aralıklı / zamansız(havuz) / tekrar / deadline.
4. Tekrar kuralı ayrı bottom sheet; **canlı "Sonraki" önizlemesi**; geçersiz kural kaydı engeller (veri bozmaz).
5. Görev detay: alt görev ilerlemesi ana görevi etkiler; **link metadata opsiyonel ve hataya dayanıklı**.
6. Tamamlanan görev davranışı (gizle / üstü çiz) **anında** uygulanır (ayar).

**Durum & hata dili (test-plan + copy için)**
- Empty/Loading/Offline/Error/Success/Permission-denied/Locked-vault/Import-error/Metadata-fetch-failed hepsi tanımlı (§7).
- Yıkıcı olmayan hata + **"verilerin güvende"** güvencesi standart.
- Offline hiçbir çekirdek işlevi kilitlemez (FR-010).

**Güvenlik/gizlilik dili ($data-permissions için)**
- E2EE dili sabit: **"Uçtan uca şifreli · Yerel — verilerin bu cihazdan çıkmıyor."**
- Kurtarma anahtarı UX'i teknik tasarımda netleşecek **açık soru** (parola unutma → veri kaybı riski kullanıcıya net gösterilir).
- Faz 2 rolleri (owner/admin/member/viewer) ve sync güven modeli component olarak hazır (role/member chip, sync badge).

**Component & token teslimi ($technical-design için)**
- 14 çekirdek component + faz genişleme yolu tanımlı (§8); hiçbiri sonraki fazda yeniden yazılmaz.
- Token tablosu (§9) doğrudan Flutter theme'e map edilebilir; density modes iki satır yüksekliği.
- Flutter riskleri işaretli (§10.1): backdrop blur performansı, swipe+buton paritesi, NLP timezone, şifreli DB'ye bağlı loading/error.

**Karara bağlanan sorular (PRD §21 ile hizalı)**
- UI dili: Türkçe + İngilizce.
- Yerel bildirimler: MVP'de opt-in, cihaz içi local notifications.
- Kurtarma/şifre modeli: parola + biyometrik + kurtarma anahtarı.
- Platform önceliği: Android + iOS eş zamanlı.
- PC/desktop uyumluluğu: resmi MVP release değil; mimari/tasarım uyumu korunur ve desktop/web smoke build sonucu notlanır.

**Faz 2 & Faz 3 tam ekranları (yeni — artık not değil, tasarım)**
- Faz 2 (`screens/14`–`23`) ve Faz 3 (`screens/24`–`34`) için tam görsel ekranlar üretildi; `$technical-design` ve `$ux-flow-planner` bunları doğrudan referans alabilir.
- Faz 2 sync/rol/kişi kırılımı ve E2EE kurtarma dili ekranlara işlendi; `$data-permissions` için rol matrisi (owner/admin/member/viewer) ve bağlam-penceresi kararları (`30-system-prompt`) görselde hazır.
- Faz 3 human-in-the-loop ilkesi görselleştirildi: öneriler kesikli kenarlıklı, onaya kadar sayımlara girmez (`25`, `33`). AI mor aksanı (#8878C9→#A594E0) tek yerde tanımlı.
- Faz haritası (screen 07) her fazın hangi ekran numaralarına karşılık geldiğini gösterir.

**İnteraktif prototipler (davranış referansı — $ux-flow-planner & $implementation-plan için)**
- `free-task Prototype.dc.html` — MVP: sekme geçişleri, görev tamamlama, NLP ekleme sheet'i, detay + alt görev ilerlemesi, havuzdan bugüne çekme, ayar→liste yansıması. Etkileşim/animasyon zamanlaması buradan alınabilir.
- `free-task AI Prototype.dc.html` — Faz 3 AI-onay akışı: komut → "düşünme" → kesikli öneriler → tek tek reddet / toplu onayla → onaylananlar "✦ AI ekledi" etiketiyle listeye düşer. **Onaylanmayan öneri listeye kalıcı yazılmaz** (human-in-the-loop davranışı çalışır halde; `35-ai-prototype-flow.png` durağan kare).
- Toplam çıktı: 35 ekran PNG + 3 DC dosyası + bu özet. Tümü `docs/design/claude-v1/`.

**Sonraki Codex sırası:** `$ux-flow-planner` → `$technical-design` → `$data-permissions` → `$implementation-plan` → `$test-plan` → `$launch-plan`.
