# **MTA (Multi Theft Auto) için Hile Engelleme Sistemi**

Multi Theft Auto (MTA) için Hile Engelleme Sistemi projesine hoş geldiniz. Bu depo, MTA'nın çok oyunculu ortamında oyunun bütünlüğünü ve adaletini artırmayı amaçlayan bir hile engelleme sistemi geliştirmek için oluşturulmuştur.

[Video Nasıl Kurulur + AntiVPN](https://youtu.be/XuNNihYl7KE)

# DUYURU
Türkiye'deki engellemeler nedeniyle bazı bağlantılar reddediliyor, bir VPN kullanın ve anticheat ile test edin
anticheat veritabanına ve harici koda bağlantı bir Türk sunucusunda test edildi ve bağlantı kurulamadı.
Bu yüzden **VPN KULLANIN**

[Türkçe sunucu için anticheat indir](https://github.com/ruip005/mta_anticheat/releases/tag/v1.3.1.01T)

## Kimlik Doğrulama

### Hile engelleme sistemini başlatmak için kimlik doğrulama.

| Değişken | Tür      | Açıklama                             |
| :------- | :------- | :------------------------------------ |
| `user`   | `string` | **Zorunlu**. Kullanıcı adı           |
| `key`    | `string` | **Zorunlu**. Kullanıcı etkinleştirme anahtarı |

### Bazı ücretsiz kimlik doğrulamaları.

1.
**Kullanıcı**: `trial01`

**Anahtar**: `f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85`

2.
**Kullanıcı**: `trial02`

**Anahtar**: `a0b27debfdda2cb2e99f4faf47b8f6b7b758b0c1c36f53d42078d9df9212c252`

3.
**Kullanıcı**: `trial03`

**Anahtar**: `656f0a57cb751e8f55779b991ba4ea016e870b68f2d86271dfe0701bfe70f300`

## Genel Bakış

Bu proje, Multi Theft Auto için verimli ve sağlam bir hile engelleme sistemi oluşturmayı amaçlamaktadır. Hile engelleme sistemi, oyuncuların oyun deneyimini olumsuz etkileyebilecek hileleri, hileleri ve diğer sahtekarlık faaliyetlerini tespit etmeyi ve önlemeyi amaçlamaktadır.

## Özellikler

- **Ekran Görüntüsü**: Şüpheli oyuncunun ekran görüntüsünü alır ve bunu personelin ekranında gösterir ve antihile modunun içinde bir klasöre kaydeder.

- **Discord Webhook**: Bu antihile sistemi, web kancaları aracılığıyla Discord kanallarına gönderilen kayıtları içerir.

- **Anti Ekran Görüntüsü**: Etkinleştirildiğinde, bu özellik yalnızca oyuncuların "Ekran görüntülerini göndermeye izin ver" seçeneğini etkinleştirdiklerinde sunucuya katılmalarına izin verir.

- **Tuş Bağlamaları**: Bu özellik, hileleri açmak için genellikle kullanılan tuşları bastığında personele uyarı verir.

- **Anti "Backdoor"**: Bu özellik derlenmiş modlardaki gizli komutları bulmaya yardımcı olur.

- **Yol**: Bu özellik sunucudaki belirli bir modun konumunu bulmaya yardımcı olur.

- **Silahlar Kara Listesi**: Bu özellik, sunucuda izinsiz silahlar taşıyan oyuncuları tespit eder ve sonra onları yasaklar (personel hariç).

- **Araçlar Kara Listesi**: Bu özellik, sunucuda izinsiz araçlara sahip oyuncuları tespit eder ve sonra onları yasaklar (personel hariç).

- **Oyun Hızı**: Bu özellik, bir oyuncunun oyun hızının normalden yüksek olup olmadığını tespit eder.

- **Anti Jetpack**: Bu özellik, bir oyuncunun personel olmadığı ve Jetpack kullandığı durumları tespit eder ve oyuncuyu yasaklar.

- **Anti Uçma [BETA]**: Bu özellik henüz %100 tamamlanmış değil, ancak amacı, bir oyuncunun sunucu personeli olmadan uçtuğunu tespit etmektir.

- **RPG Ateşi**: Silahlar kara listesi özelliği bir şey tespit etmezse, bu RPG Ateşi özelliği etkinleştirilir. Bir oyuncunun RPG kullandığında bir tetikleyiciyi etkinleştirir ve ardından hileyi yasaklar.

- **Tank Ateşi**: Yukarıdaki özellikle benzerdir, ancak bir hilecinin bir tanktan ateş ettiği durumlar için geçerlidir.

- **VBR Oluştur**: Bu özellik VBR kullananlar içindir ve tank ve hydra oluşturma seçeneğini içerir; bu özellik hileyi yasaklayacak şekilde, hilecinin müşteri tarafında bir tanka ve sunucu tarafında başka bir araca sahip olup olmadığını kontrol eder.

- **Anti Kaynak Durdurma**: Bu özellik, müşterinin önemli modları devre dışı bırakması durumunda sunucu modlarının kapanmasını önler; bu tür durumlarda oyuncu yasaklanır.

- **Anti Aimbot [BETA]**: Bu özellik henüz %100 tamamlanmış değil, ancak amacı bir oyuncunun nişan alma hızının gerçek bir aimbot kullanıyormuş gibi hızlı olduğunu tespit etmektir.

- **Personel Serileri**: Bu özellik etkinleştirildiğinde, sadece kayıtlı serilere sahip olan personele giriş izni verir.

- **Personel Wallhack**: Bu özellik sadece sunucu personeli için geçerlidir ve yakındaki oyuncuların nerede olduğunu belirlemeye yardımcı olur.

- **Yasaklama ve Kaldırma Kayıtları**: Bu özellik bir oyuncuyu kimin yasakladığı veya kald

ırdığı hakkında Discord'a bilgi gönderir.

- **Global Yasaklama**: Bu özellik antihileye özgüdür ve etkinleştirildiğinde, oyuncuların yakın zamanda hile kullandıklarında sunucuya girdiklerinde sistem tarafından yasaklanırlar.

- **Anti Yasaklama**: Bu özellik, kayıtlı serilere sahip oyuncuların yasaklanmasını engeller.

- **Güncelleme**: Antihile, güncelleme sistemi içerir.

- **Görünmez Silah [BETA]**: Bu özellik henüz %100 TEST EDİLMEDİ, ancak amacı bir oyuncunun görünmez bir silaha sahip olup olmadığını tespit etmektir.

- **Anti Düzeltme [BETA]**: Bu özellik henüz %100 TEST EDİLMEDİ, ancak amacı bir oyuncunun bir aracı onarmak için herhangi bir işlevi çalıştırıp çalıştırmadığını tespit etmek ve bunu iptal etmektir.

- **Anti Ateş Hızı**: Bu özellik henüz %100 TEST EDİLMEDİ, ancak amacı bir oyuncunun saniyeler içinde birden çok kez ateş ettiğini tespit etmektir ve sonra yasaklar.

- **Anti VPN**: Bu özellik bir oyuncunun VPN kullanıp kullanmadığını tespit eder ve ardından bir Atma işlemi gerçekleştirir.

- **Sahte Araçlar**: Bu özellik bir oyuncunun bir mod menüsü aracılığıyla bir araç çağırıp çağırmadığını tespit eder.

- **Beni Kendi Yanıma Taşı**: Bu özellik bir oyuncunun kendisinden uzak bir araç taşıdığını tespit eder.

- **Ekran Görüntüsü API**: Tüm ekran görüntüleri şimdi bir API aracılığıyla bir web sunucusunda saklanır, böylece Discord kaydı ile ortam dosyalarını gönderebilirsiniz.

- **Maksimum Hız Karşıtlığı**: Bu özellik bir oyuncunun anormal bir hızda hareket edip etmediğini tespit eder.

- **Ekran Paylaşımı**: Bu özellik bir oyuncuyu ekranını paylaşmaya zorlar. (Bunu yapan kişi olarak *zJoaoFtw_*'ye teşekkür ederiz).

- **Öğe Verileri**: Bu özellik oyuncu öğe verilerinde olmaması gereken değişiklikleri tespit eder.

- **Lua Yürütücüsü**: Bu özellik müşteri tarafında LUA kodu enjekte edilip edilmediğini tespit eder.

- **CMD Karşıtlığı/Blok**: Bu özellik siyah listeli bir komutu çalıştıran oyuncuyu cezalandırır.

## Hukuki Uyarı

Bu proje bağımsız olarak geliştirilmekte olup, Multi Theft Auto veya Grand Theft Auto serisi geliştiricileri ile resmi bir ilişkisi bulunmamaktadır. Bu hile engelleme sistemini kullanmak isteğe bağlıdır ve MTA sunucu yöneticilerinin seçimine dayanmaktadır.

## İletişim

Sorularınız, önerileriniz veya sorun raporlarınız varsa, bu depoda bir sorun (issue) oluşturabilir veya [ruirr31@gmail.com](mailto:ruirr31@gmail.com) adresinden iletişime geçebilirsiniz.

## Paylaşım

Bu kaynağı kullanmaya karar verirseniz, lütfen bu projenin oldukça yorucu ve zaman alıcı olduğunu göz önünde bulundurarak uygun kredi verin.
