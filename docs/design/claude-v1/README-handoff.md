# free-task — Tasarım Teslimatı (claude-v1) · Codex Handoff

> **▶ CODEX: BURADAN BAŞLA.** Bu dosya tüm çıktıların giriş noktasıdır. Şu sırayla oku: (1) bu README, (2) `design-summary.md` (ana referans), (3) `docs/project/ux-flows.md` (akışlar). Sonra `$ux-flow-planner` ile başla. **PRD faz kapsamını koru.** §6'daki kararları kaynak kabul et; yeni varsayımla MVP kapsamını büyütme.

> **Kim için:** Codex (sonraki planlama/uygulama ajanı) ve insan paydaşlar.
> **Ne:** free-task ürününün tam tasarım omurgası + MVP/Faz 2/Faz 3 ekranları + interaktif prototipler + Flutter token'ları.
> **Kaynak gerçeklik:** `docs/project/prd.md` + `docs/project/claude-design-brief.md` (bunların dışında varsayım yapılmadı; PRD faz kapsamı korundu).

---

## 1. Bu teslimatta ne var?

| Dosya / klasör | İçerik | Codex için rolü |
|---|---|---|
| `docs/design/claude-v1/design-summary.md` | 11 bölümlük ana tasarım dokümanı + Codex handoff özeti | **Ana referans.** Yön, IA, navigasyon, ekran spec'leri, durumlar, componentler, tokenlar, Flutter/erişilebilirlik notları |
| `docs/design/claude-v1/screens/` (01–36 PNG) | Tüm ekranların yüksek çözünürlüklü görselleri | Görsel doğruluk referansı |
| `docs/design/claude-v1/contact-sheet.html` | 36 ekranın tek sayfalık basılabilir kontakt föyü | Paydaş sunumu / hızlı genel bakış (Yazdır → PDF, A3 yatay) |
| `docs/design/claude-v1/flutter/free_task_theme.dart` | Design token'larının Flutter `ThemeData` karşılığı | `$implementation-plan` / geliştirme başlangıcı |
| `docs/project/ux-flows.md` | 16 UX akışının taslağı (F1–F16) | `$ux-flow-planner` girdisi |
| `free-task Design.dc.html` (proje kökü) | Tüm 34 ekranın canlı, zoom'lanabilir tasarım tuvali | İnteraktif inceleme |
| `free-task Prototype.dc.html` | MVP tıklanır prototip | Davranış/etkileşim referansı |
| `free-task AI Prototype.dc.html` | Faz 3 AI-onay akışı (çalışır) | Human-in-the-loop davranışı |
| `free-task Sync Prototype.dc.html` | Faz 2 sync/cihaz/çakışma akışı (çalışır) | Sync davranışı |

---

## 2. Ekran haritası (36 görsel)

**MVP (01–13):** 01 kasa kurulumu · 02 Bugün · 03 görev ekle · 04 görev detayı · 05 tekrar kuralı · 06 Ayarlar · 07 faz haritası · 08 İstatistik · 09 kasa kilitli · 10 Havuz · 11 Takvim · 12 durum tasarımları · 13 dark parite.

**Faz 2 — Sync & ekip (14–23):** 14 sync durumu · 15 cihaz eşleştirme · 16 kurtarma anahtarı · 17 sunucu bağlantısı · 18 roller & üyeler · 19 workspace + atama · 20 gelişmiş istatistik · 21 tema mağazası · 22 sync conflict · 23 Faz 2 dark parite.

**Faz 3 — AI & platform (24–34):** 24 AI komut çubuğu · 25 AI onay kartı · 26 ses girişi · 27 görsel girişi · 28 agent/plugin · 29 API & webhook · 30 AI davranışı · 31 görev ağacı/DAG · 32 oyunlaştırma · 33 AI pending · 34 Faz 3 dark parite.

**Prototip kareleri (35–36):** 35 AI-onay akışı · 36 sync akışı.

---

## 3. Codex'in bilmesi gereken sabit kararlar

- **Yön:** Quiet Productivity. Power-user ihtiyacı ayrı yön değil, **compact density toggle** ile karşılanır.
- **Navigasyon omurgası (her fazda sabit):** alt bar 4 sekme (Bugün · Takvim · Havuz · Ayarlar) + merkez FAB. Yeni güç → Ayarlar veya komut yüzeyi, ana bara değil.
- **Task row** her fazda temel birim; genişleme katman ekler (atama avatarı → Faz 2, AI rozeti/DAG düğümü → Faz 3).
- **Renk sistemi:** tek semantik token seti, iki tema haritası. Faz aksanları: MVP yeşil `#2C7D6D`, Faz 2 amber `#B7791F`, Faz 3 mor `#6D5AB7`/`#8878C9`.
- **Güven dili sabit:** "uçtan uca şifreli · yerel — verilerin bu cihazdan çıkmıyor." Offline hiçbir çekirdek işlevi kilitlemez.
- **Human-in-the-loop:** AI önerileri kesikli kenarlıkla gelir; onaylanmadan listeye kalıcı yazılmaz, sayımlara girmez.
- **Font:** Hanken Grotesk (gövde) + IBM Plex Mono (etiket/saat/kod).

---

## 4. Son turda eklenenler (bu handoff'un yeni kısmı)

Önceki teslimata (35 PNG + summary + 2 prototip) ek olarak:
- **`free-task Sync Prototype.dc.html`** — Faz 2 sync akışı artık tıklanır: senkronla (spinner→güncel), çevrimdışı simülasyonu, cihaz ekleme (QR→el sıkışma→eklendi), çakışma çözümü. Kare: `screens/36`.
- **`flutter/free_task_theme.dart`** — §9 token tablosunun birebir Flutter karşılığı (FtColors, FtSpacing, FtRadius, FtType, FtTheme.light()/dark()).
- **`contact-sheet.html`** — 36 ekranlık basılabilir kontakt föyü.
- **`docs/project/ux-flows.md`** — 16 akışlık UX taslağı (`$ux-flow-planner` doğrudan buradan devam edebilir).
- **Bu dosya** (`README-handoff.md`) — tüm çıktı haritası.

Codex bu turda yapılanların **hepsini** görebilir: her ekran PNG + summary'de referanslı, prototipler dosya olarak mevcut, akışlar `ux-flows.md`'de, tokenlar `.dart`'ta.

---

## 5. Önerilen sonraki Codex sırası

`$ux-flow-planner` (girdi: `ux-flows.md`) → `$technical-design` (girdi: `design-summary.md` §8/§10 + `free_task_theme.dart`) → `$data-permissions` (E2EE/rol/kurtarma: summary §1.4, ekran 16/18/30) → `$implementation-plan` → `$test-plan` (durumlar: summary §7, ekran 12) → `$launch-plan`.

## 6. Karara bağlanan sorular (PRD §21 ile hizalı)

Bu dört konu 2026-07-04 tarihinde kullanıcı tarafından yanıtlandı ve `docs/project/ux-flows.md` §2 ile sonraki planlama dokümanlarına işlendi.

1. **UI dili:** Türkçe + İngilizce.
2. **Yerel bildirimler:** MVP'ye dahil, opt-in ve cihaz içi local notifications.
3. **Kurtarma/parola modeli:** Parola + biyometrik + kurtarma anahtarı.
4. **Platform önceliği:** Android + iOS eş zamanlı.
5. **PC/desktop uyumluluğu:** Resmi MVP release değil; mimari ve tasarım uyumluluğu korunur, scaffold sonrası desktop/web smoke build sonucu notlanır.
