# Launch Plan: free-task

## 1. Launch Objective

free-task MVP'nin ilk launch hedefi public buyume degil, guvenilir **dogfooding** ve ardindan sinirli kapali beta'dir.

Basari tanimi:

- Kullanici 14 gun boyunca gunluk gorev/rutin akisini veri kaybi olmadan kullanabilir.
- Android ve iOS build'leri ayni MVP kapsamiyla calisir.
- Yerel sifreli kasa, recovery key, local notifications, import/export ve offline CRUD release blocker testlerden gecer.
- E2EE/recovery riskleri kullaniciya net anlatilir.

## 2. Audience and Channels

| Kitle | Kanal | Not |
| --- | --- | --- |
| Owner/dogfooding | Lokal build, Android device, iPhone/TestFlight | Ilk hedef |
| Teknik yakin beta kullanicilari | GitHub release veya kapali TestFlight/internal testing | E2EE ve veri kaybi uyarisi ile |
| Public kullanicilar | Gelecek | MVP dogfooding basarili olmadan yok |

MVP icin marketing sitesi, ucretli SaaS veya public app store buyume kampanyasi yoktur.

## 3. Rollout Strategy

| Stage | Audience | Criteria to Enter | Criteria to Exit | Owner |
| --- | --- | --- | --- | --- |
| R0 Dev smoke | Gelistirici | M1-M2 spike'lari tamam | App acilir, kasa spike'i calisir | Owner |
| R1 Personal dogfooding | Owner | M4 vertical slice + P0 testler | 7 gun veri kaybi yok, kritik bug yok | Owner |
| R2 Full MVP dogfooding | Owner | M5 import/export + bildirimler | 14 gun gunluk kullanim, export/recovery testli | Owner |
| R3 Closed beta | Sinirli teknik kullanicilar | Test plan P0 gecti, uyari dokumani hazir | Geri bildirimler triage edildi | Owner |
| R4 Public source release | GitHub kullanicilari | README, install, known issues, license net | Repo baskalari tarafindan denenebilir | Owner |
| R5 App store/public | Gelecek | Support, privacy, crash/diagnostic policy net | Public release karari | TBD |

## 4. Readiness Checklist

- [ ] PRD kabul edildi.
- [ ] UX flows kabul edildi.
- [ ] Technical design kabul edildi.
- [ ] Data-permissions kabul edildi.
- [ ] Implementation milestones M1-M7 tamamlandi.
- [ ] Test plan P0 senaryolari gecti.
- [ ] Android physical device smoke gecti.
- [ ] iOS physical device smoke gecti.
- [ ] Recovery key akisi test edildi.
- [ ] Import/export roundtrip test edildi.
- [ ] Local notification izin kabul/red test edildi.
- [ ] Offline CRUD test edildi.
- [ ] TR/EN localization ve buyuk metin test edildi.
- [ ] Known issues listesi hazir.
- [ ] Rollback/yedek alma talimati hazir.
- [ ] Secret veya production env commit edilmedi.

## 5. Beta/Pilot Plan

### R1 Personal Dogfooding

- Sure: en az 7 gun.
- Veri: gercek ama kritik olmayan gunluk gorevler.
- Gunluk not:
  - Bugun app'i actim mi?
  - Gorev ekleme/tamamlama sorunsuz mu?
  - Bildirimler dogru zamanda mi?
  - Kasa acma/kilitleme rahatsiz ediyor mu?
  - Export aldim mi?

### R2 Full MVP Dogfooding

- Sure: en az 14 gun.
- Gercek rutinler ve deadline'lar kullanilir.
- Haftada en az bir JSON/Markdown export alinir.
- Recovery key davranisi test ortaminda dogrulanir.
- Migration veya schema degisikligi varsa once sifreli yedek alinir.

### R3 Closed Beta

- Kitle: projeyi anlayan, veri kaybi riskini kabul eden az sayida teknik kullanici.
- Kosul:
  - Beta uyari metni okunur.
  - Recovery key saklama sorumlulugu kabul edilir.
  - Geri bildirim GitHub Issues veya belirlenen kanal uzerinden verilir.

## 6. Migration and Data Readiness

MVP ilk release oldugu icin mevcut kullanici migration'i yoktur. Yine de veri hazirligi zorunludur:

- Her release candidate oncesi yedek alinabilir olmalı.
- Export/import roundtrip test edilmelidir.
- Schema migration varsa:
  - Migration oncesi sifreli yedek opsiyonu.
  - Migration basarisiz olursa veri korunur.
  - Migration sonrası acilis smoke testi.
- Acik export kullaniciya plaintext riskiyle anlatilir.

Faz 2 sync'e gecis icin ayri migration launch planı gerekecektir.

## 7. Monitoring, Alerts, and Dashboards

MVP'de remote telemetry varsayilan kapali oldugu icin monitoring su sekilde ilerler:

- Yerel diagnostic log: hassas icerik icermeyen teknik olaylar.
- Kullanici tarafindan export edilebilen diagnostic bundle.
- Manual dogfooding logu.
- GitHub Issues:
  - `bug`
  - `data-loss-risk`
  - `security`
  - `ios`
  - `android`
  - `accessibility`
  - `import-export`

Public telemetry veya crash reporting ileride eklenirse:

- Opt-in olmali.
- Hassas gorev icerigi icermemeli.
- Privacy policy guncellenmeli.

## 8. Support and Feedback

| Kanal | Kullanim |
| --- | --- |
| GitHub Issues | Bug, feature, veri riski, platform sorunu |
| GitHub Discussions veya README notlari | Genel geri bildirim ve fikir |
| Lokal dogfooding notlari | Ilk asamada en onemli kaynak |

Issue template onerileri:

- Bug report.
- Data loss/security concern.
- Import/export issue.
- Notification/platform issue.
- Accessibility issue.

Support ilkesi:

- Veri kurtarma konusunda abartili garanti verilmez.
- Recovery key kaybi durumunda veri erisimi garanti edilemez.
- Beta kullanicilarina bu risk acikca anlatilir.

## 9. Rollback Plan

### App Rollback

- Dogfooding sirasinda onceki calisan build saklanir.
- Yeni build yuklenmeden once sifreli export/yedek alinir.
- Kritik hata halinde:
  1. Uygulama kullanimi durdurulur.
  2. Yeni veri girisi yapilmaz.
  3. Sifreli yedek korunur.
  4. Onceki build'e donulur veya hotfix beklenir.

### Data Rollback

- Migration oncesi yedek zorunlu kabul edilir.
- Import dry-run olmadan merge import yapilmaz.
- Import hatasinda transaction rollback gerekir.

### Feature Rollback

- Local notifications kapatilabilir olmalı.
- Compact density/theme gibi gorunum degisiklikleri ayardan geri alinabilir.
- Faz 2/Faz 3 feature flag'leri MVP'de disabled kalir.

## 10. Post-Launch Metrics

Remote telemetry olmadan takip edilecek metrikler:

| Metrik | Kaynak | Basari Isareti |
| --- | --- | --- |
| 14 gun veri kaybi olmadan kullanim | Dogfooding notu | Kritik veri kaybi yok |
| Gunluk gorev ekleme/tamamlama | Yerel istatistik | Akis gercek ihtiyaci karsiliyor |
| Recovery/export testleri | Manual checklist | Yedek alinabiliyor |
| Bildirim dogrulugu | Manual test | Hatirlaticilar guvenilir |
| Crash/kilitlenme sayisi | Diagnostic/manual | Azalan trend |
| Issue severity | GitHub Issues | P0/P1 azaliyor |
| Accessibility bulgulari | Manual checklist | Blocker yok |

## 11. Communication Plan

### Dogfooding

- Kisa release notu:
  - Neler degisti?
  - Hangi veri riski var?
  - Yedek almam gerekiyor mu?
  - Bilinen sorunlar neler?

### Closed Beta

README veya release notunda net uyarilar:

- Bu surum erken test surumudur.
- Veriler yerel sifreli kasada saklanir.
- Recovery key kaybolursa veri kurtarilamayabilir.
- Kritik tek kopya verileri kullanmadan once yedek alin.
- Geri bildirim icin GitHub Issues kullan.

### Public Source Release

- Kurulum.
- Desteklenen platformlar.
- Kapsam disi Faz 2/Faz 3 ozellikleri.
- Privacy/E2EE notlari.
- Known issues.
- Katki kurallari.

## 12. Risks and Owners

| Risk | Owner | Mitigation |
| --- | --- | --- |
| Veri kaybi | Owner | Sifreli yedek, migration test, rollback talimati |
| Recovery key kaybi | Owner + kullanici | Onboarding uyarisi, dogrulama adimi |
| SQLCipher platform sorunu | Owner | Spike ve fallback degerlendirmesi |
| Bildirim izin/planlama farklari | Owner | Android+iOS device test |
| Public kullanicinin beta riskini anlamamasi | Owner | Release notu ve README uyarisi |
| Remote telemetry eksikligi nedeniyle bug izleme zorlugu | Owner | Manual dogfooding log + diagnostic bundle |

## 13. Open Decisions

- Lisans: MIT, Apache-2.0, GPL/AGPL veya TBD.
- Public app store hedefleniyor mu?
- Crash reporting kullanilacaksa hangi arac ve opt-in modeli?
- Lock screen notification varsayilani gizli metin mi gorev basligi mi?
- Faz 2 sync icin ayri launch planı ne zaman acilacak?

## 14. Final Readiness Summary

free-task MVP, public launch degil once dogfooding odakli cikmalidir. Release hazir sayilmasi icin sifreli kasa, recovery, offline CRUD, local notifications, import/export ve Android+iOS paritesi P0 testlerden gecmelidir. Ilk kapali beta, E2EE ve recovery key risklerini anlayan sinirli teknik kullanicilarla yapilmalidir. Public kaynak kod paylasimi, README, lisans, known issues ve rollback/yedek talimati hazir olduktan sonra dusunulmelidir.
