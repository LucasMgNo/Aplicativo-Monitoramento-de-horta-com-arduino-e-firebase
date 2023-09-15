import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CardBomba extends StatefulWidget {
  CardBomba(
      {super.key,
      required this.caminho,
      this.bomba2 = false,
      required this.nomebomba});
  final String caminho;
  bool bomba2;
  String nomebomba;

  @override
  State<CardBomba> createState() => _CardBombaState();
}

class _CardBombaState extends State<CardBomba> {
  final database = FirebaseDatabase.instance.ref();
  //bool botaodesligado = false;
  bool botaoligado = false;

  @override
  Widget build(BuildContext context) {
    final estadobomba = database.child(widget.caminho);
    return Column(
      children: [
        Text(
          widget.nomebomba,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 100,
          width: 235,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 100,
                color: widget.bomba2 ? Colors.green : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/image/bomba.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.bomba2 = true;
                        //botaodesligado = true;
                        estadobomba.set(true);
                      });
                    },
                    child: Container(
                        width: 75,
                        height: 45,
                        decoration: BoxDecoration(
                            color: !widget.bomba2
                                ? Colors.blue.shade300
                                : Colors.blue.shade400,
                            border: Border.all(
                                color: !widget.bomba2
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 3)),
                        child: Center(
                            child: Text(
                          widget.bomba2 ? "Ligado" : "Ligar",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.bomba2 = false;
                        //botaodesligado = false;
                        estadobomba.set(false);
                      });
                    },
                    child: Container(
                        width: 75,
                        height: 45,
                        decoration: BoxDecoration(
                            color: widget.bomba2
                                ? Colors.red.shade300
                                : Colors.red.shade600,
                            border: Border.all(
                                color: !widget.bomba2
                                    ? Colors.transparent
                                    : Colors.white,
                                width: 3)),
                        child: Center(
                          child: Text(widget.bomba2 ? "Desligar" : "Desligado",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
