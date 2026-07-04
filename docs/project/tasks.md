# free-task Tasks

Bu dosya yasayan implementation takip listesidir. Yeni uygulama isi baslamadan once buraya eklenmelidir. Secret, token, production env, private upload veya ilgisiz local degisiklikler commit edilmez.

## M0 Repo ve Planlama Temeli

- [x] PLAN-01 PRD olusturuldu.
- [x] PLAN-02 Claude design brief olusturuldu.
- [x] PLAN-03 Claude tasarim teslimati repo icine alindi.
- [x] PLAN-04 UX flows dogrulandi ve genisletildi.
- [x] PLAN-05 Technical design olusturuldu.
- [x] PLAN-06 Data-permissions dokumani olusturuldu.

Commit noktasi: planlama artifact'leri tek veya az sayida docs commit'iyle saklanir.

## M1 Flutter Scaffold ve App Shell

- [ ] SET-01 `.gitignore`, README, license karari ve docs linklerini hazirla.
- [ ] SET-02 `apps/free_task_flutter/` Flutter projesini olustur.
- [ ] SET-03 `pubspec.yaml` dependency politikasini ve lockfile'i olustur.
- [ ] SET-04 Format/analyze/test icin CI taslagi ekle.
- [ ] DES-01 Claude Flutter theme tokenlarini app'e entegre et.
- [ ] DES-02 TR/EN localization iskeletini kur.
- [ ] UI-01 Alt bar, FAB ve routing app shell'ini kur.

Commit noktasi: bos ama calisan, temali ve iki dilli app shell.

## M2 Sifreli Kasa ve Platform Spike'lari

- [ ] SEC-01 SQLCipher Android+iOS encrypted DB spike.
- [ ] SEC-02 Password KDF ve key wrapping spike.
- [ ] SEC-03 Biyometrik unlock + parola fallback spike.
- [ ] SEC-04 Kurtarma anahtari create/verify spike.
- [ ] NOT-01 Local notification permission smoke test.

Commit noktasi: E2EE/local vault riski azaltilmis spike seti.

## M3 Core Data ve Domain

- [ ] DAT-01 Task schema ve repository.
- [ ] DAT-02 Subtask, tag, link, attachment schema.
- [ ] DAT-03 Recurrence ve occurrence hesaplama.
- [ ] DAT-04 Reminder model ve scheduling interface.
- [ ] QA-01 Unit/widget/integration test iskeleti.

Commit noktasi: sifreli storage uzerinde testli domain CRUD.

## M4 MVP UI Vertical Slice

- [ ] UI-02 Kasa kurulumu ve locked vault.
- [ ] UI-03 Bugun listesi ve task row.
- [ ] UI-04 Yeni gorev bottom sheet + parser cipleri.
- [ ] UI-05 Gorev detay ve alt gorevler.
- [ ] UI-06 Tekrar editoru.
- [ ] UI-07 Havuz ve Takvim.
- [ ] UI-08 Ayarlar, dil, tema, density.

Commit noktasi: ilk gercek gunluk kullanim akisi.

## M5 Import/Export, Bildirim ve Istatistik

- [ ] NOT-02 Reminder schedule/reschedule/cancel.
- [ ] IMP-01 JSON export ve sifreli backup taslagi.
- [ ] IMP-02 Markdown export.
- [ ] IMP-03 free-task JSON import + dry run.
- [ ] STA-01 Basit istatistik ozeti.

Commit noktasi: veri ozgurlugu ve hatirlatici akislari.

## M6 UX Polish ve Erisilebilirlik

- [ ] QA-02 TR/EN text overflow ve buyuk metin testleri.
- [ ] QA-03 Screen reader semantics.
- [ ] QA-04 Light/dark ve compact/default density snapshot kontrolu.
- [ ] QA-05 Swipe aksiyonu + buton alternatifi paritesi.

Commit noktasi: tasarim referansina yakin, erisilebilir MVP.

## M7 Beta Hardening

- [ ] REL-01 Android internal build.
- [ ] REL-02 iOS TestFlight hazirligi.
- [ ] QA-06 Offline CRUD ve veri kaybi regresyonu.
- [ ] QA-07 Migration ve recovery senaryolari.
- [ ] QA-08 Dogfooding checklist.

Commit noktasi: kapali beta/dogfooding build.

## M8 Faz 2/3 Hazirlik Sinirlari

- [ ] FUT-01 Sync adapter interface ve feature flag.
- [ ] FUT-02 AI/agent/API adapter interface ve scope placeholder.
- [ ] FUT-03 Disabled future features guard testleri.

Commit noktasi: MVP'yi sisirmeyen genisleme sinirlari.

## Notlar

- Uygulama baslamadan once `implementation-plan.md` ve bu tracker birlikte guncel tutulur.
- Paket kurulumlari ve GitHub write islemleri onay gerektirebilir.
- Kapsam disi isler Faz 2/Faz 3 basligi altinda tutulur; MVP task'larina karistirilmaz.
