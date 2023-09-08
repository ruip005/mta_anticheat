![uW33D Anticheat.](https://cdn.discordapp.com/attachments/1110700176361918545/1137505212903456808/AC.png "Anticheat")

# **MTA (Multi Theft Auto) için Hile Engelleme Sistemi**

MTA (Multi Theft Auto) için Hile Engelleme Sistemi projesine hoş geldiniz. Bu depo, MTA'nın çok oyunculu ortamındaki oyunun dürüstlüğünü ve adaletini artırmak için bir hile engelleme sistemi geliştirmek amacıyla kullanılır.

[Kurulum ve AntiVPN Videosu](https://youtu.be/XuNNihYl7KE)

[Tüm Hile Engelleme Sistemi Sürümleri](https://github.com/ruip005/mta_anticheat/releases)

## Dil Seçimi
Lütfen sadece Portekizce dilinin kararlı ve tamamlanmış olduğunu unutmayın; diğer diller hala tamamlanmadığı için ciddi hatalar içerebilir. Kararlı bir sürümü bekleyin veya yalnızca Portekizce dilini kullanın.

 * [Portekizce](https://github.com/ruip005/mta_anticheat/blob/main/readme/pt/README.md)   
 * [İspanyolca](https://github.com/ruip005/mta_anticheat/blob/main/readme/es/README.md)  
 * [İngilizce](https://github.com/ruip005/mta_anticheat/blob/main/readme/en/README.md)
 * [Türkçe](https://github.com/ruip005/mta_anticheat/blob/main/readme/tr/README.md)  
 * [Almanca](https://github.com/ruip005/mta_anticheat/blob/main/readme/de/README.md) 

## Kimlik Doğrulama

### Hile engelleme sistemini başlatmak için kimlik doğrulama.

| Değişken   | Tür       | Açıklama                           |
| :---------- | :--------- | :---------------------------------- |
| `user` | `string` | **Zorunlu**. Kullanıcı adı |
| `key` | `string` | **Zorunlu**. Kullanıcı etkinleştirme anahtarı |


### Bazı Ücretsiz Kimlik Doğrulamaları.

1.
**user**: `trial01`

**key**: `f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85`

2.
**user**: `trial02`

**key**: `a0b27debfdda2cb2e99f4faf47b8f6b7b758b0c1c36f53d42078d9df9212c252`

3.
**user**: `trial03`

**key**: `656f0a57cb751e8f55779b991ba4ea016e870b68f2d86271dfe0701bfe70f300`

*Lütfen anahtarınız özel ise kimseye vermeyin, sadece sunucunuzda kullanın! Sistemimiz, hile engelleme sistemini başlatırken sunucunun orijinal IP ve portunu algılar!*  

 
## Genel Bakış

Bu proje, Multi Theft Auto için etkili ve güçlü bir hile engelleme sistemi oluşturmayı amaçlamaktadır. Hile engelleme sistemi, oyuncuların oyun deneyimini olumsuz etkileyebilecek hileler, hileler ve diğer sahtekârlık faaliyetlerini tespit etmeyi ve önlemeyi amaçlamaktadır.

## Özellikler

- **Ekran Görüntüsü (Screenshot)**: Şüpheli oyuncunun ekranından bir fotoğraf çekmek ve bunu personelin ekranında göstermek ve hile engelleme modunun içindeki bir klasöre kaydetmek.

- **Discord Webhook**: Bu hile engelleme sistemi, Discord odalarına webhooklar aracılığıyla gönderilecek kayıtları içerir.

- **Ekran Görüntüsü Engelleme (AntiScreenShot)**: Bu özellik, oyuncunun sadece "Ekran Görüntüsü Göndermeye İzin Ver" seçeneği etkinse sunucuda oynamasına izin verir.

- **Binds**: Bu özellik, hileleri açmak için genellikle kullanılan tuşların basıldığını bildirir.

- **Anti "Backdoor"**: Bu özellik derlenmiş modlardaki gizli komutları bulmaya yardımcı olur.

- **Yol (Path)**: Bu özellik sunucudaki belirli bir modun konumunu bulmaya yardımcı olur.

- **Silah Kara Listesi (Armas blacklist)**: Bu özellik, sunucuda izin verilen silahlara sahip olmayan oyuncuları tespit eder ve sonra onları (personel hariç) yasaklar.

- **Araç Kara Listesi (Veiculos blacklist)**: Bu özellik, sunucuda izin verilen araçlara sahip olmayan oyuncuları tespit eder ve sonra onları (personel hariç) yasaklar.

- **Oyun Hızı (Game Speed)**: Bu özellik, oyuncunun oyun hızının normalden yüksek olup olmadığını tespit eder.

- **Anti Jetpack**: Bu özellik, oyuncunun personel olmadığını ve jetpack kullanıyorsa onu yasaklar.

- **Anti Uçma [BETA]**: Bu özellik henüz tamamlanmış değil, ancak amacı personel olmayan bir oyuncunun uçup uçmadığını tespit etmektir.

- **RPG Ateşi**: Silah Kara Listesi özelliği işe yaramazsa, RPG Ateşi işlevi devreye girer ve hileciyi yasaklar.

- **Tank Ateşi**: Bu özellik neredeyse yukarıdaki işlevle aynıdır, ancak hileci bir tanktan ateş ederse devreye girer.

- **VBR Oluştur (Spawn VBR)**

: Bu özellik VBR (Vanilla Battle Royale) kullanan oyuncular için tasarlanmıştır ve hileci bir oyuncunun sunucu tarafından desteklenmeyen bir araç aldığını tespit eder ve sonra onları yasaklar.

- **Anti Kaynak Durdurma (Anti Resource Stop)**: Bu özellik, oyuncuların sunucu tarafından önemli olan modları devre dışı bırakmalarını önler ve sonra onları yasaklar.

- **Anti Aimbot [BETA]**: Bu özellik henüz tamamlanmış değil, ancak amacı oyuncunun nişan almasının çok hızlı olduğunu tespit etmektir.

- **Personel Serileri (Staff serials)**: Bu özellik, sadece kayıtlı serilere sahip "personel" oyuncuların girmesine izin verir.

- **Personel Duvarı (Wallhack de Staff)**: Bu özellik sadece sunucu personeli için mevcuttur ve oyuncuların yakınındaki diğer oyuncuların nerede olduğunu görmelerine yardımcı olur.

- **Yasaklama ve Yasak Kaldırma Kayıtları (Logs de ban e unban)**: Bu özellik, Discord'a kimin bir oyuncuya yasak veya yasak kaldırma verdiği hakkında bilgi içeren bir günlük gönderir.

- **Global Yasaklama (Global ban)**: Bu özellik, son zamanlarda hile kullanan oyuncuların sunucuya girdiğinde sistem tarafından yasaklanmasını sağlar.

- **Anti Yasaklama (Anti ban)**: Bu özellik, kayıtlı serilere sahip oyuncuların yasaklanmasını engeller.

- **Güncelleme (Update)**: Hile engelleme sistemi güncellemeleri için bir sistem içerir.

- **Görünmez Silah [BETA]**: Bu özellik henüz tamamlanmış değil, ancak amacı oyuncunun görünmez bir silaha sahip olup olmadığını tespit etmektir.

- **Anti Tamir [BETA]**: Bu özellik henüz tamamlanmış değil, ancak amacı oyuncunun bir aracı tamir ettiğini tespit etmek ve bu işlemi iptal etmektir.

- **Anti Atış Hızı (Anti Fire-Rate)**: Bu özellik henüz tamamlanmış değil, ancak amacı oyuncunun saniyeler içinde çok sayıda atış yapmasını tespit etmektir ve sonra yasaklar.

- **Anti VPN**: Bu özellik oyuncunun bir VPN kullanıp kullanmadığını tespit eder ve sonra oyuncuyu sunucudan atar.

- **Sahte Araçlar (Fake Vehicles)**: Bu özellik oyuncunun bir mod menüsü aracılığıyla bir araç çekip çekmediğini tespit eder.

- **Beni Yanıma Taşı (Warp Veh to me)**: Bu özellik oyuncunun kendisinden uzak bir araç çekip çekmediğini tespit eder.

- **Ekran Görüntüsü API**: Tüm ekran görüntüleri artık bir web sunucusunda API aracılığıyla saklanır, böylece bir medya dosyasıyla birlikte bir Discord kaydı gönderilebilir.

- **Maksimum Hız Karşıtlığı (Anti Max Speed)**: Bu özellik, oyuncunun inanılmaz bir hızda hareket edip etmediğini tespit eder.

- **Ekran Paylaşımı (Screenshare)**: Bu özellik bir oyuncuyu ekranını paylaşmak için çeker. (Bu işlev *zJoaoFtw_*'ye aittir, çünkü o bunu yaptı.)

- **Öğe Verisi (Element Data)**: Bu özellik oyuncuların öğe verilerinde olmaması gereken değişiklikleri tespit eder.

- **Lua İşleme (Lua executor)**: Bu özellik istemci tarafında LUA kodu enjeksiyonunu tespit eder.

- **CMD Kara Liste/Engelleme (CMD Blacklist/Block)**: Bu özellik, yasaklanmış bir komutu çalıştıran oyuncuyu cezalandırır.
  
## Hukuki Uyarı

Bu proje bağımsız olarak geliştirilmekte olup, Multi Theft Auto veya Grand Theft Auto serisi geliştiricileri ile resmi bir ilişkisi yoktur. Bu hile engelleme sistemi kullanımı isteğe bağlıdır ve MTA sunucusu yöneticilerinin tercihine dayanır.

## İletişim

Sorularınız, önerileriniz veya sorun raporlarınız varsa, lütfen bu depoda bir sorun (issue) oluşturun veya Discord üzerinden uw33d (Kullanıcı Kimliği: 297122391580999692) ile iletişime geçmekten çekinmeyin.

## Paylaşım

Eğer bu kaynağı kullanıyorsanız, lütfen bu projenin yapımı oldukça zahmetli ve zaman alıcı olduğu için kredileri bırakın.
