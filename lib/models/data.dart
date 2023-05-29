// ignore_for_file: public_member_api_docs, sort_constructors_first
class DadosFirebase {
  final int tempAr;
  final int humdAr;
  final int tempsolo1;
  final int tempsolo2;
  final int humsolo1;
  final int humsolo2;
  final bool bomba1;
  final bool bomba2;
  DadosFirebase({
    required this.humsolo1,
    required this.humsolo2,
    required this.tempAr,
    required this.humdAr,
    required this.tempsolo1,
    required this.tempsolo2,
    required this.bomba1,
    required this.bomba2,
  });

  factory DadosFirebase.fromRTDB(Map<dynamic, dynamic> dados) {
    return DadosFirebase(
      tempAr: dados['ar']['temperatura'] ?? 0,
      humdAr: dados['ar']['humidade'] ?? 0,
      tempsolo1: dados['solo1']['temperatura'] ?? 0,
      tempsolo2: dados['solo2']['temperatura'] ?? 0,
      humsolo1: dados['solo1']['humisolo1'] ?? 0,
      humsolo2: dados['solo2']['humisolo2'] ?? 0,
      bomba1: dados['bomba'] ?? false,
      bomba2: dados['bomba2'] ?? false,
    );
  }
}
