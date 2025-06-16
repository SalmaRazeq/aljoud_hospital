import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  static const String collectionName = 'Bookings';
  final String? documentId;
  num? bookingId;
  String? doctorName;
  String? doctorSpecialty;
  String? appointmentDate;
  String? appointmentTime;
  String? meetingType;
  String? price;
  String? image;
  String? status;

  BookingModel({
    this.documentId,
    this.bookingId,
    this.doctorName,
    this.doctorSpecialty,
    this.appointmentDate,
    this.appointmentTime,
    this.meetingType,
    this.price,
    this.image,
    this.status,
  });

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      documentId: doc.id,
      bookingId: data['bookingId'],
      doctorName: data['doctorName'],
      doctorSpecialty: data['doctorSpecialty'],
      appointmentDate: data['appointmentDate'],
      appointmentTime: data['appointmentTime'],
      meetingType: data['meetingType'],
      price: data['price'],
      image: data['image'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'bookingId': bookingId,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'meetingType': meetingType,
      'price': price,
      'image': image,
      'status': status,
    };
  }
}
