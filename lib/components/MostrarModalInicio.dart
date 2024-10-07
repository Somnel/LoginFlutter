import 'package:flutter/material.dart';
import '../models/ExemploModel.dart';
import '../services/exemploCloud.dart';
import '../components/loginInputDecoration.dart';
import 'package:uuid/uuid.dart';


mostrarModalInicio(BuildContext context, {ExemploModel? exemplo}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.blue,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return ExemploModal(exemplo: exemplo);
    },
  );
}

class ExemploModal extends StatefulWidget {
  final ExemploModel? exemplo;
  const ExemploModal({super.key, this.exemplo});

  @override
  State<ExemploModal> createState() => _ExemploModalState();
}

class _ExemploModalState extends State<ExemploModal> {
  final TextEditingController _nomeCtrl = TextEditingController();
  final TextEditingController _descricaoCtrl = TextEditingController();

  bool isCarregando = false;

  final ExemploCloud _exemploCloud = ExemploCloud();

  @override
  void initState() {
    if(widget.exemplo != null) {
      _nomeCtrl.text = widget.exemplo!.nome;
      _descricaoCtrl.text = widget.exemplo!.descricao!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const Text("Adicionar Exemplo"),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                )
              ]
            ),
            Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nomeCtrl,
                  decoration: getLoginInputDecoration(
                    "Qual o nome do Exemplo?",
                    icon: const Icon(Icons.abc)
                  )
                ),
                TextFormField(
                    controller: _descricaoCtrl,
                    decoration: getLoginInputDecoration(
                        "Qual a descrição do Exemplo?",
                        icon: const Icon(Icons.abc)
                    ),
                    maxLines: null,
                ),
              ]
            ),
            ElevatedButton(
              onPressed: () {
                enviarClicado();
              },
              child: (isCarregando)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text("Criar Exemplo"),
            )
          ]
        ),
      ),
    );
  }

  enviarClicado() {
    setState(() {
      isCarregando = true;
    });

    String nome = _nomeCtrl.text;
    String descricao = _descricaoCtrl.text;

    ExemploModel exemplo = ExemploModel(
        id: const Uuid().v1(),
        nome: nome,
        descricao: descricao
    );

    _exemploCloud.adicionarExemplo(exemplo).then((value) {
      setState(() {
        isCarregando = false;
      });
    });
  }
}
