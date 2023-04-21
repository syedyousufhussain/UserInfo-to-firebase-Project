import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey:"AIzaSyBk-hEzP3WJIf7VXlEdMterOI-RJyzcHEI",appId: "1:956816697076:android:dfb77930091977fca8a0a1",messagingSenderId: "956816697076",projectId: "j-checkup" ),
  );
  runApp(const AusmLab());
}

class AusmLab extends StatelessWidget {
  
  const AusmLab({super.key});

  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      title: 'My_Task',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

