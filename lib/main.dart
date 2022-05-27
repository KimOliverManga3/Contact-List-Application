import 'package:flutter/material.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  // var db = DatabaseConnection();
  // await db.insertContact(Functionalities(
  //   name: 'Gumana ka', 
  //   phoneNumber: '09675547331',
  //   emailAddress: 'putangIna@gmail.com'));
  //   print(await db.getContacts());
  runApp(MainPage());
}

class MainPage extends StatelessWidget {

  //FrontPage createState() => FrontPage();
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new FrontPage()
    );
  }
}

class FrontPage extends StatefulWidget {
  @override
  FrontPageState createState() => FrontPageState();
}

