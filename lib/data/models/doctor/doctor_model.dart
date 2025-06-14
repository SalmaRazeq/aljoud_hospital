import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  static const String collectionName = "Doctors";

  String? doctorId;
  String? doctorName;
  String? doctorEmail;
  String? phoneNumber;
  String? specialty;
  String? medicalLicense;
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
    };
  }

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    if (!doc.exists || doc.data() == null) {
      throw Exception("Doctor document does not exist");
    }

    final data = doc.data() as Map<String, dynamic>;
    return DoctorModel(
      doctorId: data['doctorId'],
      doctorName: data['doctorName'],
      doctorEmail: data['doctorEmail'],
      phoneNumber: data['phoneNumber'],
      specialty: data['specialty'],
      medicalLicense: data['medicalLicense'],
    );
  }

  DoctorModel.fromJson(dynamic json) {
    //page = json['page'];
    // totalPages = json['total_pages'];
    // totalResults = json['total_results'];
    if (json['results'] != null) {
      // results = [];
      json['results'].forEach((v) {
        // results?.add(Results.fromJson(v));
      });
    }
  }
}
