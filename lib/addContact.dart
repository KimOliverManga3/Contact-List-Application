import 'package:contact_list/dbHelper.dart';
import 'package:contact_list/functions.dart';
import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {

  String name = '', phoneNumber = '', emailAddress = '';
  final formKey = GlobalKey<FormState>();

  String? validateEmail(value){
    emailAddress = value!;
    if(value!.isEmpty) {
      return "Required";
    } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
      return "Invalid Format.";
    } else {
      emailAddress = value;
      return null;
    }
  }

  String? validateName(value){
    if(value!.isEmpty) {
      return "Required";
    } else if(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return "Invalid Format, Please use Letters Only.";
    } else {
      name = value;
      return null;
    }
  }

  String? validatePhoneNumber(value){
    if(value!.isEmpty || value.length != 11) {
      return "Required";
    } else if(RegExp(r'[a-zA-Z!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(value!)) {
      return "Invalid Format.";
    } else {
      phoneNumber = value;
      return null;
    }
  }

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
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
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
                validator: validateName,
              ),

              TextFormField(
                style: TextStyle(color: Colors.white),
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
                validator: validatePhoneNumber,
                maxLength: 11,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
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
                validator: validateEmail,
                
                
                
              ),      
              const SizedBox(height: 40,),
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
                    
                    child: const Text('Save'),
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        final snackBar = SnackBar(content: Text("Contact Added"), backgroundColor: Colors.green,);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Functionalities func = Functionalities(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress);
                        DatabaseConnection().insertContact(func);
                      }
                    }, 
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

