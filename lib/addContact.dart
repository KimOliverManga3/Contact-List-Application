import 'package:contact_list/dbHelper.dart';
import 'package:contact_list/functions.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class AddContact extends StatefulWidget{

  String editName = '', editPhoneNumber = '', editEmail = '';

  AddContact({required this.editName, required this.editPhoneNumber, required this.editEmail});
  
  @override
  AddContactState createState() => AddContactState(editName, editPhoneNumber, editEmail);

}

class AddContactState extends State<AddContact> {

  String name = '', phoneNumber = '', emailAddress = '', buttonText = 'Save';
  String editName = '', editPhoneNumber = '', editEmail = '';

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailAddressController = TextEditingController();

  

  AddContactState(this.editName, this.editPhoneNumber, this.editEmail){
    if(editName.isNotEmpty && editPhoneNumber.isNotEmpty && editEmail.isNotEmpty){
      nameController.text = editName;
      phoneNumberController.text = editPhoneNumber;
      emailAddressController.text = editEmail;
      buttonText = 'Update';
    }
  }

  String? validateEmail(value){
    if(value.isNotEmpty && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
      return "Invalid Format.";
    } else {
      emailAddress = value;
      return null;
    }
  }

  String? validateName(value){
    if(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return "Invalid Format, Please use Letters Only.";
    } else {
      name = value;
      return null;
    }
  }

  String? validatePhoneNumber(value){
    if(value.isNotEmpty && value.length != 11) {
      return "Required";
    } else if(RegExp(r'[a-zA-Z!@#<>?":_`~;[\]\\|=+)(*&^%\s-]').hasMatch(value!)) {
      //RegExp(r'[a-zA-Z!@#<>?":_`~;[\]\\|=+)(*&^%\s-]')
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
        autovalidateMode: AutovalidateMode.always,
        //key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: nameController,
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
                controller: phoneNumberController,
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
                controller: emailAddressController,
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
                validator: validateEmail              
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
                    
                    child: Text(buttonText),
                    onPressed: () async {
                      var db = await DatabaseConnection().database;
                      var temp = await db.rawQuery("SELECT * FROM contacts WHERE phoneNumber = '$phoneNumber'");
                      if(temp.length > 0 && editPhoneNumber.isEmpty){
                        const snackBar = SnackBar(content: Text("Phone Number Already Exists"), 
                        backgroundColor: Colors.red,);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      else if (name.isNotEmpty && phoneNumber.isNotEmpty && emailAddress.isNotEmpty && temp.length <= 0 && buttonText == 'Save'){
                          name = nameController.text;
                          phoneNumber = phoneNumberController.text;
                          emailAddress = emailAddressController.text;
                          
                          final snackBar = SnackBar(content: Text("Contact Added"), backgroundColor: Colors.green,);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Functionalities func = Functionalities(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress);
                          DatabaseConnection().insertContact(func);
                          nameController.clear();
                          phoneNumberController.clear();
                          emailAddressController.clear();

                      }
                      else if (buttonText == 'Update' && editName.isNotEmpty && editPhoneNumber.isNotEmpty && editEmail.isNotEmpty
                              && name.isNotEmpty && emailAddress.isNotEmpty && phoneNumber.isNotEmpty){   

                          if(temp.length <= 0){
                            Functionalities func = Functionalities(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress);
                            DatabaseConnection().updateContact(func, editPhoneNumber);
                          
                            final snackBar = SnackBar(content: Text("Contact Updated Successfully"), backgroundColor: Colors.green,);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            nameController.clear();
                            phoneNumberController.clear();
                            emailAddressController.clear();
                          }
                          else if(temp.length > 0){
                            String tempNum = json.encode(temp);
                            String confirmPhone = tempNum.substring(tempNum.indexOf(':')+2, tempNum.indexOf(':')+13);
                            String confirmName = tempNum.substring(tempNum.indexOf('name')+7, tempNum.indexOf('emailAddress')-3);
                            String confirmEmail = tempNum.substring(tempNum.lastIndexOf(':')+2, tempNum.lastIndexOf('}')-1);
                            if(phoneNumber == confirmPhone && editName != confirmName && editEmail != confirmEmail){
                              final snackBar = SnackBar(content: Text("Phone Number Already Exists"), backgroundColor: Colors.red,);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            else{
                              Functionalities func = Functionalities(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress);
                              DatabaseConnection().updateContact(func, editPhoneNumber);
                            
                              final snackBar = SnackBar(content: Text("Contact Updated Successfully"), backgroundColor: Colors.green,);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              nameController.clear();
                              phoneNumberController.clear();
                              emailAddressController.clear();
                            }
                            
                          }
                                
                          
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


