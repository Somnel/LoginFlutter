class ExemploModel {
  String id;
  String nome;
  String? descricao;


  ExemploModel({
    required this.id,
    required this.nome,
    required this.descricao
  });


  ExemploModel.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      nome = map["nome"],
      descricao = map["descricao"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
    };
  }
}