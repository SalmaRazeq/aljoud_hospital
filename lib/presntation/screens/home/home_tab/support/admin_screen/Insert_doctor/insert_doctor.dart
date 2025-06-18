import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../data/api_manager/api_manager.dart';
import '../../../../../../../data/model_api/insertResponse/InsertResponse.dart';

class InsertDoctorScreen extends StatefulWidget {
  const InsertDoctorScreen({super.key});

  @override
  State<InsertDoctorScreen> createState() => _InsertDoctorScreenState();
}

class _InsertDoctorScreenState extends State<InsertDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController timeController = TextEditingController(); // حقل الوقت

  String gender = 'Male';
  String? specialty;
  String? day; // حقل اليوم
  File? selectedImage;

  final List<String> specialties = [
    'Cardiology', 'Pulmonology', 'Dentistry', 'Orthopedics',
    'Pediatrics', 'Oncology', 'Ophthalmology', 'Dermatology',
    'OB-GYN', 'Surgery', 'Physical therapy', 'Psychiatry',
    'Neurology', 'Internal medicine', 'ENT',
  ];

  final List<String> days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  // دالة لتحويل الصورة إلى Base64
  String? imageToBase64(File? image) {
    if (image == null) return null;
    final bytes = image.readAsBytesSync();
    return base64Encode(bytes);
  }

  // دالة لاختيار الوقت
  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> registerDoctor() async {
    if (!_formKey.currentState!.validate() || specialty == null || selectedImage == null || day == null || timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى ملء جميع الحقول واختيار صورة واليوم والوقت"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // جمع البيانات للطباعة
    String formData = '''
تفاصيل التسجيل:
الاسم: ${nameController.text}
البريد الإلكتروني: ${emailController.text}
كلمة المرور: ${passwordController.text}
رقم الهاتف: ${phoneController.text}
الجنس: $gender
الدرجة العلمية: ${degreeController.text}
التخصص: $specialty
التقييم: ${ratingController.text}
العمر: ${ageController.text}
العنوان: ${addressController.text}
سنوات الخبرة: ${yearController.text}
السعر: ${priceController.text}
اليوم: $day
الوقت: ${timeController.text}
مسار الصورة: ${selectedImage!.path}
''';

    print(formData);

    try {
      final response = await ApiManger().sendDoctorData(
        drId: null,
        drEmail: emailController.text.trim(),
        drName: nameController.text.trim(),
        drPassword: passwordController.text,
        drPhone: phoneController.text.trim(),
        drGender: gender,
        drDegree: degreeController.text.trim(),
        specialty: specialty!,
        rating: double.parse(ratingController.text),
        drAge: int.parse(ageController.text),
        drAddress: addressController.text.trim(),
        drPhoto: imageToBase64(selectedImage) ?? '',
        yearExperience: int.parse(yearController.text),
        price: double.parse(priceController.text),
        drDay: day!, // تمرير اليوم
        drTime: timeController.text, // تمرير الوقت
      );

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.message ?? "تم التسجيل بنجاح",
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      // إذا نجح التسجيل، نقدر ننظف النموذج
      _formKey.currentState!.reset();
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneController.clear();
      degreeController.clear();
      ratingController.clear();
      ageController.clear();
      addressController.clear();
      yearController.clear();
      priceController.clear();
      timeController.clear();
      setState(() {
        specialty = null;
        selectedImage = null;
        day = null;
      });

      print("✅ Success! Data received:");
      print(response.toJson());
    } catch (e) {
      setState(() {
        isLoading = false;
      });

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

  // دالة لإنشاء TextFormField موحد
  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool obscureText = false,
    IconData? prefixIcon,
    String? Function(String?)? validator,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.teal) : null,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'يرجى إدخال $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تسجيل الدكتور",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildTextFormField(
                      controller: nameController,
                      label: 'الاسم',
                      prefixIcon: Icons.person,
                    ),
                    buildTextFormField(
                      controller: emailController,
                      label: 'البريد الإلكتروني',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'يرجى إدخال بريد إلكتروني صحيح';
                        }
                        return null;
                      },
                    ),
                    buildTextFormField(
                      controller: passwordController,
                      label: 'كلمة المرور',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    buildTextFormField(
                      controller: phoneController,
                      label: 'رقم الهاتف',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    DropdownButtonFormField<String>(
                      value: gender,
                      items: ['Male', 'Female']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => gender = val!),
                      decoration: InputDecoration(
                        labelText: 'الجنس',
                        prefixIcon: const Icon(Icons.people, color: Colors.teal),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.teal, width: 2),
                        ),
                      ),
                    ),
                    buildTextFormField(
                      controller: degreeController,
                      label: 'الدرجة العلمية',
                      prefixIcon: Icons.school,
                    ),
                    buildTextFormField(
                      controller: ratingController,
                      label: 'التقييم (مثال: 4.5)',
                      prefixIcon: Icons.star,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال التقييم';
                        }
                        if (double.tryParse(value) == null || double.parse(value) < 0 || double.parse(value) > 5) {
                          return 'التقييم يجب أن يكون بين 0 و 5';
                        }
                        return null;
                      },
                    ),
                    buildTextFormField(
                      controller: ageController,
                      label: 'العمر',
                      prefixIcon: Icons.cake,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال العمر';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'يرجى إدخال عمر صحيح';
                        }
                        return null;
                      },
                    ),
                    buildTextFormField(
                      controller: addressController,
                      label: 'العنوان',
                      prefixIcon: Icons.location_on,
                    ),
                    buildTextFormField(
                      controller: yearController,
                      label: 'سنوات الخبرة',
                      prefixIcon: Icons.work,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال سنوات الخبرة';
                        }
                        if (int.tryParse(value) == null || int.parse(value) < 0) {
                          return 'يرجى إدخال عدد صحيح';
                        }
                        return null;
                      },
                    ),
                    buildTextFormField(
                      controller: priceController,
                      label: 'السعر',
                      prefixIcon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال السعر';
                        }
                        if (double.tryParse(value) == null || double.parse(value) <= 0) {
                          return 'يرجى إدخال سعر صحيح';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: day,
                      items: days
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => day = val),
                      decoration: InputDecoration(
                        labelText: 'اليوم',
                        prefixIcon: const Icon(Icons.today, color: Colors.teal),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.teal, width: 2),
                        ),
                      ),
                      validator: (value) => value == null ? 'يرجى اختيار اليوم' : null,
                    ),
                    buildTextFormField(
                      controller: timeController,
                      label: 'الوقت (HH:MM)',
                      prefixIcon: Icons.access_time,
                      readOnly: true,
                      onTap: pickTime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى اختيار الوقت';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: specialty,
                      items: specialties
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => specialty = val),
                      decoration: InputDecoration(
                        labelText: 'التخصص',
                        prefixIcon: const Icon(Icons.medical_services, color: Colors.teal),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.teal, width: 2),
                        ),
                      ),
                      validator: (value) => value == null ? 'يرجى اختيار التخصص' : null,
                    ),
                    const SizedBox(height: 10),
                    selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(selectedImage!, height: 100, fit: BoxFit.cover),
                    )
                        : Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text("لم يتم اختيار صورة")),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: pickImage,
                      icon: const Icon(Icons.image, color: Colors.white),
                      label: const Text("اختر صورة", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading ? null : registerDoctor,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "تسجيل",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}