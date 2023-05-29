import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jardim_app/models/data.dart';
import 'package:jardim_app/widgets/bomba2.dart';
import 'package:jardim_app/widgets/cards.dart';
import 'package:jardim_app/widgets/temperature.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({
    super.key,
  });

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final ref = FirebaseDatabase.instance.ref();
  late StreamSubscription _ouvinte;
  int tempAr = 0,
      humdAr = 0,
      tempsolo1 = 0,
      tempsolo2 = 0,
      humsolo1 = 0,
      humsolo2 = 0;
  bool bomba1 = false, bomba2 = false;

  @override
  void initState() {
    super.initState();
    _ativarListners();
  }

  Future<void> _ativarListners() async {
    _ouvinte = ref.child('/').onValue.listen((event) {
      //precisou criar uma referencia pra usar o deactivate
      final data = Map<dynamic, dynamic>.from(
          (event.snapshot.value) as Map<dynamic, dynamic>);

      final dados = DadosFirebase.fromRTDB(data);

      setState(() {
        tempAr = dados.tempAr;
        humdAr = dados.humdAr;
        tempsolo1 = dados.tempsolo1;
        tempsolo2 = dados.tempsolo2;
        humsolo1 = dados.humsolo1;
        humsolo2 = dados.humsolo2;
        bomba1 = dados.bomba1;
        bomba2 = dados.bomba2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            color: Colors.green.shade50,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(height: 20),
                Temperature(
                  tempAr: tempAr,
                  humidAe: humdAr,
                ),
                const SizedBox(
                  height: 50,
                ),
                Cards(
                  ambiente: "Coentro",
                  temp: tempsolo1,
                  humisolo: humsolo1,
                ),
                const SizedBox(
                  height: 50,
                ),
                Cards(ambiente: "Alface", temp: tempsolo2, humisolo: humsolo2),
                const SizedBox(
                  height: 20,
                ),
                CardBomba(bomba2: bomba1, caminho: "/bomba"),
                CardBomba(
                  bomba2: bomba2,
                  caminho: "/bomba2/",
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void deactivate() {
    //por ter iniciado um lestener, precisa ser desativado ao sair dessa parte da arvore
    _ouvinte.cancel();
    super.deactivate();
  }
}
