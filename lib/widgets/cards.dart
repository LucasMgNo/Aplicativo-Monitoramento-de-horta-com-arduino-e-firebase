// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  Cards({
    super.key,
    required this.temp,
    required this.ambiente,
    required this.humisolo,
  });
  String ambiente;
  int temp = 0;
  int humisolo = 0;

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
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
                              "Humidade\nSolo",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              "${widget.humisolo}%",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
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
            left: 120,
            right: 120,

            //width: 50,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: Center(
                  child: Text(
                "Detalhes",
                style: TextStyle(color: Colors.white),
              )),
            )),
      ]),
    );
  }
}
