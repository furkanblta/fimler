import 'package:fimler/DetaySayfa.dart';
import 'package:fimler/Filmler.dart';
import 'package:fimler/Kategoriler.dart';
import 'package:fimler/Yonetmenler.dart';
import 'package:flutter/material.dart';

class FilmlerSayfa extends StatefulWidget {
  Kategoriler kategori;

  FilmlerSayfa({required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {
  Future<List<Filmler>> tumFilmleriGoster(int kategori_id) async {
    var filmlerListesi = <Filmler>[];
    var k1 = Kategoriler(1, "Komedi");
    var y1 = Yonetmenler(1, "Quentin Tarantino");

    var f1 = Filmler(1, "Anadoluda", 2008, "anadoluda.png", k1, y1);
    var f2 = Filmler(1, "Django", 2009, "django.png", k1, y1);
    var f3 = Filmler(1, "Inception", 2010, "inception.png", k1, y1);

    filmlerListesi.add(f1);
    filmlerListesi.add(f2);
    filmlerListesi.add(f3);

    return filmlerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmler : ${widget.kategori.kategori_ad} "),
      ),
      body: FutureBuilder<List<Filmler>>(
        future: tumFilmleriGoster(widget.kategori.kategori_id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var filmlerListesi = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3.5),
              itemCount: filmlerListesi!.length,
              itemBuilder: (context, indeks) {
                var film = filmlerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetaySayfa(
                                  film: film,
                                )));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("resimler/${film.film_resim}"),
                        ),
                        Text(
                          film.film_ad,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
