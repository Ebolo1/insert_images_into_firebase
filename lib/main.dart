import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insert_images_into_firebase/views/home/home.dart';

void main() async {
  //initialisationde tout les widgets
  WidgetsFlutterBinding.ensureInitialized();
  //initialisation de firebase
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insert Into Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white)
      ),
      home: const Home(),
    );
  }
}
