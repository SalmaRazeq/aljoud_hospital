import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UpdateDoctorForm extends StatefulWidget {
  final int doctorId;

  const UpdateDoctorForm({super.key, required this.doctorId});

  // Static method to show the form as a dialog
  static Future<void> show(BuildContext context, int doctorId) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        child: Container(
          padding: EdgeInsets.all(16.w),
          constraints: BoxConstraints(maxHeight: 600.h, maxWidth: 400.w),
          child: Column(
            children: [
              Text(
                "تعديل بيانات الدكتور",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: UpdateDoctorForm(doctorId: doctorId),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "إلغاء",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<UpdateDoctorForm> createState() => _UpdateDoctorFormState();
}

class _UpdateDoctorFormState extends State<UpdateDoctorForm> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  late TextEditingController degreeController;
  late TextEditingController ratingController;
  late TextEditingController ageController;
  late TextEditingController addressController;
  late TextEditingController yearController;
  late TextEditingController priceController;
  late TextEditingController timeController;

  late String gender;
  late String? specialty;
  late String? day;
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

  @override
  void initState() {
    super.initState();
    // Initialize controllers with empty values
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    degreeController = TextEditingController();
    ratingController = TextEditingController();
    ageController = TextEditingController();
    addressController = TextEditingController();
    yearController = TextEditingController();
    priceController = TextEditingController();
    timeController = TextEditingController();
    gender = 'Male';
    specialty = null;
    day = null;
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  String? imageToBase64(File? image) {
    if (image == null) return null;
    final bytes = image.readAsBytesSync();
    return base64Encode(bytes);
  }

  Future<void> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        timeController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> updateDoctor() async {
    if (!_formKey.currentState!.validate() || specialty == null || day == null || timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى ملء جميع الحقول واختيار التخصص واليوم والوقت"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // TODO: Replace with actual API call when ready
      // Example: final response = await ApiManger().sendDoctorData(
      //   drId: widget.doctorId,
      //   drEmail: emailController.text.trim(),
      //   drName: nameController.text.trim(),
      //   drPassword: passwordController.text.isEmpty ? null : passwordController.text,
      //   drPhone: phoneController.text.trim(),
      //   drGender: gender,
      //   drDegree: degreeController.text.trim(),
      //   specialty: specialty!,
      //   rating: double.parse(ratingController.text),
      //   drAge: int.parse(ageController.text),
      //   drAddress: addressController.text.trim(),
      //   drPhoto: imageToBase64(selectedImage),
      //   yearExperience: int.parse(yearController.text),
      //   price: double.parse(priceController.text),
      //   drDay: day!,
      //   drTime: timeController.text,
      // );

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "تم تعديل بيانات الدكتور بنجاح",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      Navigator.pop(context); // Close the dialog on success
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
    }
  }

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
      padding: EdgeInsets.symmetric(vertical: 8.h),
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
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
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
    return Form(
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
              label: 'كلمة المرور (اختياري)',
              prefixIcon: Icons.lock,
              obscureText: true,
              validator: (value) {
                if (value != null && value.isNotEmpty && value.length < 6) {
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
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
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
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
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
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.teal.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.teal, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
              validator: (value) => value == null ? 'يرجى اختيار التخصص' : null,
            ),
            SizedBox(height: 10.h),
            selectedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(selectedImage!, height: 100.h, fit: BoxFit.cover),
            )
                : Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Center(child: Text("لم يتم اختيار صورة")),
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.image, color: Colors.white),
              label: const Text("اختر صورة", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: isLoading ? null : updateDoctor,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                minimumSize: Size(double.infinity, 50.h),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                "تعديل",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}