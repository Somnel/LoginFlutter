import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_flutter/services/loginAuth.dart';

import '../components/MostrarModalInicio.dart';
import '../services/exemploCloud.dart';
import '../models/ExemploModel.dart';
import 'Exemplo.dart';

class InicioWidget extends StatefulWidget {
  final User usuario;
  const InicioWidget({super.key, required this.usuario});

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {

  final ExemploCloud servico = ExemploCloud();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Exercícios"),
      ),
      drawer: Drawer(
        child:
        ListView(
          children:
          [
            UserAccountsDrawerHeader(
                accountName: Text(widget.usuario.displayName ?? ""),
                accountEmail: Text(widget.usuario.email!)
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Deslogar"),
              onTap: () {
                loginAuth().deslogarUsuario();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
          const Icon(Icons.add),
          onPressed: () {
            mostrarModalInicio(context);
          },
      ),
      body:
        const Center()
        /*StreamBuilder(
        stream: servico.conectarStreamExemplo(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()
            );
          } else {
            if(snapshot.hasData && snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
              List<ExemploModel> listExemplo = [];

              for (var doc in snapshot.data!.docs) {
                listExemplo.add(ExemploModel.fromMap(doc.data()));
              }

              return ListView(
                  children: List.generate(
                      listExemplo.length,
                          (index) {
                        ExemploModel exemplo = listExemplo[index];
                        return ListTile(
                            title: Text(exemplo.nome),
                            subtitle: Text(exemplo.descricao ?? "---"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Exemplo(exemplo: exemplo)
                                  )
                              );
                            }
                        );
                      }
                  )
              );
            }
          } else {
            return const Center(child: Text("Ainda nenhum exemplo"));
          }
        }
      ),*/
    );
  }
}
