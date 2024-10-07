import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/ExemploModel.dart';

class ExemploCloud {
  String usuarioID;

  ExemploCloud() : usuarioID = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarExemplo(ExemploModel exemploModel) async {
    await _firestore.collection(usuarioID)
        .doc(exemploModel.id)
        .set(exemploModel.toMap());
  }

  /*Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamExemplo() {
    _firestore.collection(usuarioID).snapshots();
  }*/
}

