import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseloginbloc/blocs/simple_bloc_observer.dart';
import 'package:firebaseloginbloc/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  //test repository
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  // await Firebase.initializeApp();
  // final userRepository = UserRepository();
  // userRepository.createUserWithEmailAndPassword("phuongnamle.it@gmail.com", "howthehell's1");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login with Firebase',
      home: Scaffold(
        body: Center(
          child: Text('Login with Firebase', style: TextStyle(fontSize: 30),),
        ),
      ),
    );
  }
}
