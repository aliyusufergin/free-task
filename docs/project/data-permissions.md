# Veri Modeli ve Yetki Dokumani: free-task

## 1. Kaynak Kapsam

| Alan | Deger |
| --- | --- |
| Durum | Taslak / uygulama planina hazir |
| Tarih | 2026-07-04 |
| Kaynak dokumanlar | `docs/project/prd.md`, `docs/project/ux-flows.md`, `docs/project/technical-design.md` |
| MVP rol modeli | Tek yerel owner |
| Faz 2 rol modeli | Owner, Admin, Member, Viewer |
| Faz 3 izin modeli | AI/agent/API icin scope tabanli izinler ve audit |
| Hassasiyet ilkesi | Gorev icerigi, notlar, linkler, ekler, istatistikler ve yedekler hassas kabul edilir |

Bu dokuman, free-task'in veri modelini, ownership kurallarini, E2EE/privacy sinirlarini, retention/silme davranislarini ve Faz 2/Faz 3 icin yetki genislemesini tanimlar.

## 2. Ana Varliklar

| Varlik | Aciklama | Sahip | Yasam Dongusu |
| --- | --- | --- | --- |
| `LocalVault` | Sifreli yerel veri kasasi ve key metadata kapsami | Local owner | Olusturulur, kilitlenir, acilir, migration gorur, silinebilir |
| `UserProfile` | Yerel kullanici profili, dil, timezone ve tercihleri | Local owner | Olusturulur, guncellenir, export edilir |
| `Task` | Gorev ana kaydi | Local owner / Faz 2 workspace | Aktif, tamamlandi, ertelendi, arsivlendi, silindi |
| `Subtask` | Goreve bagli alt is | Task sahibi | Olusturulur, tamamlanir, silinir |
| `RecurrenceRule` | Tekrar kuralı | Task sahibi | Olusturulur, guncellenir, devre disi birakilir |
| `TaskOccurrence` | Belirli tarih araliginda hesaplanan rutin gorunumu | Task sahibi | Turetilir/cache'lenir, yeniden hesaplanir |
| `Reminder` | Local notification zamanlamasi | Task sahibi | Planlandi, tetiklendi, iptal edildi |
| `Tag` | Gorev etiketi | Local owner / workspace | Olusturulur, yeniden adlandirilir, silinir |
| `Attachment` | Goreve eklenen yerel dosya/gorsel referansi | Task sahibi | Eklenir, export edilir, silinir |
| `LinkPreview` | URL ve opsiyonel metadata | Task sahibi | Ham link saklanir, metadata onayla guncellenir |
| `CompletionEvent` | Gorev/rutin tamamlama olayi | Task sahibi | Olusur, istatistiklerde kullanilir |
| `Preference` | Dil, tema, density, tamamlanan davranisi, bildirim ayarlari | Local owner | Guncellenir, export edilebilir |
| `ImportExportLog` | Import/export sonuc raporu | Local owner | Olusur, belirli sure saklanir |
| `Device` | Faz 2 cihaz kimligi | Workspace/local owner | Eslenir, guvenilir, kaldirilir |
| `Workspace` | Faz 2 aile/takim/kisisel alan | Owner | Olusturulur, arsivlenir, silinir |
| `Member` | Faz 2 workspace uyesi | Workspace owner/admin | Davetli, aktif, kaldirildi |
| `Role` | Faz 2 yetki seviyesi | Sistem tanimli | Owner, admin, member, viewer |
| `SyncChange` | Faz 2 sifreli degisim kaydi | Device/workspace | Uretilir, sync edilir, compact edilir |
| `SyncConflict` | Faz 2 cakisma kaydi | Workspace | Acik, cozuldu |
| `AISuggestion` | Faz 3 AI tarafindan uretilen ama onay bekleyen oneriler | Kullanici | Pending, approved, rejected, edited, expired |
| `Agent` | Faz 3 agent/plugin kaydi | Owner/admin | Installed, enabled, disabled, revoked |
| `APIKey` | Faz 3 API token metadata | Owner/admin | Created, active, revoked, expired |
| `Webhook` | Faz 3 outbound event aboneligi | Owner/admin | Active, paused, failed, revoked |
| `TaskDependency` | Faz 3 DAG iliskisi | Task sahibi | Created, locked/unlocked, removed |

## 3. Alanlar ve Iliskiler

| Varlik | Alan | Tip | Zorunlu | Hassas mi? | Not |
| --- | --- | --- | --- | --- | --- |
| LocalVault | `id` | uuid | Evet | Hayir | Yerel scope |
| LocalVault | `encryption_version` | int | Evet | Hayir | Migration icin |
| LocalVault | `key_metadata` | json/blob | Evet | Evet | Wrapped key, KDF params; plaintext key degil |
| UserProfile | `locale` | enum | Evet | Hayir | `tr`, `en`, `system` |
| UserProfile | `timezone` | string | Evet | Kismen | Gorev zamanlari icin |
| Task | `title` | text | Evet | Evet | Gorev icerigi hassas kabul edilir |
| Task | `description` | text | Hayir | Evet | AI/sync/paylasim sinirlarinda dikkat |
| Task | `status` | enum | Evet | Hayir | active/completed/postponed/archived/deleted |
| Task | `schedule_type` | enum | Evet | Hayir | timed/pool/recurring/deadline |
| Task | `start_at`, `end_at`, `due_at` | datetime | Hayir | Kismen | Davranis verisi |
| Task | `priority`, `effort` | enum/int | Hayir | Kismen | Istatistikte kullanilir |
| Subtask | `title` | text | Evet | Evet | Task ile ayni gizlilik siniri |
| RecurrenceRule | `frequency`, `interval`, `days`, `until`, `count` | structured | Evet | Kismen | Rutin davranisi hassas olabilir |
| Reminder | `notify_at` | datetime | Evet | Kismen | Local notification planlamasi |
| Reminder | `permission_state` | enum | Evet | Hayir | izin verilmedi/verildi |
| Tag | `name`, `color` | text/color | Evet | Kismen | Etiket isimleri hassas olabilir |
| Attachment | `local_uri` | text | Evet | Evet | Dosya yolu/metadata hassas |
| Attachment | `type`, `size`, `checksum` | text/int | Hayir | Kismen | Export/migration icin |
| LinkPreview | `url`, `title`, `fetched_at` | text/datetime | Evet | Evet | URL hassas olabilir |
| CompletionEvent | `completed_at`, `source` | datetime/enum | Evet | Kismen | Davranis analitigi |
| Preference | `key`, `value` | text/json | Evet | Kismen | Dil/tema dusuk; guvenlik ayarlari hassas |
| ImportExportLog | `format`, `encrypted`, `success_count`, `error_count` | structured | Evet | Kismen | Icerik degil sonuc saklanir |
| Device | `device_id`, `public_key`, `trusted_at` | text/key/datetime | Evet | Evet | Faz 2 |
| Workspace | `name`, `type` | text/enum | Evet | Kismen | Kisisel/aile/takim |
| Member | `display_name`, `role`, `status` | text/enum | Evet | Kismen | Faz 2 |
| SyncChange | `encrypted_payload`, `nonce`, `device_id` | blob/text | Evet | Evet | Sunucu plaintext gormez |
| SyncConflict | `local_change_id`, `remote_change_id` | uuid | Evet | Evet | Cakisma cozumune kadar saklanir |
| AISuggestion | `prompt`, `suggested_payload`, `status` | text/json/enum | Evet | Evet | Onaya kadar kalici task degil |
| Agent | `name`, `scopes`, `status` | text/list/enum | Evet | Kismen | Scope audit gerekir |
| APIKey | `token_hash`, `scopes`, `expires_at` | hash/list/datetime | Evet | Evet | Plain token saklanmaz |
| Webhook | `url`, `events`, `secret_hash` | text/list/hash | Evet | Evet | Faz 3 |
| TaskDependency | `from_task_id`, `to_task_id`, `type` | uuid/enum | Evet | Hayir | DAG UI icin |

## 4. Iliski Haritasi

- `LocalVault` tum MVP verisini kapsar.
- `UserProfile` bir `LocalVault` icinde tekil kayittir.
- `Task`:
  - coklu `Subtask`
  - sifir/bir `RecurrenceRule`
  - coklu `Reminder`
  - coklu `Tag` (`task_tags`)
  - coklu `Attachment`
  - sifir/bir veya coklu `LinkPreview`
  - coklu `CompletionEvent`
- `Preference` local owner'a aittir.
- Faz 2:
  - `Workspace` coklu `Member` icerir.
  - `Task` workspace'e ve opsiyonel assignee member'a baglanabilir.
  - `Device` workspace veya local owner ile trust iliskisi kurar.
  - `SyncChange` device/workspace scope'unda uretilir.
- Faz 3:
  - `AISuggestion` task'a donusmeden once pending kayittir.
  - `Agent`, `APIKey`, `Webhook` scope listeleriyle sinirlanir.
  - `TaskDependency` iki task arasindaki yonlu iliskiyi tutar.

## 5. Yasam Dongusu Kurallari

### Task

1. `active`: listelerde gorunur.
2. `completed`: CompletionEvent olusur; ayara gore gizlenir veya ustu cizili kalir.
3. `postponed`: tarih/saat guncellenir; audit/olay kaydi tutulabilir.
4. `archived`: aktif listelerden cikar, export'a dahil edilir.
5. `deleted`: MVP'de soft delete veya kisa sureli undo onerilir; hard delete kullanici onayi ister.

### Reminder

- Gorev silinirse reminder iptal edilir.
- Gorev ertelenirse reminder yeniden hesaplanir.
- Bildirim izni reddedilirse reminder kaydi `permission_denied` olarak kalabilir ama sistem bildirimi kurulmaz.

### Import/Export

- Import transactional olur.
- Import hata raporu icerik kopyalamadan sorunlu alan/satir bilgisini tutar.
- Acik export plaintext riski nedeniyle onay ister.
- Sifreli backup export recovery key veya kullanici parolasina baglanabilir.

### AISuggestion

- `pending`: UI'da kesikli onerı karti.
- `approved`: Task'a donusur.
- `edited`: Kullanici duzenledikten sonra task'a donusur.
- `rejected`: Kalici task olusmaz.
- `expired`: Bekleyen oneriler belirli sure sonra temizlenebilir.

## 6. Roller

| Rol | Aciklama | Kapsam |
| --- | --- | --- |
| Local Owner | MVP'deki tek kullanici | Yerel kasa ve tum veriler |
| Workspace Owner | Faz 2 alan sahibi | Workspace, uyeler, roller, sync, export |
| Admin | Faz 2 yonetici | Uye/gorev yonetimi, sinirli ayarlar |
| Member | Faz 2 normal uye | Kendisine atanan/izinli gorevler |
| Viewer | Faz 2 izleyici | Salt okunur erisim |
| Agent/API Client | Faz 3 programatik aktor | Scope ile sinirli |

MVP'de remote support/admin/guest yoktur. Support impersonation yoktur.

## 7. Yetki Matrisi

### 7.1 MVP

| Kaynak/Eylem | Local Owner | Not |
| --- | --- | --- |
| Kasa olustur/ac | Evet | Parola/kurtarma zorunlu |
| Task CRUD | Evet | Sifreli local DB |
| Export/import | Evet | Acik export risk onayi ister |
| Dil/tema/bildirim ayari | Evet | Cihaz ici |
| Local notification kur | Evet | OS izni gerekir |
| AI/Sync/API | Hayir | MVP disi |

### 7.2 Faz 2 Workspace

| Kaynak/Eylem | Owner | Admin | Member | Viewer | Not |
| --- | --- | --- | --- | --- | --- |
| Workspace ayarlarini degistir | Evet | Kismen | Hayir | Hayir | Server/sync ayarlari owner onayi ister |
| Uye davet et | Evet | Evet | Hayir | Hayir | Davet audit kaydi |
| Rol degistir | Evet | Kismen | Hayir | Hayir | Admin owner rolunu degistiremez |
| Ortak task olustur | Evet | Evet | Evet | Hayir | Workspace policy'ye bagli |
| Task atama | Evet | Evet | Kendi task'inda kismen | Hayir | Kisisel alan ayridir |
| Task tamamla | Evet | Evet | Atandigi task | Hayir | CompletionEvent actor saklar |
| Task sil | Evet | Evet | Kendi olusturdugu task kismen | Hayir | Soft delete onerilir |
| Export workspace | Evet | Kismen | Hayir | Hayir | Hassas islem |
| Cihaz ekle/sil | Evet | Evet | Kendi cihazi | Hayir | Trust modeli gerekir |

### 7.3 Faz 3 Agent/API

| Kaynak/Eylem | Owner/Admin | Agent/API Client | Not |
| --- | --- | --- | --- |
| API key olustur | Evet | Hayir | Plain token bir kez gosterilir |
| Scope ver/geri al | Evet | Hayir | Least privilege |
| Task oku | Scope'a bagli | `task:read` | Hassas alan kapsam disi birakilabilir |
| Task olustur | Scope'a bagli | `task:write` + onay policy | AI onerileri onaysiz kalici yazamaz |
| Webhook event al | Evet | Event scope | Secret hash saklanir |
| AI context erisimi | Evet | Scope/policy | Notlar varsayilan gizli |
| Agent action calistir | Evet | Scope + onay | Audit zorunlu |

## 8. Ownership ve Tenancy

### MVP

- Tek tenancy: local vault.
- Tum veri local owner'a aittir.
- Uygulama disinda hesap veya merkezi identity yoktur.

### Faz 2

- Tenancy: workspace.
- Kisisel workspace ayridir ve varsayilan olarak tam local/offline kalabilir.
- Aile/takim workspace'i E2EE sync kapsaminda calisir.
- Uye ayrildiginda:
  - Kendi cihaz trust'i kaldirilir.
  - Yeni degisimleri alamaz.
  - Geçmis lokal kopyalarin kriptografik geri alinmasi garanti edilemez; key rotation gerekir.

### Faz 3

- Agent/API erisimi workspace veya local owner scope'una baglanir.
- Agent/API icin tenancy disina cikis yoktur.

## 9. Privacy, Retention ve Silme

| Veri | Retention | Silme | Export |
| --- | --- | --- | --- |
| Task/Subtask/Note | Kullanici silene kadar | Soft delete + hard delete onayi | JSON/Markdown/sifreli yedek |
| CompletionEvent | Kullanici silene veya istatistik temizleyene kadar | Istatistik reset ile silinebilir | JSON |
| Reminder | Gorev/hatirlatici silinince | Sistem notification iptali + DB kaydi silme | Opsiyonel |
| Attachment | Kullanici silene kadar | Dosya referansi ve varsa yerel kopya silinir | Sifreli yedek onerilir |
| LinkPreview | Task ile birlikte | Metadata silinebilir, ham link kalabilir | JSON/Markdown |
| ImportExportLog | Sinirli sure veya kullanici temizleyene kadar | Temizlenebilir | Icerik degil rapor |
| Diagnostic logs | Kisa sure, opt-in | Kullanici temizler | Icerik olmadan |
| SyncChange | Faz 2 compact edilene kadar | Compact/retention policy | Sifreli payload |
| AISuggestion | Onay/red/expire sonrasi temizlenir | Rejected/pending temizlenir | Varsayilan export disi veya isaretli |
| API/Webhook audit | Faz 3 policy'ye gore | Retention dolunca compact | Audit export owner/admin |

Privacy ilkeleri:

- Remote telemetry varsayilan yok.
- Harici servise plaintext gorev icerigi gonderilmez.
- Link metadata fetch kullanici onayi veya acik ayar gerektirir.
- AI context minimal ve kullanici tarafindan gorulebilir olmalıdır.

## 10. Audit Log ve Izlenebilirlik

### MVP

Tam kapsamli audit log zorunlu degil, ancak su olaylar yerel olay kaydi veya diagnostic report icin tutulabilir:

- `task_created`
- `task_updated`
- `task_completed`
- `task_deleted`
- `export_created`
- `import_completed`
- `vault_unlocked` / `vault_failed_unlock` (iceriksiz)
- `reminder_scheduled` / `reminder_permission_denied`

MVP loglari hassas icerik saklamamalidir.

### Faz 2

Audit zorunludur:

- Uye daveti/kaldirma
- Rol degisimi
- Cihaz ekleme/kaldirma
- Sync conflict cozumleri
- Workspace export

### Faz 3

Audit zorunludur:

- API key olusturma/iptal
- Webhook ekleme/silme
- Agent scope degisimi
- AI suggestion approve/reject
- Agent tarafindan tetiklenen eylemler

## 11. Import, Export ve Migration

### MVP Import

- Kaynak: free-task JSON.
- Davranis:
  - Schema version kontrolu.
  - Dry-run veya preview raporu.
  - Transactional import.
  - Duplicate id durumunda merge/rename politikasi.

### MVP Export

- JSON: tam veri tasima.
- Markdown: insan okunabilir gorev/not export.
- Sifreli yedek: local vault backup.

### Migration

- DB schema version `vault_metadata` icinde saklanir.
- Her migration test edilmelidir.
- Migration oncesi sifreli yedek opsiyonu sunulmalıdır.
- Faz 2 sync'e geciste plaintext migration olmamalidir.

## 12. Riskler

| Risk | Etki | Azaltma |
| --- | --- | --- |
| Kurtarma anahtari kaybi | Veri kalici erisilemez | Onboarding dogrulama, tekrar hatirlatici, acik risk dili |
| Acik export yanlis paylasilir | Gizlilik kaybi | Plaintext uyarisi, sifreli yedek varsayilan onerisi |
| Link URL'leri hassas olabilir | Privacy riski | Metadata fetch onayli ve kapatilabilir |
| Local notification lock screen'de hassas baslik gosterir | Gizlilik riski | Bildirim icerigi ayari: basligi goster/gizli metin |
| Faz 2 uyelikte eski cihaz veri tutar | Revocation siniri | Key rotation, cihaz kaldirma uyarisi |
| AI context fazla veri gorur | Gizlilik kaybi | Context preview, notlar varsayilan kapali, scope |
| API key plaintext saklanir | Guvenlik riski | Yalniz token hash sakla, tek sefer goster |

## 13. Acik Sorular

- Kurtarma anahtari kaydetmeden MVP onboarding tamamlanabilir mi, yoksa kesin zorunlu mu?
- Local notification lock screen metni varsayilan olarak gorev basligini gostersin mi, gizlesin mi?
- Sifreli export icin parola mi, kurtarma anahtari mi, ayri backup sifresi mi kullanilacak?
- Faz 2'de workspace owner ayrilmak isterse ownership transfer zorunlu mu?
- Faz 3 AI suggestion'lari ne kadar sure pending saklanacak?

## 14. Handoff to Implementation Plan

Implementation plan asagidaki veri/izin kararlarini gorevlere cevirmelidir:

- SQLCipher tabanli local vault spike.
- Key wrapping, recovery key ve biometric unlock spike.
- Task, recurrence, reminder, import/export temel schema tasarimi.
- Local notification privacy ayarlari.
- Localization icin `app_tr.arb` ve `app_en.arb`.
- Faz 2/Faz 3 icin fiziksel tablo yerine migration reserve ve adapter interface.
- Audit event modelinin MVP/Faz 2/Faz 3 kapsam ayrimi.
