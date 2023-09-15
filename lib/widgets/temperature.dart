// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  Temperature({super.key, required this.tempAr, required this.humidAe});
  int tempAr;
  int humidAe;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      elevation: 4,
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Media(
            texto: "Umidade média\nAr %",
            temp: humidAe,
          ),
          Container(
            color: Colors.green.shade200,
            margin: EdgeInsets.symmetric(vertical: 20),
            width: 2,
          ),
          Media(
            texto: "Temperatura média\nAr °C",
            temp: tempAr,
          ),
        ]),
      ),
    );
  }
}

class Media extends StatelessWidget {
  const Media({
    super.key,
    required this.texto,
    required this.temp,
  });
  final String texto;
  final int temp;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          texto,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
        Text(
          "$temp",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
