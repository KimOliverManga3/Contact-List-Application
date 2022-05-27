import 'package:contact_list/dbHelper.dart';
import 'package:flutter/material.dart';
import 'addContact.dart';
import 'functions.dart';
import 'main.dart';

class FrontPageState extends State<FrontPage> {

  var items = <String>[];
  //Functionalities test = new Functionalities(phoneNumber: '', name: '', emailAddress: '');

  //final List<String> _searchable = (DatabaseConnection().getContacts().toString());

  @override
  void initState(){
    super.initState();
    //items = test.getCont();
    DatabaseConnection().getContacts2();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xff101820),
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xfff2aa4d),
      title: Text('Contacts'),
      foregroundColor: Color(0xff000000),
      actions: [
        IconButton(onPressed: () {

        }, 
        icon: Icon(Icons.search)),
        ],
    ),
    body: Container(
      padding: EdgeInsets.all(25),
      child: SafeArea(child: FutureBuilder(
      future: DatabaseConnection().getContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Functionalities>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
              return content(snapshot.data![index]);
            });
          }
          else{
            return const Center(
              child: Text("No Contact Found.", 
              style: TextStyle(color: Colors.white),),
            );
          }
        }
      )
    ),
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xfff2aa4d),
      foregroundColor: Color(0xff000000),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddContact()),
        );
      }
      ),
  );
}

  Widget content(Functionalities contacts){
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(10)
      ),
    child: Container(
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(3.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            child: Text('${contacts.name[0]}'),
            backgroundColor: Color(0xff000000),
            foregroundColor: Colors.white,
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Text(
            contacts.name,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    ),
    );
  }
