import 'package:firebase_auth/firebase_auth.dart';

class UserDM {
  static const String collectionName = 'Users';
  static UserDM? currentUser;
  String id;
  String email;
  String? fullName;
  String? phoneNumber;


  UserDM({required this.id,
    required this.email,
    this.fullName,
    this.phoneNumber
  });

  Map<String, dynamic> toFireStore() =>
      {
        'id': id,
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber
      };

  UserDM.fromFireStore(Map<String, dynamic> data) : this(
      id: data['id'],
      email: data['email'],
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber']
  );
}