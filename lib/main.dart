// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, annotate_overrides, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(GezegenOyunu());
}

class GezegenOyunu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gezegen Oyunu'),
        ),
        body: Gezegenler(),
      ),
    );
  }
}

class Gezegenler extends StatefulWidget {
  @override
  _GezegenlerState createState() => _GezegenlerState();
}

class _GezegenlerState extends State<Gezegenler> {
  Random random = Random();
  List<int> gezegen1Uydular = [];
  List<int> gezegen2Uydular = [];
  List<int> gezegen3Uydular = [];

  int gezegen1Sonuc = 0;
  int gezegen2Sonuc = 0;
  int gezegen3Sonuc = 0;

  TextEditingController gezegen3GirilenSonuc = TextEditingController();
  bool dogruSonuc = false;

  void initState() {
    super.initState();
    rastgeleUydulariAta();
    hesaplamaYap();
  }

  void rastgeleUydulariAta() {
    gezegen1Uydular = List.generate(4, (_) => random.nextInt(10) + 1);
    gezegen2Uydular = List.generate(4, (_) => random.nextInt(10) + 1);
    gezegen3Uydular = List.generate(4, (_) => random.nextInt(10) + 1);
  }

  void hesaplamaYap() {
    gezegen1Sonuc = gezegen1Uydular[0] +
        gezegen1Uydular[1] -
        gezegen1Uydular[2] * gezegen1Uydular[3];
    gezegen2Sonuc = gezegen2Uydular[0] -
        gezegen2Uydular[1] * gezegen2Uydular[2] +
        gezegen2Uydular[3];
    gezegen3Sonuc = gezegen3Uydular[0] * gezegen3Uydular[1] +
        gezegen3Uydular[2] -
        gezegen3Uydular[3];
  }

  void kontrolEt() {
    int kullaniciSonuc = int.tryParse(gezegen3GirilenSonuc.text) ?? 0;
    setState(() {
      dogruSonuc = (kullaniciSonuc == gezegen3Sonuc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Gezegen(
            uyduSayilari: gezegen1Uydular,
            sonuc: gezegen1Sonuc,
          ),
          Gezegen(
            uyduSayilari: gezegen2Uydular,
            sonuc: gezegen2Sonuc,
          ),
          Gezegen(
            uyduSayilari: gezegen3Uydular,
            sonuc: gezegen3Sonuc,
          ),
          Container(
            width: 200,
            child: TextField(
              controller: gezegen3GirilenSonuc,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '3. Gezegen Sonucu',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                rastgeleUydulariAta();
                hesaplamaYap();
                dogruSonuc = false;
              });
            },
            child: Text('Yeni Uydular Ata'),
          ),
          ElevatedButton(
            onPressed: kontrolEt,
            child: Text('Sonucu Kontrol Et'),
          ),
          if (dogruSonuc) Text('Tebrikler, doğru sonucu buldunuz!'),
        ],
      ),
    );
  }
}

class Gezegen extends StatelessWidget {
  final List<int> uyduSayilari;
  final int sonuc;

  Gezegen({
    required this.uyduSayilari,
    required this.sonuc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int sayi in uyduSayilari) UyduSayisi(sayi: sayi),
        SizedBox(width: 10),
        Text('='),
        SizedBox(width: 10),
        UyduSayisi(sayi: sonuc),
      ],
    );
  }
}

class UyduSayisi extends StatelessWidget {
  final int sayi;

  UyduSayisi({required this.sayi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          sayi.toString(),
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
