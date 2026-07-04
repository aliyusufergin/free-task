# Implementation Plan: free-task

## 1. Kaynak Artifact'ler

| Artifact | Yol | Rol |
| --- | --- | --- |
| PRD | `docs/project/prd.md` | Urun kapsami ve faz sinirlari |
| UX flows | `docs/project/ux-flows.md` | Ekranlar, akışlar, durumlar |
| Technical design | `docs/project/technical-design.md` | Stack, mimari, integration sinirlari |
| Data permissions | `docs/project/data-permissions.md` | Veri modeli, E2EE, roller, retention |
| Design summary | `docs/design/claude-v1/design-summary.md` | Gorsel yon, component, token, faz genislemesi |
| Flutter tokens | `docs/design/claude-v1/flutter/free_task_theme.dart` | Tema baslangici |

## 2. Teslim Varsayimlari

- Ekip: solo gelistirici varsayimi.
- Zaman: sabit tarih yok; risk-first milestone ilerleyisi.
- Release hedefi: once dogfooding MVP, sonra kapali beta.
- Platform: Android + iOS es zamanli.
- PC/desktop: resmi MVP release hedefi degil; scaffold sonrasi desktop/web smoke build ile uyumluluk korunur.
- Dil: Turkce + Ingilizce.
- MVP'de backend yok.
- MVP'de remote auth, SaaS, self-host sync, AI, API ve multi-user yok.
- Network gerektiren paket kurulumlari ve push/issue islemleri onayli yapilacak.

## 3. Milestone'lar

| Milestone | Goal | Exit Criteria | Dependencies |
| --- | --- | --- | --- |
| M0 Repo ve planlama temeli | Planlama artifact'lerini ve tasarim teslimatini repo icine almak | PRD, UX, tech, data, design dosyalari repo icinde | Mevcut dokumanlar |
| M1 Flutter scaffold ve temel app shell | Android+iOS Flutter projesi, tema, localization, nav shell | App acilir, light/dark tema ve TR/EN calisir; desktop/web smoke build denenir | Flutter SDK, paket kurulumu |
| M2 Sifreli kasa spike | SQLCipher + key wrapping + biyometrik + recovery key doğrulama | Android+iOS cihaz/simulator uzerinde kasa ac/kapat/migrate smoke test | M1 |
| M3 Core data ve task domain | Task, subtask, recurrence, reminder, preference schema/repository | Unit testlerle CRUD ve recurrence geciyor | M2 |
| M4 MVP UI vertical slice | Kasa kurulumu -> Bugun -> gorev ekle -> tamamla akisi | Tek kullanici gercek gunluk akisi calisir | M1-M3 |
| M5 Import/export ve local notifications | JSON/Markdown export, free-task import, local reminders | Izin reddi ve offline durumlari testli | M3-M4 |
| M6 UX polish ve erişilebilirlik | Claude ekranlarına yakin UI, screen reader, buyuk metin, density | Ana ekranlar tasarim referansina uyumlu | M4-M5 |
| M7 Beta hardening | Migration, veri kaybi, performans, crash/local diagnostics | Dogfooding build'i guvenle kullanilabilir | M1-M6 |
| M8 Faz 2/3 hazirlik sinirlari | Sync/AI/API adapter interface'leri ve feature flag iskeleti | MVP sisirmeden genisleme sinirlari dokumante | M7 |

## 4. Dependency Map

- M1, tum uygulama kodunun temelidir.
- M2, M3'ten once gelmelidir; veri modeli sifreli storage gercegiyle test edilmeden CRUD yazilmaz.
- M3, M4 UI vertical slice'in veri kaynagidir.
- M5, M4'ten sonra gelir; cunku import/export ve bildirim task modeline baglidir.
- M6, M4/M5 calisir hale gelmeden baslamaz.
- M7, gercek kullanima hazirliktir.
- M8, MVP'yi sisirmeden sadece arayuz/sinir hazirligi yapar.

## 5. Work Breakdown

| ID | Area | Task | Kaynak | Depends On | Acceptance |
| --- | --- | --- | --- | --- | --- |
| SET-01 | Repo | `.gitignore`, README, license karari, docs linkleri | Pipeline, repo setup | Yok | Repo temel dosyalari var, secrets ignore edilir |
| SET-02 | Flutter | `apps/free_task_flutter/` scaffold | Tech §2 | SET-01 | Android/iOS app smoke run |
| SET-03 | Flutter | Dependency policy ve `pubspec.yaml` | Tech §4 | SET-02 | Lockfile commit'e hazir |
| SET-04 | CI | Format/analyze/test workflow taslagi | Tech §10 | SET-02 | Local komutlar ve GitHub Actions taslagi |
| SET-05 | Flutter | Desktop/web smoke build kontrolu | Tech §4/10 | SET-02 | Resmi release hedefi olmadan PC/web derleme riski notlanir |
| DES-01 | Design | Claude tokenlarini app theme'e entegre et | Design summary §9 | SET-02 | Light/dark tema calisir |
| DES-02 | i18n | `app_tr.arb`, `app_en.arb`, locale switch | UX §2 | SET-02 | Dil runtime degisir |
| SEC-01 | Vault | SQLCipher spike | Tech §7 | SET-02 | Encrypted DB Android+iOS ac/kapat |
| SEC-02 | Vault | Password KDF ve key wrapping spike | Data §3/8 | SEC-01 | Plaintext key kalici saklanmaz |
| SEC-03 | Vault | Biyometrik unlock | UX F2 | SEC-02 | Biyometrik -> parola fallback |
| SEC-04 | Vault | Kurtarma anahtari create/verify | Data §5 | SEC-02 | Recovery key dogrulama testli |
| DAT-01 | Data | Task schema ve repositories | PRD §12 | SEC-01 | CRUD unit test |
| DAT-02 | Data | Subtask/tag/link/attachment schema | PRD §12 | DAT-01 | Iliskiler testli |
| DAT-03 | Data | Recurrence ve occurrence hesaplama | PRD FR-008 | DAT-01 | Tekrar testleri geciyor |
| DAT-04 | Data | Reminder model ve scheduling interface | UX F9 | DAT-01 | Izin yokken no-op |
| UI-01 | UI | App shell, alt bar, FAB, routes | UX §5 | SET-02, DES-01 | 4 sekmeli nav calisir |
| UI-02 | UI | Kasa kurulumu ve locked vault | UX F1/F2 | SEC-03, SEC-04 | Onboarding -> Bugun |
| UI-03 | UI | Bugun listesi ve task row | Design screen 02 | DAT-01 | Tamamla/geri al calisir |
| UI-04 | UI | Yeni gorev bottom sheet + parser cipleri | UX F3 | DAT-01 | Gorev ekleme vertical slice |
| UI-05 | UI | Gorev detay ve alt gorevler | UX F4 | DAT-02 | Alt gorev progress calisir |
| UI-06 | UI | Tekrar editoru | UX F3/F6 | DAT-03 | Canli preview ve validation |
| UI-07 | UI | Havuz ve Takvim | UX F5/F6 | DAT-01, DAT-03 | Havuzdan bugune cekme |
| UI-08 | UI | Ayarlar, dil, tema, density | UX F8 | DES-02 | Ayarlar aninda yansir |
| NOT-01 | Notifications | Local notification permission UX | UX F9 | DAT-04 | Izin akisi platformlarda calisir |
| NOT-02 | Notifications | Reminder scheduling/reschedule/cancel | UX F9 | NOT-01 | Ertele/sil iptal davranisi testli |
| IMP-01 | Import/export | JSON export ve sifreli backup taslagi | Data §11 | DAT-01 | Export tekrar okunabilir |
| IMP-02 | Import/export | Markdown export | PRD FR-011 | IMP-01 | Insan okunabilir dosya |
| IMP-03 | Import/export | free-task JSON import + dry run | PRD FR-012 | IMP-01 | Hata raporu ve rollback |
| STA-01 | Stats | Basit istatistik ozeti | UX F7 | DAT-01 | Yerel metrikler dogru |
| QA-01 | QA | Unit/widget/integration test iskeleti | Test plan | SET-02 | Test komutlari calisir |
| QA-02 | QA | Accessibility ve localization testleri | UX §13 | UI-01..UI-08 | Buyuk metin ve TR/EN testli |
| REL-01 | Release | Android internal build | Tech §10 | M7 | Install edilebilir build |
| REL-02 | Release | iOS TestFlight hazirligi | Tech §10 | M7 | Archive/TestFlight checklist |
| FUT-01 | Future | Sync adapter interface ve feature flag | Tech §5.8 | M7 | MVP'de disabled |
| FUT-02 | Future | AI/agent/API adapter interface ve scope placeholder | Tech §5.9 | M7 | MVP'de disabled |

## 6. Dependency ve Repository Setup

Yapilacaklar:

- Flutter SDK surumu secilecek ve README'de yazilacak.
- `apps/free_task_flutter/` altinda Flutter project olusturulacak.
- Paketler implementation basladiginda onayli network ile kurulacak:
  - `flutter_riverpod`
  - SQLCipher adapter spike paketi
  - `flutter_secure_storage`
  - `local_auth`
  - `flutter_local_notifications`
  - localization icin Flutter gen-l10n
  - test ve lint paketleri
- Generated lockfile commit edilecek.
- `.env.example` yalnizca Faz 2/Faz 3 ihtiyaclari dogdugunda eklenecek; MVP'de secret yok.
- GitHub repo zaten bagli: `aliyusufergin/free-task`.
- Branch onerisi: `main` protected, gelistirme icin `feature/<area>-<short-name>`.

## 7. Onerilen Ilk Sprint

Sprint hedefi: en yuksek teknik riskleri erken kapatmak.

1. SET-01: Repo hygiene.
2. SET-02: Flutter scaffold.
3. DES-01: ThemeData entegrasyonu.
4. DES-02: TR/EN localization iskeleti.
5. SEC-01: SQLCipher spike.
6. SEC-02: KDF/key wrapping spike.
7. SEC-03: Biyometrik unlock spike.
8. NOT-01: Local notification permission smoke test.
9. SET-05: Desktop/web smoke build kontrolu.

Sprint cikisi:

- Android+iOS'ta acilan bos ama temali app.
- PC/desktop ve web icin resmi release olmadan derleme uyumu hakkinda ilk risk notu.
- Kasa spike'i kanitlanmis.
- Dil ve tema degistirme calisir.
- Bildirim izni davranisi platformlarda gorulmus.

## 8. Risk-First Work

Oncelik sirasi:

1. SQLCipher ve key management.
2. Android+iOS local notification farklari.
3. Desktop/web derleme uyumlulugu smoke kontrolu.
4. TR/EN localization ve text overflow.
5. Recurrence/timezone hesaplari.
6. Import/export rollback.
7. Accessibility ve buyuk metin.
8. UI polish.

Bu siralama, once veri kaybi ve platform blokajlarini azaltir.

## 9. Design/Content Tasks

- Mikro metinleri localization key olarak cikarmak.
- TR/EN metinleri buton ve task row tasariminda test etmek.
- Claude ekranlarina gore component checklist hazirlamak.
- Light/dark ve compact/default density snapshot referanslari uretmek.
- Bildirim copy secenekleri:
  - Varsayilan: "free-task hatirlaticisi"
  - Gizlilik modu: gorev basligini gizle
  - Acik mod: gorev basligini goster

## 10. Engineering Tasks

Engineering gorevleri milestone tablosundaki SET/SEC/DAT/UI/NOT/IMP/STA/FUT tasklaridir. Her task tek basina review edilebilir olmali ve test kapsamiyla birlikte tamamlanmalıdır.

## 11. QA ve Release Tasks

- Unit tests: domain, recurrence, parser, repository.
- Widget tests: kasa kurulumu, bugun listesi, yeni gorev, ayarlar.
- Integration tests: F1-F9 MVP akislari.
- Manual tests: Android/iOS bildirim izinleri, biyometrik fallback, dosya export/import.
- Desktop/web smoke: resmi release kapsamına almadan scaffold ve plugin uyumlulugu kontrolu.
- Accessibility: screen reader, buyuk metin, kontrast.
- Release: Android internal testing, iOS TestFlight, dogfooding checklist.

## 12. Acik Planlama Sorulari

- License karari: MIT, Apache-2.0, GPL/AGPL veya TBD.
- Flutter SDK minimum versiyonu.
- Kurtarma anahtari kaydetmeden gecis tamamen engellenecek mi?
- Local notification lock screen varsayilani: gorev basligi gizli mi acik mi?
- Faz 2 self-host server dili/stack'i bu repo icinde mi, ayri repo mu planlanacak?

## 13. Handoff to Test Plan

`$test-plan` ozellikle sunlari kapsamalidir:

- Sifreli DB ve key recovery testleri.
- Android+iOS local notification izin ve schedule testleri.
- Offline CRUD, recurrence, import/export testleri.
- Localization TR/EN ve buyuk metin testleri.
- Accessibility ve screen reader kontrolleri.
- Faz 2/Faz 3 disabled adapter guard testleri.

## 14. Task Tracking ve Commit Policy

- Yasayan tracker: `docs/project/tasks.md`.
- Yeni implementation isi baslamadan once tracker'a eklenmelidir.
- Commit sinirlari:
  - Her anlamli risk azaltma veya bagimsiz feature sonunda commit.
  - Ilgisiz degisiklikleri ayni commit'e koyma.
  - Mümkünse format/analyze/test calistir.
  - Secret, token, real production env, private upload ve ilgisiz local dosya commit'lenmez.
- Ornek commit mesajlari:
  - `chore: scaffold Flutter app`
  - `security: add encrypted vault spike`
  - `feat: add task creation flow`
  - `test: cover recurrence rules`
