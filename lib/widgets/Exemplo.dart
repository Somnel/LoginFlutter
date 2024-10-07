import 'package:flutter/material.dart';
import 'package:login_flutter/models/ExemploModel.dart';

class ExemploWidget extends StatelessWidget {
  final ExemploModel exemplo;
  const ExemploWidget({super.key, required this.exemplo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exemplo.nome),
      ),
      body: Center(
        child: Text(exemplo.descricao ?? '---')
      ),
    );
  }
}
