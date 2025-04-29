import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  num? bookingId;
  String? patientName;
  String? doctorName;
  String? doctorSpecialty;
  String? appointmentDate;
  String? appointmentTime;
  String? patientPhone;
  String? patientGender;
  String? patientAge;

  BookingModel({
    this.bookingId,
    this.patientName,
    this.doctorName,
    this.doctorSpecialty,
    this.appointmentDate,
    this.appointmentTime,
    this.patientPhone,
    this.patientGender,
    this.patientAge,
  });


  // دالة لتحويل البيانات من Firestore إلى BookingModel
  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      bookingId: data['bookingId'],
      patientName: data['patientName'],
      doctorName: data['doctorName'],
      doctorSpecialty: data['doctorSpecialty'],
      appointmentDate: data['appointmentDate'],
      appointmentTime: data['appointmentTime'],
      patientPhone: data['patientPhone'],
      patientGender: data['patientGender'],
      patientAge: data['patientAge'],
    );
  }

  // دالة لتحويل بيانات BookingModel إلى Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'bookingId': bookingId,
      'patientName': patientName,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'patientPhone': patientPhone,
      'patientGender': patientGender,
      'patientAge': patientAge,
    };
  }
}
