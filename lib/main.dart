import 'package:bill_application/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCLYwFO6n-SlZzCLwuKbmQ6DNMIglW4gKo',
          appId: '1:299112713785:android:5d5a25e2d33a8018d747e8',
          messagingSenderId: '299112713785',
          projectId: 'bat-chita'
      )
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Homescreen(),
    );
  }
}
