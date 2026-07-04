# Test Plan: free-task

## 1. Kaynak Kapsam

| Alan | Deger |
| --- | --- |
| Kaynaklar | `prd.md`, `ux-flows.md`, `technical-design.md`, `data-permissions.md`, `implementation-plan.md` |
| Test kapsami | MVP dogfooding ve kapali beta hazirligi |
| Platformlar | Android + iOS es zamanli |
| PC/desktop uyumlulugu | Resmi MVP release degil; scaffold sonrasi desktop/web smoke build kontrolu |
| Diller | Turkce + Ingilizce |
| MVP risk alanlari | Sifreli kasa, recovery, local notifications, offline CRUD, recurrence, import/export, accessibility |
| Kapsam disi | Faz 2 sync, Faz 3 AI/API/agent gercek entegrasyonu; yalniz disabled guard testleri |

## 2. Test Stratejisi

Risk-first test yaklasimi:

1. **Security/storage once:** SQLCipher, key wrapping, recovery ve locked vault test edilmeden veri uzerine feature kurulmaz.
2. **Domain correctness:** Task CRUD, recurrence, reminder ve timezone testleri unit seviyesinde kapsanir.
3. **UX vertical slice:** F1-F9 MVP akislari integration/widget testleriyle dogrulanir.
4. **Platform parity:** Android ve iOS izin, biyometrik, dosya, bildirim davranislari manuel ve cihaz/simulator testleriyle kontrol edilir.
5. **PC compatibility guard:** Desktop/web resmi release kapsami degildir; scaffold sonrasi derleme smoke testi ve plugin uyumluluk notu tutulur.
6. **No data loss:** Migration, import/export, crash/restart ve offline senaryolari release blocker kabul edilir.
7. **Accessibility and localization:** TR/EN, buyuk metin, screen reader ve kontrast release oncesi zorunludur.

## 3. Environment ve Desteklenen Platformlar

| Environment | Amac | Zorunlu Testler |
| --- | --- | --- |
| Local dev | Unit/widget test | Domain, parser, recurrence, repository |
| Android emulator | Smoke/integration | Kasa, bildirim izinleri, navigation, export/import |
| Android physical device | Dogfooding | Biyometrik, local notification, dosya izinleri |
| iOS simulator | Smoke/integration | Kasa, navigation, localization, export/import |
| iOS physical device | Dogfooding/TestFlight | Face ID/Touch ID, local notification, background/resume |
| Desktop/web smoke | Uyumluluk guard | Resmi release olmadan Flutter scaffold ve kritik plugin derleme uyumu |
| Release beta | Kapali beta | Regression, migration, privacy checklist |

Minimum cihaz matrisi uygulama baslarken netlestirilecek; simdilik bir guncel Android, bir dusuk/orta Android ve bir guncel iPhone hedeflenir.

## 4. Requirement Coverage

| Requirement | Test Type | Cases | Release Blocking? |
| --- | --- | --- | --- |
| Yerel sifreli kasa | Unit, integration, manual | Kurulum, lock/unlock, restart, wrong password, recovery | Evet |
| Parola + biyometrik + recovery | Integration, manual | Biyometrik basarisiz, parola fallback, recovery verify | Evet |
| Offline CRUD | Unit, integration, manual | Ucak modu task CRUD, liste, detay, arsiv | Evet |
| Task/subtask/recurrence/deadline | Unit, widget | CRUD, invalid recurrence, deadline overdue | Evet |
| Local notifications | Integration, manual | Izin verildi/reddedildi, schedule, cancel, reschedule | Evet |
| TR/EN UI | Widget, visual/manual | Locale switch, long text, system language | Evet |
| Import/export | Unit, integration, manual | JSON, Markdown, encrypted backup, import rollback | Evet |
| Accessibility | Manual, widget semantics | Screen reader, touch target, contrast, text scale | Evet |
| Design parity | Visual/manual | Claude screens 01-13 MVP parity | Hayir, ama beta oncesi gerekli |
| PC/desktop smoke | Build/manual | Scaffold sonrasi desktop/web build denenir, blokajlar notlanir | Hayir, resmi MVP release degil |
| Faz 2/3 disabled guards | Unit/integration | Sync/AI/API UI acik degil, adapter no-op | Evet |

## 5. Manual Test Cases

| ID | Scenario | Steps | Expected Result | Priority |
| --- | --- | --- | --- | --- |
| MAN-01 | Ilk kurulum | App ac, dil sec, parola gir, recovery key dogrula | Kasa olusur, Bugun acilir | P0 |
| MAN-02 | Yanlis parola | Locked vault ekraninda hatali parola gir | Veri acilmaz, nazik hata, veri korunur | P0 |
| MAN-03 | Biyometrik fallback | Biyometrik iptal et veya basarisiz yap | Parola fallback calisir | P0 |
| MAN-04 | Recovery key | Parola unutma akisini recovery key ile dene | Kasa kurtarilir veya net hata verir | P0 |
| MAN-05 | Ucak modu CRUD | Ucak modunda gorev ekle/duzenle/tamamla | Tum cekirdek akiş calisir | P0 |
| MAN-06 | NLP gorev ekleme | "yarin 15:00 rapor" ve "tomorrow 3pm report" yaz | Tarih/saat cipleri dogru onerilir | P1 |
| MAN-07 | Tekrar kuralı | Haftalik Pzt/Çar rutin kur | Preview dogru, invalid rule kaydedilmez | P0 |
| MAN-08 | Local notification izin verildi | Hatirlatici kur, izin ver | Bildirim planlanir ve tetiklenir | P0 |
| MAN-09 | Local notification izin reddi | Hatirlatici kur, izin reddet | Gorev kaydedilir, bildirim yok, UI uyarir | P0 |
| MAN-10 | Export JSON/Markdown | Veri olustur, export al | Dosyalar okunabilir/yeniden import edilebilir | P0 |
| MAN-11 | Import hata | Bozuk JSON import et | Hata raporu gorulur, mevcut veri bozulmaz | P0 |
| MAN-12 | Dil degistirme | Ayarlar'dan TR/EN degistir | UI yeniden baslatmadan guncellenir | P1 |
| MAN-13 | Buyuk metin | Sistem text scale artir | UI tasmaz, butonlar kullanilabilir | P0 |
| MAN-14 | Screen reader | VoiceOver/TalkBack ile ana akislari gez | Butonlar ve task durumlari anlamli okunur | P0 |
| MAN-15 | Dark mode | Sistem ve app dark mode dene | Kontrast korunur | P1 |
| MAN-16 | App restart | Task ekle, app'i kapat/ac | Veri korunur, kasa policy uygulanir | P0 |

## 6. Automation Candidates

### Unit Tests

- Task model validation.
- Recurrence rule hesaplama.
- Parser TR/EN tarih/saat ifadeleri.
- Reminder time calculation.
- Import/export serializer.
- Key metadata model validation.

### Repository Tests

- Encrypted DB CRUD.
- Transaction rollback.
- Migration forward/backward smoke.
- Soft delete/archive behavior.

### Widget Tests

- Kasa kurulumu form validation.
- Locked vault error states.
- Bugun listesi empty/loading/success.
- Yeni gorev bottom sheet validation.
- Tekrar editoru invalid rule.
- Ayarlar language/theme toggles.

### Integration Tests

- F1-F4: Onboarding -> Bugun -> Gorev ekle -> Tamamla.
- F8-F9: Ayarlar -> bildirim izni -> hatirlatici kur.
- Import/export roundtrip.
- App restart persistence.

### Visual Regression

- Claude MVP screens 01-13 icin snapshot parity.
- Light/dark ve default/compact density.
- TR/EN text overflow.

## 7. Role ve Permission Tests

### MVP

- Local owner tum yerel veriyi yonetebilir.
- Remote role yoktur.
- Kasa kilitliyken gorev icerigi UI'da render edilmez.
- Bildirim izni reddedildiginde gorev kaydi engellenmez.
- Dosya izni reddedildiginde export/import akisi net hata verir.

### Faz 2 Guard Tests

- Sync ayarlari MVP build'inde aktif degildir veya disabled feature flag arkasindadir.
- Workspace/roller UI'i MVP'de ana akisa sizmaz.

### Faz 3 Guard Tests

- AI komut, agent/plugin, API/webhook MVP'de aktif degildir.
- AI suggestion modeli onay olmadan task yaratamaz.

## 8. Edge Case'ler

- Parola dogru ama DB key metadata bozuk.
- Recovery key yanlis veya eksik blok.
- Biyometrik ayarlari OS seviyesinde degismis.
- Cihaz timezone'u degisti.
- DST gecis gununde tekrar eden gorev.
- Deadline gecmis ve gorev tamamlanmamis.
- Reminder zamani gecmis.
- App notification izinleri sonradan OS ayarlarindan kapatilmis.
- Import dosyasinda duplicate id.
- Export sirasinda dosya yazma izni kesildi.
- Link metadata timeout.
- App, DB write sirasinda kapanir.
- TR/EN uzun metin butona sigmaz.
- Buyuk text scale bottom sheet'i tasirir.

## 9. Accessibility Checks

- Tum icon-only butonlarda semantic label.
- Checkbox state'i "tamamlandi/tamamlanmadi" okunur.
- Task row, deadline, recurrence ve priority sadece renkle ayirt edilmez.
- Touch targets minimum 44x44 px.
- TalkBack ve VoiceOver ile F1-F9 akislari tamamlanabilir.
- Text scale artinca task row sarilir, veri kaybi veya overlap olmaz.
- Light/dark kontrast WCAG AA hedefini karsilar.
- Swipe aksiyonlarinin buton alternatifi vardir.

## 10. Security ve Privacy Checks

- Plaintext task icerigi kalici depoya yazilmaz.
- Kasa kurulmadan task olusturulamaz.
- Wrong password ile DB acilmaz.
- Plaintext key loglanmaz.
- Debug loglar gorev basligi/not/link icermez.
- Acik export onay ister.
- Sifreli yedek tekrar import edilebilir.
- Lock screen notification varsayilani privacy review'den gecmeli.
- AI/sync/API MVP'de disabled kalir.
- Link metadata fetch kullanici onayi veya acik ayar olmadan calismaz.

## 11. Performance ve Reliability Checks

- Bugun ekranı tipik cihazda 1 saniyenin altinda algilanabilir acilir.
- 10.000 task ile liste scroll ve arama kabul edilebilir.
- Recurrence hesaplari sinirli tarih araliginda yapilir.
- Import/export buyuk dosyada UI'i kilitlemez.
- Local notification scheduling app restart sonrasi korunur.
- App crash/restart sonrasi DB tutarliligi korunur.
- Backdrop blur performans sorunu varsa fallback zemin kullanilir.

## 12. Regression Suite

Her release candidate icin:

1. Onboarding ve vault unlock.
2. CRUD + recurrence + deadline.
3. Local notification permission/schedule.
4. Import/export roundtrip.
5. TR/EN locale switch.
6. Light/dark + compact/default.
7. Offline mode.
8. Accessibility smoke.
9. Migration smoke.
10. Disabled Faz 2/3 guard.

## 13. Release Checklist

- [ ] Tum P0 testler gecti.
- [ ] Android physical device smoke gecti.
- [ ] iOS physical device smoke gecti.
- [ ] PC/desktop ve web smoke build sonucu notlandi.
- [ ] Import/export roundtrip gecti.
- [ ] Recovery key akisi gecti.
- [ ] Bildirim izin reddi ve kabul akislari gecti.
- [ ] Accessibility P0 kontrolleri gecti.
- [ ] Remote telemetry kapali.
- [ ] Secret veya production env commit edilmedi.
- [ ] Known issues listesi yazildi.
- [ ] Dogfooding rollback/yedek talimati hazir.

## 14. Riskler ve Acik Sorular

| Risk/Soru | Etki | Aksiyon |
| --- | --- | --- |
| SQLCipher adapter platform sorunu | MVP blokaji | Spike P0 |
| Recovery key UX fazla surtunmeli | Onboarding terk | Dogfooding gozlemi |
| Notification exact timing platform farki | Hatirlatici guveni | Android/iOS manual test |
| Desktop/web plugin uyumlulugu | Ileride PC destegini geciktirebilir | Scaffold sonrasi smoke build ve risk notu |
| Lock screen notification privacy | Hassas veri sizabilir | Varsayilan gizli metin onerilir |
| TR/EN metin uzunlugu | UI tasmasi | Snapshot ve text scale testleri |
| Migration veri kaybi | Kritik | Backup + rollback testleri |

## 15. Handoff to Launch Plan

`$launch-plan` sunlari kapsamalidir:

- Dogfooding sirasi ve ilk kullanici grubu.
- Android internal testing ve iOS TestFlight stratejisi.
- Beta uyari metinleri: E2EE, recovery key, veri kaybi riski.
- Support/feedback kanali.
- Rollback ve yedek alma talimati.
- Post-launch olcum: yerel dogfooding metrikleri ve issue takibi.
