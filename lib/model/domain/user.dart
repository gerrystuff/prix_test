class User {
  String firstName;
  String secondName;
  String firstLastName;
  String secondLastName;
  String phoneNumber;
  String email;
  String birthday;
  String yearsOld;
  String sex;

  User({
    required this.firstLastName,
    required this.secondName,
    required this.birthday,
    required this.email,
    required this.yearsOld,
    required this.sex,
    required this.secondLastName,
    required this.firstName,
    required this.phoneNumber
  });
 Map<String, dynamic> toJson() => {
  "firstName": firstName,
  "secondName":secondName,
  "firstLastName":firstLastName,
  "secondLastName":secondLastName,
  "phoneNumber":phoneNumber,
  "email":email,
  "birthday":birthday,
  "yearsOld":yearsOld,
  "sex":sex,
    };



    factory User.fromJson(Map<String, dynamic> json) => User(
     firstName: json['firstName'],
secondName: json['secondName'],
firstLastName: json['firstLastName'],
secondLastName: json['secondLastName'],
phoneNumber: json['phoneNumber'],
email: json['email'],
birthday: json['birthday'],
yearsOld: json['yearsOld'],
sex: json['sex']
    );
  

}