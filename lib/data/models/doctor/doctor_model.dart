import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  static const String collectionName = "Doctors";

  String? doctorId;
  String? doctorName;
  String? doctorEmail;
  String? phoneNumber;
  String? specialty;
  String? medicalLicense;
  String? userType; // حقل جديد لتحديد نوع المستخدم
  String? date;
  String? time;
  String? price;
  String? image;
  String? meetingType;

  DoctorModel({
    this.doctorId,
    this.doctorName,
    this.doctorEmail,
    this.phoneNumber,
    this.specialty,
    this.medicalLicense,
    this.userType = "doctor", // القيمة الافتراضية
    this.date,
    this.time,
    this.price,
    this.image,
    this.meetingType,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorEmail': doctorEmail,
      'phoneNumber': phoneNumber,
      'specialty': specialty,
      'medicalLicense': medicalLicense,
      'userType': userType,
      'date': date,
      'time': time,
      'price': price,
      'image': image,
      'meetingType': meetingType,
    };
  }

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception("Doctor document does not exist");
    }

    final data = doc.data() as Map<String, dynamic>;
    return DoctorModel(
      doctorId: data['doctorId'] as String?,
      doctorName: data['doctorName'] as String?,
      doctorEmail: data['doctorEmail'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      specialty: data['specialty'] as String?,
      medicalLicense: data['medicalLicense'] as String?,
      userType: data['userType'] as String? ?? "doctor",
      date: data['date'] as String?,
      time: data['time'] as String?,
      price: data['price'] as String?,
      image: data['image'] as String?,
      meetingType: data['meetingType'] as String?,
    );
  }

  DoctorModel.fromJson(dynamic json) {
    if (json['results'] != null) {
      json['results'].forEach((v) {
        });
    }
  }
}
