import 'package:flutter/material.dart';

class PatientModel {
  static const String collectionName = 'Patients details';
  String? patientId;
  String? patientName;
  String? patientPhone;
  String? ageRange;
  String? gender;
  num? height;
  num? weight;
  String? problemDescription;

  PatientModel({
    this.patientId,
    this.patientName,
    this.patientPhone,
    this.ageRange,
    this.gender,
    this.height,
    this.weight,
    this.problemDescription,
  });

  Map<String, dynamic> toFireStore() =>
      {
        'patientId': patientId,
        'patientName': patientName,
        'patientPhone': patientPhone,
        'ageRange': ageRange,
        'gender': gender,
        'height': height,
        'weight': weight,
        'problemDescription': problemDescription,


      };

  PatientModel.fromFireStore(Map<String, dynamic> data) : this(
    patientId: data['patientId'],
    patientName: data['patientName'],
    patientPhone: data['patientPhone'],
    ageRange: data['ageRange'],
    gender: data['gender'],
    height: data['height'],
    weight: data['weight'],
    problemDescription: data['problemDescription'],
  );
}
