# Claude Design Brief: free-task MVP

## Ne zaman kullanilacak?

Bu brief, PRD tamamlandiktan sonra ve teknik tasarimdan once kullanilmalidir.

Amac, Claude Design'dan dogrudan final UI istemek degil; once mobil oncelikli urun deneyimini, ekran hiyerarsisini, ana akisları ve gorsel dili netlestirmektir. Claude Design ciktisi daha sonra `docs/project/ux-flows.md` dokumanina donusturulecek ve teknik tasarima girdi olacaktir.

## Claude Design'a verilecek dosyalar

1. `docs/project/prd.md`
   - Ana kaynak budur.
   - Eski fikir listesi Claude'a verilmemelidir; kapsam sapmasi yaratabilir.

2. Varsa sonradan eklenecek tasarim referanslari
   - Logo, renk tercihi, font tercihi, sevdigin uygulama ekranlari.
   - Su an zorunlu degil.

## Claude Design'dan istenecek cikti

- Mobil oncelikli MVP uygulama tasarimi.
- Marketing/landing page degil, gercek uygulama ekranlari.
- Low-fidelity akis mantigi + high-fidelity ilk gorsel yon.
- Light ve dark tema yonu.
- Sade uretkenlik araci hissi; yogun, okunakli, dikkat dagitmayan deneyim.
- E2EE ve offline kullanilabilirlik gibi guven/guvenlik durumlarinin UI'da nasil anlatilacagi.
- Ana ekranlar, durumlar ve component/tasarim token onerileri.

## Oncelikli ekranlar

1. Ilk acilis ve yerel sifreli kasa kurulumu.
2. Bugun/Gunluk liste.
3. Yeni gorev ekleme bottom sheet veya tam ekran formu.
4. Gorev detay ve alt gorevler.
5. Zamanlama/tekrar kuralı duzenleme.
6. Havuz/Zamansiz gorevler.
7. Takvim veya tarih secici.
8. Istatistik ozeti.
9. Ayarlar: gizlilik, export/import, tema, tamamlanan gorev davranisi.
10. Offline, bos liste, hata ve permission denied durumlari.

## Claude Design icin kopyalanabilir prompt

```text
Sen deneyimli bir mobil uygulama product designer ve design systems uzmani gibi davran.

Asagidaki PRD'ye dayanarak "free-task" icin ilk MVP tasarim konseptini hazirla. Bu bir landing page veya marketing sitesi degil; gercek, kullanilabilir, mobil oncelikli gorev/rutin yonetim uygulamasi tasarimi olmali.

Urun ozeti:
- free-task bireysel kullanim icin mobil oncelikli, cok platformlu bir gorev/rutin yonetim uygulamasi.
- Sade, hizli, dikkat dagitmayan bir uretkenlik araci olmali.
- Offline kullanilabilirlik onemli: temel gorev akislari internetsiz calismali.
- E2EE ve yerel sifreli kasa bastan zorunlu urun prensibi.
- MVP'de SaaS, self-host sync, multi-user, AI ajanlari, public API ve leaderboard yok.
- Kisisellestirme var ama MVP'de basit kalmali: light/dark tema, tamamlanan gorevleri gizle veya ustu cizili goster.

Tasarim hedefi:
- Mobil oncelikli dusun.
- Sade ama kuru olmayan, guven veren, uzun sure her gun kullanilabilecek bir arayuz tasarla.
- Gorev listesi yogun bilgiyi okunakli gostersin.
- Ana aksiyonlar tek elle erisilebilir olsun.
- Swipe aksiyonlari olabilir ama her swipe icin buton alternatifi de dusun.
- E2EE/offline gibi teknik guven unsurlarini korkutmadan, abartmadan, kullaniciya guven verecek sekilde UI'a yerlestir.
- Kart icinde kart, asiri dekoratif gradient/orb, landing page hero, buyuk pazarlama basliklari, gereksiz illüstrasyon kullanma.

Lutfen su ciktilari uret:

1. Tasarim yonu
   - 2 farkli gorsel yon oner: "quiet productivity" ve "customizable power-user light".
   - Her yon icin kisaca renk, tipografi, spacing, icon ve hareket hissini anlat.
   - Sonunda MVP icin tek bir onerilen yon sec.

2. Bilgi mimarisi ve navigasyon
   - Ana sekmeler veya ana navigasyon modelini oner.
   - Mobilde ilk ekranda kullanici ne gormeli?
   - Hangi aksiyonlar bottom navigation, floating action button, toolbar veya bottom sheet icinde olmali?

3. Ana ekranlar
   Asagidaki ekranlari tasarla ve her biri icin layout, ana bilesenler, primary/secondary aksiyonlar, kritik state'ler ve mikro metinleri yaz:
   - Ilk acilis ve yerel sifreli kasa kurulumu
   - Bugun/Gunluk liste
   - Yeni gorev ekleme
   - Gorev detay ve alt gorevler
   - Zamanlama/tekrar kuralı duzenleme
   - Havuz/Zamansiz gorevler
   - Takvim veya tarih secici
   - Istatistik ozeti
   - Ayarlar: gizlilik, export/import, tema

4. Durumlar
   - Empty, loading, offline, error, success, permission denied, locked vault, import error, metadata fetch failed durumlarini tasarla.

5. Component sistemi
   - Task row/card
   - Priority/effort indicator
   - Tag chip
   - Recurrence badge
   - Deadline warning
   - Subtask row
   - Bottom sheet form controls
   - Calendar/date picker
   - Settings rows/toggles
   - Privacy/security status elements

6. Design tokens
   - Light ve dark tema icin renk tokenlari
   - Typography scale
   - Spacing scale
   - Radius, shadow/elevation, divider kurallari
   - Icon stili

7. Uygulanabilirlik kontrolu
   - Flutter ile uygulanmasi zor olabilecek UI kararlarini isaretle.
   - Ekran okuyucu, kontrast, buyuk metin ve tek elle kullanim notlarini ekle.

8. Cikti formati
   - Once kisa tasarim rasyoneli.
   - Sonra ekran ekran spesifikasyon.
   - Sonra component/tokens listesi.
   - Sonunda "Codex'e geri verilecek tasarim ozeti" adli bolum: UX flow dokumanina aktarilmasi gereken kararları madde madde yaz.

Simdi PRD'yi okuyup tasarimi buna gore hazirla. PRD disinda yeni buyuk ozellik ekleme; gerekiyorsa "sonraki faz" olarak not et.
```

## Claude ciktisini geri getirirken

Claude Design ciktisini su sekilde kaydetmek iyi olur:

- `docs/design/claude-v1/design-summary.md`
- `docs/design/claude-v1/screens/01-vault-setup.png`
- `docs/design/claude-v1/screens/02-today.png`
- `docs/design/claude-v1/screens/03-add-task.png`
- `docs/design/claude-v1/screens/04-task-detail.png`
- `docs/design/claude-v1/screens/05-repeat-editor.png`
- `docs/design/claude-v1/screens/06-settings.png`

Bu ciktidan sonra Codex'te sira:

1. `$ux-flow-planner` ile `docs/project/ux-flows.md` olusturmak.
2. Tasarim kararlarini teknik kisitlarla birlikte `$technical-design` dokumanina aktarmak.
3. Sonra `$data-permissions`, `$implementation-plan`, `$test-plan`, `$launch-plan` sirasina devam etmek.
