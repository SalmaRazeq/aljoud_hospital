import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model_api/insertResponse/InsertResponse.dart';
import '../model_api/selectedDoctor/DoctorResponse.dart';
import '../model_api/ubdateResponse/ubdateResponse.dart';

class ApiManger {
  Future<InsertResponse> sendDoctorData({
    required String drEmail,
    required String drName,
    required String drPassword,
    required String drPhone,
    required String drGender,
    required String drDegree,
    required String specialty,
    required double rating,
    required int drAge,
    required String drAddress,
    required String drPhoto,
    String? drId,
    required int yearExperience,
    required double price,
    required String drDay, // حقل اليوم
    required String drTime, // حقل الوقت
  }) async {
    final url = Uri.parse("http://192.168.1.7/c43/handleInsertDoctor.php");
    // تحضير البيانات
    final body = {
      'Dr_Email': drEmail.trim(),
      'Dr_Name': drName.trim(),
      'Dr_Password': drPassword,
      'Dr_Phone': drPhone.trim(),
      'Dr_Gender': drGender,
      'Dr_Degree': drDegree.trim(),
      'Specialty': specialty,
      'Rating': rating.toStringAsFixed(2),
      'Dr_Age': drAge.toString(),
      'Dr_Address': drAddress.trim(),
      'Dr_Photo': drPhoto.isEmpty ? '' : drPhoto,
      'Dr_ID': drId,
      'Year_Experience': yearExperience.toString(),
      'price': price.toStringAsFixed(2),
      'Day': drDay.trim(), // حقل اليوم
      'Date': drTime.trim(), // حقل الوقت
    };

    // طباعة كل حقل لوحده
    print("📤 Preparing to send data to API:");
    body.forEach((key, value) {
      print("  $key: $value");
    });

    try {
      // محاولة إرسال كـ form-data
      final request = http.MultipartRequest('POST', url);
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      print("📤 Sending as form-data: ${request.fields}");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // طباعة تفاصيل الاستجابة
      print("📥 Response status: ${response.statusCode}");
      print("📥 Response headers: ${response.headers}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final insertResponse = InsertResponse.fromJson(json);
        print("✅ Parsed InsertResponse: ${insertResponse.toJson()}");
        return insertResponse;
      } else {
        throw Exception(
            'Failed to send data. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print("❌ Error in sendDoctorData: $e");
      throw Exception('Error sending data to API: $e');
    }
  }

  static Future<DoctorResponse?> fetchDoctorsBySpecialty(
      String specialty)
  async {try {
      const String apiUrl =
          'http://192.168.1.7/c43/Select-doctor-Specialty.php';
      final response = await http.get(
        Uri.parse('$apiUrl?Specialty=$specialty'),
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0',
        },
      );

      print('API Response Status Code: ${response.statusCode}');
      print('API Response Headers: ${response.headers}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final jsonData = jsonDecode(response.body);
          print('Raw JSON Keys: ${jsonData.keys.toList()}');
          print('Parsed JSON Data: $jsonData');
          return DoctorResponse.fromJson(jsonData);
        } catch (e) {
          print('JSON Parsing Error: $e');
          return null;
        }
      } else {
        print('Failed to load doctors: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching doctors: $e');
      return null;
    }
  }

  static Future<UpdateResponse> updateDoctor({
    required String drName,
    required String drPhone,
    required String drGender,
    required String drDegree,
    required String specialty,
    required double rating,
    required int drAge,
    required String drAddress,
    required String drPhoto,
    required String drId,
    required int yearExperience,
    required double price,
    required String drDay,
    required String drTime,
  })
  async {
    final url =
        Uri.parse("http://192.168.1.7/c43/handleupdatedoctor.php?DR_ID=$drId");
    final body = {
      'Dr_Name': drName.trim(),
      'Dr_Phone': drPhone.trim(),
      'Dr_Gender': drGender,
      'Dr_Degree': drDegree.trim(),
      'Specialty': specialty,
      'Rating': rating.toStringAsFixed(2),
      'Dr_Age': drAge.toString(),
      'Dr_Address': drAddress.trim(),
      'Dr_Photo': drPhoto.isEmpty ? '' : drPhoto,
      'Year_Experience': yearExperience.toString(),
      'price': price.toStringAsFixed(2),
      'Day': drDay.trim(),
      'Date': drTime.trim(),
    };

    print("📤 Preparing to send data to API:");
    body.forEach((key, value) {
      print("  $key: $value");
    });

    try {
      final request = http.MultipartRequest('POST', url);
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      print("📤 Sending as form-data: ${request.fields}");

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response headers: ${response.headers}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final updateResponse = UpdateResponse.fromJson(json);
        print("✅ Parsed UpdateResponse: ${updateResponse.toJson()}");
        return updateResponse;
      } else {
        throw Exception(
            'Failed to send data. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print("❌ Error in updateDoctor: $e");
      throw Exception('Error sending data to API: $e');
    }
  }




  static Future<UpdateResponse> deleteDoctor({
    required String drId,
  }) async {
    final url = Uri.parse("http://192.168.1.7/c43/DOCTOR-DELETE.php?Dr_ID=$drId");

    print("📤 Preparing to send DELETE request to API:");
    print("  URL: $url");
    print("  Dr_ID: $drId");

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response headers: ${response.headers}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final json = jsonDecode(response.body);
          if (json is Map<String, dynamic>) {
            final updateResponse = UpdateResponse.fromJson(json);
            print("✅ Parsed UpdateResponse: ${updateResponse.toJson()}");
            return updateResponse;
          } else {
            print("❌ Response body is not a valid JSON object: ${response.body}");
            throw Exception('Invalid JSON response: ${response.body}');
          }
        } catch (e) {
          print("❌ JSON parsing error: $e");
          throw Exception('Failed to parse JSON response: $e');
        }
      } else {
        print("❌ Failed request with status: ${response.statusCode}");
        throw Exception('Failed to delete doctor. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print("❌ Error in deleteDoctor: $e");
      throw Exception('Error sending DELETE request to API: $e');
    }
  }


}

