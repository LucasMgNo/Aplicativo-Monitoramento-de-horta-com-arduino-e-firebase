// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Cards extends StatefulWidget {
  Cards({
    super.key,
    required this.caminhodb,
    required this.temp,
    required this.ambiente,
    required this.humisolo,
    required this.umidadeautomatica,
  });
  String caminhodb;
  String ambiente;
  int temp = 0;
  int humisolo = 0;
  String umidadeautomatica;

  @override
  State<Cards> createState() => _CardsState();
}

final database = FirebaseDatabase.instance.ref();

class _CardsState extends State<Cards> {
  bool automatico = false;
  bool valorhumid = false;
  bool umidadeautomatica = false;
  int umidademanual = 0;

  @override
  Widget build(BuildContext context) {
    final valorUmidade = database.child(widget.caminhodb);
    final boolumidadeautomatica = database.child(widget.umidadeautomatica);

    int umidade = automatico ? umidademanual : widget.humisolo;

    return SizedBox(
      height: 150,
      child: Stack(children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          elevation: 4,
          child: SizedBox(
            height: 110,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Container(
                  color: Colors.green.shade100,
                  width: double.infinity,
                  height: 25,
                  child: Text(
                    widget.ambiente,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Umidade\nSolo",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            ),
                            !valorhumid
                                ? Text(
                                    "${umidade}%",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Container(
                                    height: 30,
                                    width: 40,
                                    child: TextField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                          counterText: '',
                                          enabledBorder: InputBorder.none),
                                      maxLength: 2,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: false, signed: false),
                                      onSubmitted: (value) {
                                        try {
                                          valorUmidade.set(int.parse(value));
                                          umidademanual = int.parse(value);
                                          boolumidadeautomatica.set(true);
                                          valorhumid = false;
                                        } catch (e) {
                                          valorhumid = false;
                                        }
                                      },
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ))
                          ],
                        ),
                        Container(
                          color: Colors.green.shade200,
                          //margin: EdgeInsets.symmetric(vertical: 00),
                          width: 3,
                          height: 60,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Temperatura\nSolo",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              "${widget.temp}º",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: 75,
            right: 75,

            //width: 50,
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.orange,
                      value: automatico,
                      onChanged: (value) {
                        setState(() {
                          automatico = value!;
                          valorhumid = value;
                          if (!value) {
                            boolumidadeautomatica.set(false);
                          }
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        automatico
                            ? "Umidade Fixa\nEditar valor"
                            : "Ativar modo\nautomático",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ]),
            )),
      ]),
    );
  }
}
