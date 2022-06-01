import 'package:contact_list/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'addContact.dart';
import 'functions.dart';
import 'main.dart';

class FrontPageState extends State<FrontPage> {

  @override
  void initState(){
    super.initState();  
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
    ),
    body: Column(
      children: [

          //  FocusedMenuHolder(
          //   menuItems: [
          //     FocusedMenuItem(
          //       title: Text("Delete", style: TextStyle(color: Colors.white),),
          //       trailingIcon: Icon(Icons.delete, color: Colors.white,),
          //       backgroundColor: Colors.red,
          //       onPressed: (){},
          //       )
          //   ],
          //   blurSize: 40.40,
          //   openWithTap: false,
          //   onPressed: (){},

          Flexible(
            child: Container(
            padding: EdgeInsets.all(25),
            child: SafeArea(child: FutureBuilder(
            future: DatabaseConnection().getContacts(),
            builder: (BuildContext context, AsyncSnapshot<List<Functionalities>> snapshot){
                if(snapshot.data!.isNotEmpty){                
                  return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return content(snapshot.data![index], context);        
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
      ),
    ],
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color(0xfff2aa4d),
      foregroundColor: Color(0xff000000),
      onPressed: () async {
        await Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddContact()),
        );
        setState(() {});
      }
      ),
  );
}

  Widget content(Functionalities contacts, BuildContext context){
    return FocusedMenuHolder(
      menuItems: [
        FocusedMenuItem(
          title: Text("Delete", style: TextStyle(color: Colors.white),),
          trailingIcon: Icon(Icons.delete, color: Colors.white,),
          backgroundColor: Colors.red,
          onPressed: (){
            DatabaseConnection().deleteContact(contacts.phoneNumber);

          },
        )
      ],
      blurSize: 40.40,
      openWithTap: false,
      onPressed: (){},
      child: Card(
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
              Flexible(
                child: ListTile(
                  leading: Icon(Icons.account_circle, size: 30, color: Colors.black,),
                  title: Text(
                    contacts.name,
                    style:TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  subtitle: Text(contacts.phoneNumber + '\n' + contacts.emailAddress),
                  trailing: IconButton(
                    onPressed: () async{
                    await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddContact(
                        
                        )),
                    );
                    setState() {}
                  }, 
                  icon: Icon(Icons.edit, size: 20,),
                  color: Colors.black,),
                ),
              ), 
            ],
          ),
        ),
    )
  );
    
  }

  