import 'package:cloud_firestore/cloud_firestore.dart';

class UserDM {
  static const String collectionName = 'Users';
  static UserDM? currentUser;

  String id;
  String email;
  String? fullName;
  String? phoneNumber;
  String? age;
  String? day;
  String? month;
  String? year;
  String? weight;
  String? height;
  String? gender;
  Timestamp? birthDate; // إضافة الحقل

  UserDM({
    required this.id,
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.age,
    this.day,
    this.month,
    this.year,
    this.height,
    this.weight,
    this.gender,
    this.birthDate,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'age': age,
      'day': day,
      'month': month,
      'year': year,
      'height': height,
      'weight': weight,
      'gender': gender,
      'birthDate': birthDate,
    };
  }

  UserDM.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
    email: data['email'],
    fullName: data['fullName'],
    phoneNumber: data['phoneNumber'],
    age: data['age']?.toString(),
          day: data['day'],
          month: data['month'],
          year: data['year'],
          height: data['height']?.toString(),
    weight: data['weight']?.toString(),
          gender: data['gender'],
          birthDate: data['birthDate'], // افتراضاً الـ Timestamp مباشرة
        );
}
