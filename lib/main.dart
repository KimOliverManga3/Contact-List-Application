import 'package:flutter/material.dart';
import 'functions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(mainPage());
}

class mainPage extends StatelessWidget {

  // mainPage() : super();

  // @override
  // frontPage createState() => frontPage();
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: frontPage()
  );
}

class frontPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) => 
    Scaffold(
    backgroundColor: Color(0xff101820),
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xfff2aa4d),
      title: Text('Contacts'),
      foregroundColor: Color(0xff000000),
      actions: [
        IconButton(onPressed: () {}, 
        icon: Icon(Icons.search)),
        ],
    ),
    body: Center(),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xfff2aa4d),
      foregroundColor: Color(0xff000000),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddContact()),
        );
      }
      ),
  );
}
