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

}
