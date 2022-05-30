import 'dbHelper.dart';

class Functionalities{
  
  late String name, phoneNumber, emailAddress;

  Functionalities({required this.name, required this.phoneNumber, required this.emailAddress});

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
      'emailAddress': emailAddress,
    };
  }

  Functionalities.fromMap(Map<String, dynamic> map){
    phoneNumber = map["phoneNumber"];
    name = map["name"];
    emailAddress = map["emailAddress"];
  }

  List<String> getCont(){
    DatabaseConnection().getContacts();
    List<String> container = [name, phoneNumber, emailAddress];
    return container;
  }

}
