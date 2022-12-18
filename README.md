# Final Project - Game Project

## Oyun Listeleme Ekranı
• Açılış ekranında oyunlar listeli bir şekilde gelir.
• Oyun hakkındaki genel bilgiler yer alır.
• Herhangi bir oyuna tıklandığı zaman oyunun detay ekranına yönlendirir.
![Ana Ekran - En](https://user-images.githubusercontent.com/101670054/208315624-fc4ce1d5-b2b4-4802-837c-e7cae397394b.png)

• Listeleme simgesine tıklayarak nelere göre listelenebileceği görünür.
![Detay Ekranı List - En](https://user-images.githubusercontent.com/101670054/208315954-e8c5650b-7c86-465f-9ba3-a1b303a41f76.png)

## Oyun Detay Ekranı

• Listeden tıklanılan oyunun detayı gösterilir.
• Oyun hakkındaki detay bilgiler yer alır.
• En alttaki butondan favorilere ekleyerek favori listesinde görüntülenir.
• Favorilerden çıkarınca foviri listesinden silinir.
![Detay Ekranı Fav - En](https://user-images.githubusercontent.com/101670054/208316058-90d1a571-a244-4d6e-a384-e2bb96b859d4.png)![Detay Ekranı - En](https://user-images.githubusercontent.com/101670054/208316055-f28d00fe-cead-40f2-868b-80ed4386f156.png)

## Favori Listeleme Ekranı
• Detay ekranında favori olarak eklenen oyunlar listelenir.
![Favori Listesi - En](https://user-images.githubusercontent.com/101670054/208316116-1641d64a-23f0-4c1b-b07e-ee6bb57a89d4.png)

## Not Listeleme Ekranı
• Not listeleme ekranında eklenen notlar görünür. 
• Not listeleme ekranındaki add butonu ile not ekleme ekranına yönlendirilir.
• Not listeleme ekranındaki herhangi bir nota tıklayarak notu güncelleme ekranı açılır.
• Notu sola doğru kaydırınca not silinebilir.
• Notta son yapılan değişiklik zamanı yer alır.
![note listeleme](https://user-images.githubusercontent.com/101670054/208316144-b36551ab-5107-4ff2-829d-cb0d58aa8d7a.png)![yana kaydırarak silme](https://user-images.githubusercontent.com/101670054/208316195-8d743cc1-bd95-4ef5-b3b9-3b904a1e052c.png)

## Not Ekleme Ekranı
• Not ekleme ekranında oyun ismi ve not bilgisi girilerek add butonu ile not kaydedilir. 
• Not kaydedildikten sonra listeleme ekranında görünür.
• Yeni not eklenirken tüm alanlar zorunlu olarak girilmelidir.
• Not güncelenecekse not isminde değişiklik yapılamaz, yalnızca not değiştirilir. 
![not eklerken her alanı girmelisin](https://user-images.githubusercontent.com/101670054/208316376-4ebb142c-72c0-4d1e-9cb7-9f1c42636201.png)![notta değişiklik olması lazım](https://user-images.githubusercontent.com/101670054/208316378-79045627-a1d8-4997-955e-88934c8f55e2.png)

## Bildirim
• Oyundan çıkınca 10 saniye sonra bildirim gelir.
![Simulator Screen Shot - iPhone 14 Pro - 2022-12-18 at 22 50 05](https://user-images.githubusercontent.com/101670054/208316430-0ee6e1c0-3e16-4e7e-8c95-03cddc150590.png)


# final-project

Vakıfbank IOS Swift Bootcamp Bitirme Projesi

Genel Detaylar:
3 ana ekrandan oluşan public API tabanlı bir uygulaması yapılması beklenmektedir.(API
sonradan kararlaştırılacaktır.)
Aşağıda yazılmış olan tüm maddeler ideal uygulamayı tarif etmekle beraber; herkes
başardığı özelliklere göre değerlendirilecektir.
Yapılmış maddelerin başarılı uygulanmış olması tüm maddeleri tamamlamaktan daha
önemlidir.
Git Kullanımı:
- Uygulama github.com sayfasına public repo olarak yüklenmelidir.
- Git commitleri atomic olmalı ve genel commit mesajları kurallarına dikkat
edilmelidir. - Commit mesajları atılırken branch yapısına dikkat edilmelidir.
(Develop, Feature vb. branch’ler oluşturulmalıdır.)
1. Ekran: (Liste Ekranı)
- MVVM pattern’i ile yazılmalıdır.
- Item’lar arasında arama yapılabilmelidir.
- Item’ları sıralama butonu ile sıralanabilmelidir.
- Sadece item’lar güncellendiğinde görünüm güncellenmelidir. (Ekrana her
girişte güncelleme olmamalı)
2. Ekran: (Detay Ekranı)
- MVVM pattern’i ile yazılmalıdır.
- Item’a basıldığında ilgili detaya yönlenmelidir.(Alanlar belirtilecektir.)
- Edit işlemleri için aynı ekran kullanılacaktır.
- Düzenlemede tüm alanlar eklenmemişse item kaydedilmemelidir.
3. Ekran: (Yeni Giriş Ekranı)
- MVVM pattern’i ile yazılmalıdır.
- Ekran present şekilde açılmalıdır.
- Ekleme tüm alanlar eklenmemişse item kaydedilmemelidir.
Uygulama gereklilikleri:
- SPM veya Cocoapods kullanılmalıdır.
- Uygulamada hata mesajları ve bekleme esnasında activity indicator

kullanılmalıdır.. - İşlemler CoreData ile yapılmalıdır.
- CoreData’ya bir CoreDataManager üzerinden erişilmelidir.
- Local push entegrasyonu sağlanmalıdır.
- Notification yönetimi bir localNotificationManager aracılığıyla
yapılmalıdır. - Localization sağlanmalıdır.
- ViewModel localNotificationManager’a notificationManager protokolü üzerinden
erişmelidir.
- Uygulamanın unit test yaklaşımı ve coverage yüzdesi değerlendirme kriterleri
arasındadır.
- UI ve animasyon tamamen tercihe bağlı olup farklı cihaz görünümleri
gözetilmelidir.

1- API - https://rawg.io/apidocs - Dokümantasyon Chrome ile açılmalıdır.
2- Git reposu public gözüküyor ancak ödevler nasıl yükleniyorsa aynı sistem kullanılacaktır.
3- ReadMe dosyası repoda olmalıdır.
4- Liste ekranı için istenilen filtre kullanılabilir(2022 de çıkan oyunlar, platforma özel
oyunlar veya popüler oyunlar olabilir.)
5- Detay ekranında Fotoğraf ve en az 4 bilgi olacak.
6- Listeden detaya gidildiğinde favorilere ekleme olacak başka bir editleme olmayacak.(2.
Ekrandaki editleme maddesi)
7- Favorilerin listelendiği bir ekran olacak.
8- Liste şeklinde Notlar ekranı olacak. Oyunlara ait not ekleyebileceğim ve mevcut notları
düzenleyebileceğim.(Dokümandaki 3. Ekran Yeni giriş ekranı bu kısımda olacak)
9- Hatalar yakalanmalı ve alert şeklinde gösterilmelidir.
