# Teknik Tasarim: free-task

## 1. Kaynak Kapsam

| Alan | Deger |
| --- | --- |
| Durum | Taslak / planlama icin hazir |
| Tarih | 2026-07-04 |
| Kaynak dokumanlar | `docs/project/prd.md`, `docs/project/ux-flows.md`, `docs/design/claude-v1/design-summary.md` |
| Tasarim paketi | `docs/design/claude-v1/screens/`, `docs/design/claude-v1/flutter/free_task_theme.dart`, prototip `.dc.html` dosyalari |
| MVP platformlari | Android + iOS es zamanli |
| UI dilleri | Turkce + Ingilizce |
| MVP guvenlik modeli | Parola + biyometrik + kurtarma anahtari, yerel sifreli kasa |
| MVP bildirim karari | Cihaz ici local notifications, opt-in |

Bu teknik tasarim MVP'yi uygulamaya hazir hale getirmek icin yazilmistir. Faz 2 ve Faz 3 icin mimari genisleme sinirlari tanimlanir, ancak bu fazlar MVP teslimat kapsamına alinmaz.

## 2. Mevcut Repo ve Stack Bulgulari

- Repo su anda planlama ve tasarim dosyalari icerir; uygulama kodu henuz yoktur.
- Mevcut dokumanlar:
  - `docs/project/prd.md`
  - `docs/project/ux-flows.md`
  - `docs/project/claude-design-brief.md`
  - `docs/design/claude-v1/`
- Claude tasarim teslimati repo icine alinmistir:
  - 36 PNG ekran
  - 4 prototip HTML dosyasi
  - Flutter `ThemeData` baslangic dosyasi
- Paket yonetimi, CI, Flutter project scaffold, test altyapisi ve release config henuz yoktur.

Onerilen repo duzeni:

```text
apps/
  free_task_flutter/
    lib/
      app/
      core/
      features/
      l10n/
    test/
    integration_test/
packages/
  free_task_domain/
  free_task_parser/
docs/
  project/
  design/
```

MVP icin tek Flutter uygulamasi `apps/free_task_flutter/` altinda baslatilmalidir. `packages/` yalnizca gercek tekrar eden domain/parser ihtiyaci dogdugunda acilmalidir.

## 3. Mimari Ozet

free-task, MVP'de tamamen cihaz ustunde calisan, sifreli yerel veri deposuna sahip bir Flutter uygulamasidir.

Yuksek seviye katmanlar:

1. **Presentation:** Flutter widget'lari, tema, localization, routing, ekran state'leri.
2. **Application:** Use case'ler, command/query servisleri, notification scheduling, import/export orchestration.
3. **Domain:** Task, recurrence, deadline, reminder, vault, locale, settings, completion event gibi saf modeller ve kurallar.
4. **Data:** SQLCipher tabanli yerel storage, repository implementasyonlari, export/import adapterleri.
5. **Platform services:** Biyometrik auth, secure storage, local notifications, dosya secici/paylasim, timezone.
6. **Future adapters:** Sync, AI, automation, API/webhook arayuzleri. MVP'de no-op veya disabled implementasyon.

Temel prensip:

- UI ve domain, sync/AI varmis gibi sisirilmez.
- Veri modeli, Faz 2 E2EE sync ve Faz 3 AI/DAG icin genislemeye hazir tutulur.
- MVP'de uzaktan hesap, backend, remote telemetry ve harici AI yoktur.

## 4. Teknoloji Kararlari

| Alan | Karar | Alternatifler | Gerekce | Resmi Kaynak |
| --- | --- | --- | --- | --- |
| Uygulama framework'u | Flutter + Dart | React Native, Kotlin Multiplatform, native Android+iOS | Android+iOS es zamanli hedef, guclu UI kontrolu, ileride desktop/web opsiyonu | https://docs.flutter.dev/ |
| Mobil platformlar | Android + iOS es zamanli | Android once, iOS sonra | Kullanici karari ve tasarim platform paritesi | https://docs.flutter.dev/reference/supported-platforms |
| Mimari | Feature-first layered architecture | Tek katmanli Flutter app, katı clean architecture | Offline, E2EE, import/export, sync ve AI icin test edilebilir sinirlar gerekir | https://docs.flutter.dev/app-architecture/guide |
| State management | Riverpod aday standart | Provider, Bloc, ChangeNotifier | Repository/use-case ayrimini test edilebilir yapar; MVP'de codegen zorunlu degil | https://riverpod.dev/docs/introduction/getting_started |
| Yerel veri | SQLCipher ile sifreli SQLite | Hive/Isar, plaintext SQLite, dosya tabanli JSON | Iliskili gorev/alt gorev/tekrar modeli ve sifreli local vault ihtiyaci | https://www.zetetic.net/sqlcipher/ |
| SQLite Flutter entegrasyonu | `sqflite_sqlcipher` veya teknik spike sonucu esdeger SQLCipher adapter | `sqflite`, `drift` + custom SQLCipher, platform channel | MVP'de sifreli DB birincil gereksinim; paket olgunlugu uygulama spike'inda dogrulanacak | https://pub.dev/packages/sqflite_sqlcipher |
| Anahtar saklama | OS secure storage + kullanici parolasindan turetilen vault key | Sadece parola, sadece secure storage | Biyometrik acma ve kurtarma anahtari icin key wrapping gerekir | https://pub.dev/packages/flutter_secure_storage |
| Biyometrik | `local_auth` | Platform channel custom | Android/iOS ortak biyometrik API | https://pub.dev/packages/local_auth |
| Local notification | `flutter_local_notifications` | Platform channel custom, uzaktan push | MVP opt-in cihaz ici hatirlatici; uzaktan sunucu yok | https://pub.dev/packages/flutter_local_notifications |
| Localization | Flutter gen-l10n, ARB dosyalari | JSON custom i18n | Turkce/English, Flutter resmi localization akisi | https://docs.flutter.dev/ui/internationalization |
| Tema | Claude tokenlari -> Flutter ThemeData | Material varsayilani | Tasarim tokenlari hazir; light/dark ve density desteklenecek | `docs/design/claude-v1/flutter/free_task_theme.dart` |
| Release | Android internal testing + iOS TestFlight | Direkt store yayini | Dogfooding ve veri kaybi riskini once kapali testte azaltma | https://docs.flutter.dev/deployment/android, https://docs.flutter.dev/deployment/ios |

## 5. Sistem Bilesenleri

### 5.1 App Shell

- Routing, tema, locale, app lifecycle ve vault lock state'ini yonetir.
- Alt bar + FAB navigasyon omurgasini uygular.
- Locked vault state'inde uygulama icerigini render etmez.

### 5.2 Vault Module

- Ilk kurulum, parola dogrulama, biyometrik acma, kurtarma anahtari dogrulama.
- Data key uretimi, key wrapping ve SQLCipher passphrase saglama.
- Auto-lock policy: uygulama background'a gittikten sonra belirlenen sure gecerse kasa kilitlenir.

### 5.3 Task Module

- Task CRUD, alt gorev, arsiv, silme, tamamlanan davranisi.
- Deadline, zaman araligi, zamansiz havuz ve tekrar kuralı state'leri.
- Task row component modeline uygun read model uretir.

### 5.4 Recurrence & Scheduling Module

- Tekrar kuralı hesaplama.
- Timezone ve DST degisimi algilama.
- Deadline ve reminder hesaplari.
- Local notification planlama ile Application katmaninda konusur.

### 5.5 Parser Module

- MVP'de yerel, deterministik Turkce/English basit tarih/saat ayrıştırma.
- Ornek: "yarin 15:00", "tomorrow 3pm", "her pazartesi", "next Friday".
- Harici LLM kullanmaz.

### 5.6 Settings Module

- Dil, tema, density, tamamlanan gorev davranisi, bildirim izin durumu, export/import.
- Ayarlar ayni zamanda Faz 2/Faz 3 icin Sync/Otomasyon bolumlerine genisler.

### 5.7 Import/Export Module

- MVP:
  - Export: JSON, Markdown.
  - Import: free-task JSON.
- Export modlari:
  - Okunabilir acik export.
  - Sifreli yedek export.
- Import islemi transactional olmalı; hata durumunda mevcut veri bozulmamalı.

### 5.8 Future Sync Adapter

- MVP'de disabled/no-op.
- Faz 2'de:
  - Self-host/SaaS endpointleri.
  - E2EE encrypted payload sync.
  - Device pairing ve conflict resolution.

### 5.9 Future AI/Automation Adapter

- MVP'de yok.
- Faz 3'te:
  - AI command input.
  - Human-in-the-loop suggestion lifecycle.
  - Agent/plugin scopes.
  - API key ve webhook eventleri.

## 6. API ve Entegrasyon Tasarimi

MVP'de public API veya remote backend yoktur. "API" sinirlari uygulama icindeki service/repository contract'laridir.

| Sinir/Servis | Amac | Girdi | Cikti | Hata Davranisi |
| --- | --- | --- | --- | --- |
| `VaultService` | Kasa kurma/acma/kilitleme | Parola, biyometrik sonuc, kurtarma anahtari | Unlocked vault context | Yanlis parola, key acilamadi, recovery fail |
| `TaskRepository` | Sifreli task CRUD | Task command/query | Task aggregate/read model | Transaction rollback, veri korunur |
| `RecurrenceService` | Tekrar ornekleri uretmek | RecurrenceRule, timezone, tarih araligi | Occurrence listesi | Gecersiz kural inline hata |
| `ReminderService` | Local notification planlamak | Task id, reminder time, locale | Scheduled reminder id | Izin yoksa no-op + UI uyarisi |
| `ParserService` | Basit NLP ayrıştırma | Text, locale, timezone | Parse suggestions | Algilayamazsa bos suggestion |
| `ExportService` | JSON/Markdown/sifreli yedek uretmek | Format, encryption option | Dosya payload | Dosya izni hata, veri bozulmaz |
| `ImportService` | free-task JSON import | Dosya payload | Import report | Satir/alan hata raporu, rollback |
| `SyncAdapter` | Faz 2 sync siniri | Encrypted change set | Sync result | MVP'de disabled |
| `AIAdapter` | Faz 3 AI siniri | User command/context scope | Suggestions | MVP'de disabled, onaysiz yazma yok |

## 7. Veri ve Storage Yaklasimi

### 7.1 Local Vault

- Uygulamanin hassas verisi SQLCipher ile sifrelenmis yerel DB'de saklanir.
- DB anahtari kullanici parolasindan turetilen veya recovery key ile unwrap edilen data key uzerinden yonetilir.
- Biyometrik tek basina guven kaynagi degildir; OS secure storage'daki wrapped key'i acmak icin kolaylastirici olur.

### 7.2 Ana Tablolar

- `vault_metadata`
- `user_profile`
- `tasks`
- `subtasks`
- `recurrence_rules`
- `task_occurrences`
- `completion_events`
- `tags`
- `task_tags`
- `attachments`
- `link_previews`
- `reminders`
- `preferences`
- `import_export_logs`

Faz 2 icin hazir tutulacak tablolar:

- `devices`
- `sync_changes`
- `sync_conflicts`
- `workspaces`
- `members`
- `roles`
- `task_assignments`

Faz 3 icin hazir tutulacak tablolar:

- `ai_suggestions`
- `automation_agents`
- `api_keys`
- `webhooks`
- `task_dependencies`

MVP'de Faz 2/Faz 3 tablolari fiziksel olarak olusturulmak zorunda degildir; migration planinda reserve edilir.

### 7.3 Migration

- Her schema degisikligi versiyonlu migration olarak yazilir.
- Migration oncesi sifreli yedek alma opsiyonu sunulmalıdır.
- Migration yarida kalirsa DB acilisinda recovery/rollback davranisi tanimlanmalıdır.

## 8. Auth, Guvenlik ve Privacy

### 8.1 MVP Auth Modeli

- Remote auth yoktur.
- Local vault unlock vardir.
- Parola zorunlu.
- Biyometrik opsiyonel.
- Kurtarma anahtari zorunlu onboarding adimi veya risk onayli erteleme olarak tasarlanır; data-permissions dokumani nihai policy'yi belirler.

### 8.2 Key Management

Onerilen model:

1. Ilk kurulumda rastgele `Data Encryption Key` uret.
2. Kullanici parolasindan KDF ile key-encryption-key turet.
3. Data key'i parola tabanli key ile wrap et.
4. Kurtarma anahtari ayrica data key'i wrap eder.
5. Biyometrik/secure storage, data key'i veya unwrap token'ini OS korumali alanda tutar.
6. Plaintext key memory'de minimum sure tutulur ve lock'ta temizlenir.

KDF parametreleri, platform destegi ve performans teknik spike gerektirir. Varsayilan hedef Argon2id veya guclu PBKDF2-HMAC-SHA256 parametreleridir; uygulama oncesi kripto kutuphane secimi dogrulanmalıdır.

### 8.3 Privacy

- Harici telemetry varsayilan kapali.
- Link metadata cekimi kullanici onayli ve hata toleransli.
- AI MVP'de yok; Faz 3'te notlar ve hassas alanlar varsayilan AI context'inden dislanir.
- Export acik formatta alinacaksa kullaniciya plaintext riski anlatilir.

## 9. Background Jobs, Realtime ve Scheduling

### MVP

- Background server yoktur.
- Local notification scheduling cihaz uzerinde yapilir.
- Recurrence hesaplari:
  - Gorev kaydedilirken preview.
  - Uygulama acilisinda ve tarih degisiminde reconciliation.
  - Timezone degisimi algilanirsa kullaniciya uyarı.
- Link metadata:
  - Online ise kullanici onayi ile denenir.
  - Offline ise pending metadata job olarak tutulabilir.

### Faz 2

- Sync background job opt-in.
- Conflict detection ve encrypted change log gerekir.

### Faz 3

- AI ve agent isleri kullanici onayi olmadan kalici veri yazamaz.
- Webhook/API eventleri scope ve rate limit ile sinirlanir.

## 10. Deployment ve Environment'lar

| Environment | Amac | Not |
| --- | --- | --- |
| Local dev | Gelistirme ve test | Flutter SDK, Android emulator, iOS simulator |
| Device dogfooding | Gercek cihaz testleri | Android + iOS es zamanli |
| Internal/Beta | Sinirli paylasim | Android internal testing, iOS TestFlight |
| Production | Gelecek | Store yayin karari launch planinda |

MVP'de backend deployment yoktur. Faz 2 self-host sync sunucusu icin ayri teknik tasarim veya bu dokumanin Faz 2 revizyonu gerekir.

## 11. Observability, Logging ve Alerting

### MVP

- Remote logging/analytics varsayilan yok.
- Yerel debug loglari hassas veri icermez.
- Kullanici isterse "diagnostic bundle" export edebilir; gorev icerigi dahil edilmez.
- Crash reporting kullanilacaksa opt-in ve privacy review gerektirir.

### Faz 2/Faz 3

- Sync server ve SaaS icin structured logging, rate limit loglari, audit log ve alerting gerekir.
- Agent/API islemlerinde audit log zorunludur.

## 12. Performans ve Olceklenebilirlik

MVP hedefleri:

- Bugun ekranı algilanan acilis: 1 saniyenin altinda.
- 10.000 task + recurrence hesaplariyla liste ve arama kabul edilebilir hizda.
- Ana query'ler indexed olmalı:
  - status
  - schedule_type
  - due_at/start_at
  - updated_at
  - tag join
- Recurrence occurrence'lari sinirli tarih araliginda hesaplanmalı; sonsuz tekrarlar DB'ye sonsuz yazilmaz.
- Grafik/istatistik hesaplari cache'lenebilir.

Flutter performans notlari:

- Backdrop blur dusuk cihazlarda kapatilabilir.
- Uzun listelerde lazy list ve stable item key kullanılır.
- Localization ve tema degisimi gereksiz rebuild yaratmamalı.

## 13. Riskler, Tradeoff'lar ve Acik Kararlar

| Risk/Karar | Etki | Oneri |
| --- | --- | --- |
| SQLCipher Flutter paket olgunlugu | MVP blokaj riski | Ilk teknik spike: Android+iOS encrypted DB ac/kapat/migrate/perf |
| Kripto/KDF secimi | Guvenlik ve performans | Data-permissions ve security review ile netlestir |
| Kurtarma anahtari UX'i | Veri kaybi veya onboarding surtunmesi | Zorunlu dogrulama mi risk onayli erteleme mi karar ver |
| Iki dilli copy | UI tasarim paritesi | ARB key sistemi ve uzun metin testleri |
| Local notifications platform farklari | Android/iOS davranis sapmasi | Platform izinleri ve timezone testleri |
| Riverpod/codegen karmasikligi | Baslangic hizi | MVP'de codegen opsiyonel; once basit provider yapisi |
| Faz 2/3 tablolarini erken eklemek | MVP sisirme | Migration planinda reserve et, fiziksel tabloyu ihtiyac olunca ekle |

## 14. Gerekli Resmi Dokumantasyon ve Skill'ler

### Kontrol Edilen Resmi Kaynaklar

- Flutter Docs: https://docs.flutter.dev/
- Flutter supported platforms: https://docs.flutter.dev/reference/supported-platforms
- Flutter app architecture guide: https://docs.flutter.dev/app-architecture/guide
- Flutter SQLite cookbook: https://docs.flutter.dev/cookbook/persistence/sqlite
- Flutter internationalization: https://docs.flutter.dev/ui/internationalization
- Flutter accessibility: https://docs.flutter.dev/ui/accessibility
- Android deployment: https://docs.flutter.dev/deployment/android
- iOS deployment: https://docs.flutter.dev/deployment/ios
- Riverpod docs: https://riverpod.dev/docs/introduction/getting_started
- SQLCipher: https://www.zetetic.net/sqlcipher/
- `sqflite_sqlcipher`: https://pub.dev/packages/sqflite_sqlcipher
- `flutter_secure_storage`: https://pub.dev/packages/flutter_secure_storage
- `local_auth`: https://pub.dev/packages/local_auth
- `flutter_local_notifications`: https://pub.dev/packages/flutter_local_notifications

### Kullanilacak Sonraki Skill'ler

- `$data-permissions`: veri modeli, E2EE, recovery, roller, retention, audit, AI context scope.
- `$implementation-plan`: Flutter scaffold, spike sirasi, milestone ve issue planlama.
- `$test-plan`: encrypted DB, local notifications, localization, accessibility, offline, migration.
- `$launch-plan`: dogfooding, TestFlight/internal testing, rollback ve support.

## 15. Handoff

`$data-permissions` icin gerekli girdiler:

- Local vault ve key management modeli.
- MVP tek owner modeli.
- Faz 2 owner/admin/member/viewer rolleri.
- Faz 3 AI/agent/API scope ihtiyaclari.
- Import/export ve sifreli yedek davranisi.
- Local notification verisinin hassasiyet siniri.

`$implementation-plan` icin gerekli girdiler:

- Flutter project `apps/free_task_flutter/` altinda scaffold edilecek.
- Ilk teknik spike: SQLCipher + secure storage + local_auth + local_notifications + localization.
- Tasarim tokenlari `free_task_theme.dart` uygulama temasina entegre edilecek.
- MVP, Faz 2/Faz 3 genisleme sinirlarini kodda feature flag/adapters ile koruyacak.
