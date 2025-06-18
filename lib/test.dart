import 'package:flutter/material.dart';
import 'data/api_manager/api_manager.dart';
import 'data/model_api/insertResponse/InsertResponse.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isLoading = false;
  String? errorMessage;
  InsertResponse? responseData;

  Future<void> testSendDoctorData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      responseData = null;
    });

    try {
      final response = await ApiManger().sendDoctorData(
        drId: null,
        drEmail: "testdoctoddddr@gmail.com", // إيميل أقصر وصالح
        drName: "Test Doctor", // اسم بسيط
        drPassword: "123456",
        drPhone: "01123456789",
        drGender: "Male",
        drDegree: "PhD",
        specialty: "Cardiology",
        rating: 4.5,
        drAge: 40,
        drAddress: "Cairo",
        drPhoto: "base64EncodedStringHere",
        yearExperience: 10,
        price: 500.0,
        drDay:"",
        drTime: ""
      );

      setState(() {
        responseData = response;
        isLoading = false;
      });

      // عرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message??""),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      // طباعة البيانات في الـ Console
      print("✅ Success! Data received:");
      print(response.toJson());
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });

      // عرض رسالة خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ: $e"),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );

      print("❌ Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "اختبار إرسال بيانات الدكتور",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // زر الاختبار
              ElevatedButton(
                onPressed: isLoading ? null : testSendDoctorData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  minimumSize: const Size(200, 50),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "اختبار إرسال البيانات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // عرض البيانات أو الخطأ
              if (isLoading)
                const CircularProgressIndicator()
              else if (errorMessage != null)
                Text(
                  "خطأ: $errorMessage",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                )
              else if (responseData != null)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "نتيجة الإرسال:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[800],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("الرسالة: ${responseData!.message}"),
                          Text("الحالة: ${responseData!.status}"),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}