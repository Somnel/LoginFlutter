import 'package:flutter/material.dart';
import 'package:login_flutter/components/Snackbar.dart';
import 'package:login_flutter/services/loginAuth.dart';

import '../components/loginInputDecoration.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool loginStatus = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final loginAuth _auth = loginAuth();

  final double _sizedboxHeight = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        decoration: const BoxDecoration(
          gradient: LinearGradient (
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.lightBlue
          ])
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Login', style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                  )),
                  SizedBox(height: (_sizedboxHeight*4)),
                  Visibility(
                    visible: !loginStatus,
                    child:
                      TextFormField(
                        controller: _nomeController,
                        decoration: getLoginInputDecoration("Nome"),
                        validator: (String? value) {
                          if(value == null) {
                            return "O nome não pode ser vazio";
                          }

                          return null;
                        },
                      ),
                  ),
                  SizedBox(height: _sizedboxHeight),
                  TextFormField(
                    controller: _emailController,
                    decoration: getLoginInputDecoration("E-mail"),
                    validator: (String? value) {
                      if(value == null) {
                        return "O e-mail não pode ser vazio";
                      }

                      if(value.length <= 4) {
                        return "O e-mail é muito curto";
                      }

                      if(!value.contains('@')) {
                        return "O e-mail não é válido";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: _sizedboxHeight),
                  TextFormField(
                    controller: _senhaController,
                    decoration: getLoginInputDecoration("Senha"),
                    obscureText: true,
                    validator: (String? value) {
                      if(value == null) {
                        return "Senha não pode ser vázia";
                      }

                      if(value.length < 4) {
                        return "Senha precisa de pelo 4 dígitos";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: (_sizedboxHeight*2)),
                  ElevatedButton(
                    onPressed: () => loginBtn(),
                    child: Text((loginStatus) ? "Entrar" : "Cadastrar",
                        style: const TextStyle(color: Colors.black)
                      ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        loginStatus = !loginStatus;
                      });
                    },
                    child: Text((loginStatus) ? "Ainda não tem uma conta?" : "Já tem uma conta?",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginBtn() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    if(_formKey.currentState!.validate()) {
      if(loginStatus) {
        _auth.logarUsuario(
            email: email,
            senha: senha
        ).then((String? err) {
          if(err != null) showSnackBar(context: context, texto: err);
        });
      } else {
        _auth.cadastrarUsuario(
            nome: nome,
            email: email,
            senha: senha
        ).then((String? err) {
          if(err != null) {
            showSnackBar(context: context, texto: err);
          } else {
            showSnackBar(context: context, texto: "Cadastro executado com sucesso", isErro: false);
          }
        });
      }
    } else {
      showSnackBar(context: context, texto: "Formulário Inválido");
    }
  }

}
