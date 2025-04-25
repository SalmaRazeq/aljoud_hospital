import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorModel {
  num? doctorId;
  String? doctorName;
  String? specialty;
  String? date;
  String? time;
  String? price;
  String? image;
  String? meetingType;


  DoctorModel({
    this.doctorId,
    this.doctorName,
    this.specialty,
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
      'specialty': specialty,
      'date': date,
      'time': time,
      'price': price,
      'image': image,
      'meetingType': meetingType,
    };
  }

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return DoctorModel(
      doctorId: data['doctorId'],
      doctorName: data['doctorName'],
      specialty: data['specialty'],
      date: data['date'],
      time: data['time'],
      price: data['price'],
      image: data['image'],
      meetingType: data['meetingType'],
    );
  }

}
