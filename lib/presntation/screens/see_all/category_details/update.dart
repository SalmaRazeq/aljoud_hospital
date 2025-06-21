import 'dart:convert';
import 'dart:io';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../data/api_manager/api_manager.dart';
import '../../../../l10n/app_localizations.dart' show AppLocalizations;
import '../../auth/widget/doctor_item/doctor_textField.dart'; // تأكد إن المسار صحيح

class UpdateDoctorForm extends StatefulWidget {
  final int doctorId;

  const UpdateDoctorForm({super.key, required this.doctorId});

  // Static method to show the form as a dialog
  static Future<void> show(BuildContext context, int doctorId) async {
    final loc = AppLocalizations.of(context)!;

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
                loc.updateDoctor,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.blue2,
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: UpdateDoctorForm(doctorId: doctorId),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      loc.cancel,
                      style: const TextStyle(color: Colors.red),
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

  late List<String> specialties ;

  late List<String> days;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with empty values
    nameController = TextEditingController();
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsManager.blue2,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // لون أزرار الغاء/موافق
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

  String getDayKey(String translatedDay) {
    final loc = AppLocalizations.of(context)!;

    final Map<String, String> dayMap = {
      loc.monday: 'Monday',
      loc.tuesday: 'Tuesday',
      loc.wednesday: 'Wednesday',
      loc.thursday: 'Thursday',
      loc.friday: 'Friday',
      loc.saturday: 'Saturday',
      loc.sunday: 'Sunday',
    };

    return dayMap[translatedDay] ?? 'Unknown';
  }


  String getGenderKey(String localized) {
    final loc = AppLocalizations.of(context)!;
    if (localized == loc.male) return 'Male';
    if (localized == loc.female) return 'Female';
    return 'unKnown';
  }
  String getSpecialtyKey(String translatedSpecialty) {
    final loc = AppLocalizations.of(context)!;

    final Map<String, String> specialtyMap = {
      loc.cardiology: 'Cardiology',
      loc.pulmonology: 'Pulmonology',
      loc.dentistry: 'Dentistry',
      loc.orthopedics: 'Orthopedics',
      loc.pediatrics: 'Pediatrics',
      loc.oncology: 'Oncology',
      loc.ophthalmology: 'Ophthalmology',
      loc.dermatology: 'Dermatology',
      loc.oBGYN: 'OB-GYN',
      loc.surgery: 'Surgery',
      loc.physicalTherapy: 'Physical therapy',
      loc.psychiatry: 'Psychiatry',
      loc.neurology: 'Neurology',
      loc.internalMedicine: 'Internal medicine',
      loc.eNT: 'ENT',
    };

    return specialtyMap[translatedSpecialty] ?? 'Unknown';
  }



  Future<void> updateDoctor() async {
    final loc = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate() || specialty == null || day == null || timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(loc.fillAllFields),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    // Additional validation for age and years of experience
    final age = int.tryParse(ageController.text);
    final yearsExperience = int.tryParse(yearController.text);
    if (age == null || age < 18 || age > 120) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(loc.ageRangeError),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
    if (yearsExperience == null || yearsExperience < 0 || yearsExperience > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(loc.experienceRangeError),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiManger.updateDoctor(
        drId: widget.doctorId.toString(),
        drName: nameController.text.trim(),
        drPhone: phoneController.text.trim(),
        drGender: getGenderKey(gender),
        drDegree: degreeController.text.trim(),
        specialty: getSpecialtyKey(specialty!),
        rating: double.parse(ratingController.text),
        drAge: age,
        drAddress: addressController.text.trim(),
        drPhoto: imageToBase64(selectedImage) ?? '',
        yearExperience: yearsExperience,
        price: double.parse(priceController.text),
        drDay: getDayKey(day!),
        drTime: timeController.text,
      );

      print("📝 UpdateResponse: message=${response.message}, status=${response.status}");

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.status == "success" ? (response.message ?? AppLocalizations.of(context)!.updateSuccess) : "${ AppLocalizations.of(context)!.updateFailed} ${response.message ?? 'خطأ غير معروف'}",
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: response.status == "success" ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),

        ),
      );

      if (response.status == "success") {
        Navigator.pop(context); // Close the dialog on success
      }
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final genders = [loc.male, loc.female];
    String gender = loc.male; // قيمة متغيرة مخزنة في الحالة

    final specialties = [
      loc.cardiology,
      loc.pulmonology,
      loc.dentistry,
      loc.orthopedics,
      loc.pediatrics,
      loc.oncology,
      loc.ophthalmology,
      loc.dermatology,
      loc.oBGYN,
      loc.surgery,
      loc.physicalTherapy,
      loc.psychiatry,
      loc.neurology,
      loc.internalMedicine,
      loc.eNT,
    ];

    final days = [
      loc.monday,
      loc.tuesday,
      loc.wednesday,
      loc.thursday,
      loc.friday,
      loc.saturday,
      loc.sunday,
    ];
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DoctorTextField(
              icon: Icons.person,
              hintText: loc.name,
              controller: nameController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return loc.plzFullName;
                }
                return null;
              },),
            SizedBox(height: 10.h,),
            DoctorTextField(
              hintText: loc.phone,
              keyBoardType: TextInputType.phone,
              controller: phoneController,
              icon: Icons.phone_outlined,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return loc.plzPhone;
                }
                if (input.length != 11) {
                  return loc.password11digits;
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),

            DropdownButtonFormField<String>(
              style: GoogleFonts.roboto(
                fontSize: 12.sp,
                color: gender == null ? Theme.of(context).colorScheme.shadow : ColorsManager.blue2,
              ),
              value: gender,
              borderRadius: BorderRadius.circular(10.r),
              items: genders.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => gender = val!),
              decoration: InputDecoration(
                contentPadding: REdgeInsets.symmetric(vertical: 9, horizontal: 9),
                prefixIcon: Icon(Icons.people, color: ColorsManager.hint, size: 22.sp,),
                filled: true,
                fillColor: ColorsManager.textField,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.hint)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.hint)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.darkGray)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Colors.red,)
                ),
              ),
            ),
            SizedBox(height: 10.h,),

            DoctorTextField(
                hintText: loc.degree,
                controller: degreeController,
                icon: Icons.school_outlined,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return loc.plzEnterDegree;
                  }
                  return null;
                }),
            SizedBox(height: 10.h,),
            DropdownButtonFormField<String>(
              style: GoogleFonts.roboto(
                fontSize: 12.sp,
                color: specialty == null ? Theme.of(context).colorScheme.shadow : ColorsManager.blue2,
              ),
              value: specialty,
              borderRadius: BorderRadius.circular(10.r),
              items: specialties
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => specialty = val),
              decoration: InputDecoration(
                contentPadding: REdgeInsets.symmetric(vertical: 9, horizontal: 9),

                hintText: loc.specialization,
                prefixIcon: Icon(Icons.today, color: ColorsManager.hint, size: 22.sp),
                filled: true,
                fillColor: ColorsManager.textField,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.hint)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.hint)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.darkGray)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Colors.red,)
                ),
              ),
              validator: (value) => value == null ? loc.plzEnterSpecialization : null,
            ),

            SizedBox(height: 10.h,),

            DoctorTextField(
              hintText: loc.rating,
              controller: ratingController,
              icon: Icons.star,
              keyBoardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.plzEnterRating;
                }
                if (double.tryParse(value) == null || double.parse(value) < 0 || double.parse(value) > 10) {
                  return loc.ratingRangeError;
                }
                return null;
              },),
            SizedBox(height: 10.h,),

            DoctorTextField(
              hintText: loc.age,
              controller: ageController,
              icon: Icons.cake_outlined,
              keyBoardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.plzEnterAge;
                }
                if (int.tryParse(value) == null || int.parse(value) <= 0) {
                  return loc.plzEnterValidInteger;
                }
                return null;
              },),
            SizedBox(height: 10.h,),

            DoctorTextField(
                hintText: loc.address,
                controller: addressController,
                icon: Icons.location_on,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return loc.plzEnterAddress;
                  }
                  return null;
                }),
            SizedBox(height: 10.h,),

            DoctorTextField(
                hintText: loc.yearsOfExperience,
                controller: yearController,
                icon: Icons.work,
                keyBoardType: TextInputType.number,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return loc.plzEnterYearsOfExperience;
                  }
                  if (int.tryParse(input) == null || int.parse(input) < 0) {
                    return loc.plzEnterValidInteger;
                  }
                  return null;
                }),
            SizedBox(height: 10.h,),

            DoctorTextField(
                hintText: loc.price,
                controller: priceController,
                icon: Icons.attach_money,
                keyBoardType: TextInputType.number,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return loc.plzEnterPrice;
                  }
                  if (int.tryParse(input) == null || int.parse(input) < 0) {
                    return loc.plzEnterValidInteger;
                  }
                  return null;
                }),
            SizedBox(height: 10.h,),

            DropdownButtonFormField<String>(
              style: GoogleFonts.roboto(
                fontSize: 12.sp,
                color: day == null ? Theme.of(context).colorScheme.shadow : ColorsManager.blue2,
              ),
              value: day,
              borderRadius: BorderRadius.circular(10.r),
              items: days
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => day = val),
              decoration: InputDecoration(
                contentPadding: REdgeInsets.symmetric(vertical: 9, horizontal: 9),
                hintText: loc.workingDay,
                prefixIcon: Icon(Icons.today, color: ColorsManager.hint, size: 22.sp),
                filled: true,
                fillColor: ColorsManager.textField,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.hint)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.hint)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: ColorsManager.darkGray)
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Colors.red,)
                ),
              ),
              validator: (value) => value == null ? loc.plzChooseDay : null,
            ),
            SizedBox(height: 10.h,),

            DoctorTextField(
              hintText: loc.workingTime,
              controller: timeController,
              icon: Icons.access_time,
              onTap: pickTime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.plzChooseTime;
                }
                return null;
              },),
            SizedBox(height: 10.h,),


            SizedBox(height: 10.h),
            selectedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.file(selectedImage!, height: 100.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Text(loc.errorImage),
              ),

            )
                : Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: ColorsManager.textField,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(child: Text(loc.noPhotoSelected,
                style: GoogleFonts.inter(fontSize: 14.sp, color: Theme.of(context).colorScheme.shadow),
              )),
            ),
            SizedBox(height: 10.h),
            ElevatedButton.icon(
              onPressed: pickImage,
              icon:  Icon(Icons.image, color: Colors.white, size: 22.sp,),
              label: Text(loc.selectPhoto, style: GoogleFonts.inter(fontSize: 13.sp,color: ColorsManager.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.blue2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: isLoading ? null : updateDoctor,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.blue2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                padding: REdgeInsets.symmetric(horizontal: 10, vertical: 10),
                minimumSize: Size(double.infinity, 28.sp),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  :  Text(
                loc.update,
                style: GoogleFonts.inter(fontSize: 16.sp,color: ColorsManager.white, fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ),
    );
  }
}