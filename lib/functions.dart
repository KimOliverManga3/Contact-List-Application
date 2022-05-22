import 'package:flutter/material.dart';


class AddContact extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xff101820),
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(0xfff2aa4d),
      foregroundColor: Color(0xff000000),
      title: Text('Create a New Contact'),
    
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.people, color: Color(0xffffffff),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 3),
                  borderRadius: BorderRadius.circular(30.0), 
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.blueGrey, width: 3),
                  borderRadius: BorderRadius.circular(30.0)
                )
              ),
            ),

            TextField(
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.phone_android, color: Color(0xffffffff),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 3),
                  borderRadius: BorderRadius.circular(30.0), 
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.blueGrey, width: 3),
                  borderRadius: BorderRadius.circular(30.0)
                )
              ),
            ),

            TextField(
              decoration: InputDecoration(
                labelText: "Email Address",
                labelStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.email_outlined, color: Color(0xffffffff),),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 3),
                  borderRadius: BorderRadius.circular(30.0), 
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.blueGrey, width: 3),
                  borderRadius: BorderRadius.circular(30.0)
                )
              ),
            ),      
            
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    textStyle: TextStyle(fontSize: 16),
                    primary: Color(0xfff2aa4d),
                    onPrimary: Colors.black,
                  ),
                  
                  child: Text('Add'),
                  onPressed: () {}, 
                  ),
              ],
            )
          ],
          
        ),
      ),
    ),
  );
}

