import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => GirisEkrani(),
        '/ProfilSayfasiRotasi': (context) => ProfilEkrani(),
      },
    );
  }
}

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final TextEditingController t1 = TextEditingController();
  final TextEditingController t2 = TextEditingController();

  void girisYap() {
    if (t1.text == 'admin' && t2.text == '1234') {
      Navigator.pushNamed(
        context,
        '/ProfilSayfasiRotasi',
        arguments: VeriModeli(kullaniciAdi: t1.text, sifre: t2.text),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Yanlış kullanıcı adı veya şifre'),
            content: Text('Lütfen giriş bilgilerinizi gözden geçirin.'),
            actions: <Widget>[
              TextButton(
                child: Text('Kapat'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    t1.dispose();
    t2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Ekranı')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Kullanıcı Adı'),
                controller: t1,
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(hintText: 'Şifre'),
                controller: t2,
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: girisYap,
                child: Text('Giriş Yap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilEkrani extends StatefulWidget {
  final String kullaniciAdi;
  final String sifre;
  const ProfilEkrani({Key? key, this.kullaniciAdi = '', this.sifre = ''}) : super(key: key);

  @override
  _ProfilEkraniState createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  void cikisYap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final VeriModeli? iletilenArgumanlar =
        ModalRoute.of(context)?.settings.arguments as VeriModeli?;

    final displayedKullanici = iletilenArgumanlar?.kullaniciAdi ?? widget.kullaniciAdi;
    final displayedSifre = iletilenArgumanlar?.sifre ?? widget.sifre;

    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(onPressed: cikisYap, child: Text('Çıkış Yap')),
            SizedBox(height: 12),
            Text('Kullanıcı Adınız: $displayedKullanici'),
            Text('Şifreniz: $displayedSifre'),
          ],
        ),
      ),
    );
  }
}

class VeriModeli {
  final String kullaniciAdi;
  final String sifre;

  VeriModeli({required this.kullaniciAdi, required this.sifre});
}

/*
Bu kodda iki ana ekran bulunuyor:
'GirisEkrani' ve 'ProfilEkrani'.
Giriş ekranında kullanıcı adı ve şifre girilip doğrulanır.
Doğruysa `ProfilEkrani`'na `VeriModeli` argümanı ile yönlendirilir.
Profil ekranı gelen argümanı veya widget içindeki varsayılan değerleri gösterir.
*/
