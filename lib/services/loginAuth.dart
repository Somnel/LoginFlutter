import 'package:firebase_auth/firebase_auth.dart';

class loginAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha
  }) async {
    try {
      UserCredential usuario = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
      await usuario.user!.updateDisplayName(nome);

      return null;
    } on FirebaseAuthException catch (e) {
      if(e.code == "email-already-in-use") {
        return "E-mail de usuário já cadastrado";
      }

      return "Erro desconhecido: ${e.code}";
    }
  }

  Future<String?> logarUsuario({
    required String email,
    required String senha
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> deslogarUsuario() async {
    return _firebaseAuth.signOut();
  }
}