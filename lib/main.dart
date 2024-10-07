import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart' if (dart.library.html) 'firebase_options_mock.dart';
import 'package:login_flutter/widgets/Inicio.dart';
import 'package:login_flutter/widgets/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const bool isCI = bool.fromEnvironment('ISCI', defaultValue: false);

  FirebaseOptions options = DefaultFirebaseOptions.currentPlatform;


  await Firebase.initializeApp(
    options: options,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return const RoteadorTela();
              } else if(snapshot.hasError) {
                return Center(
                    child: Text('Erro ao inicializar o Firebase: ${snapshot.error}')
                );
              }

              return const Center(child: CircularProgressIndicator());
            }
        )
    );
  }
}

class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return InicioWidget(usuario: snapshot.data!);
          } else {
            return const LoginWidget();
          }
        }
    );
  }
}



