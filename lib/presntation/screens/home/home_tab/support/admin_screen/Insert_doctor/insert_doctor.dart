import 'dart:convert';
import 'dart:io';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/presntation/screens/auth/widget/doctor_item/doctor_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../core/utils/email_validation.dart';
import '../../../../../../../data/api_manager/api_manager.dart';
import '../../../../../../../data/model_api/insertResponse/InsertResponse.dart';
import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../auth/widget/doctor_item/doctor_passwordField.dart';

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
  String? day;
  File? selectedImage;

  late List<String> specialties ;

  late List<String> days;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    degreeController = TextEditingController();
    ratingController = TextEditingController();
    ageController = TextEditingController();
    addressController = TextEditingController();
    yearController = TextEditingController();
    priceController = TextEditingController();
    timeController = TextEditingController();
    gender = AppLocalizations.of(context)!.male;
    specialty = null;
    day = null;

    final loc = AppLocalizations.of(context)!;
    specialties = [
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

    days = [
      loc.monday,
      loc.tuesday,
      loc.wednesday,
      loc.thursday,
      loc.friday,
      loc.saturday,
      loc.sunday,
    ];
  }


  // دالة لتحويل الصورة إلى Base64
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


  Future<void> registerDoctor() async {
    if (!_formKey.currentState!.validate() || specialty == null || selectedImage == null || day == null || timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(AppLocalizations.of(context)!.fillAllFields),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
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
        drGender: getGenderKey(gender),
        drDegree: degreeController.text.trim(),
        specialty: getSpecialtyKey(specialty!),
        rating: double.parse(ratingController.text),
        drAge: int.parse(ageController.text),
        drAddress: addressController.text.trim(),
        drPhoto: imageToBase64(selectedImage) ?? '',
        yearExperience: int.parse(yearController.text),
        price: double.parse(priceController.text),
        drDay: getDayKey(day!),
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


  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final genders = [loc.male, loc.female];

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
    return Scaffold(
      appBar: AppBar(
      title: Text(
      loc.insertDoctor,
      style: GoogleFonts.inter(
        color: ColorsManager.blue2,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: true,
    ),
      body: Stack(
        children: [
          Padding(
            padding: REdgeInsets.all(10),
            child: Form(
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
                    SizedBox(height: 8.h),

                    DoctorTextField(
                      icon: Icons.email_outlined,
                      hintText: loc.emailAddress,
                      keyBoardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (input) {
                        if (input == null || input.trim().isEmpty) {
                          return loc.plzEmail;
                        }
                        if (!isEmailValid(input)) {
                          return loc.wrongFormat;
                        }
                        return null;
                      },),
                    SizedBox(height: 8.h),

                    DoctorPasswordField(
                        hintText: loc.password,
                        controller: passwordController,
                        icon: Icons.lock_outline_rounded,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return loc.plzPassword;
                          }
                          if (input.length < 6) {
                            return loc.password6Char;
                          }
                          return null;
                        }),

                    SizedBox(height: 8.h),

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
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        color: gender == null ? Theme.of(context).colorScheme.shadow : ColorsManager.blue2,
                      ),
                      value: gender,
                      borderRadius: BorderRadius.circular(10.r),
                      items: genders
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
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
                    SizedBox(height: 8.h),

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
                    SizedBox(height: 8.h),

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
                    SizedBox(height: 8.h),

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

                    SizedBox(height: 8.h),

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
                    SizedBox(height: 8.h),

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
                    SizedBox(height: 8.h),

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
                    SizedBox(height: 8.h),

                    DoctorTextField(
                        hintText: loc.plzEnterPrice,
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

                    SizedBox(height: 8.h),

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
                    SizedBox(height: 8.h),

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

                    SizedBox(height: 10.h),

                    selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.file(
                        selectedImage!,
                        height: 100.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Text(loc.errorImage),
                      ),
                    )
                        : Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.textField,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          loc.noPhotoSelected,
                          style: GoogleFonts.inter(fontSize: 14.sp, color: Theme.of(context).colorScheme.shadow),
                        ),
                      ),
                    ),
                     SizedBox(height: 10.h),
                    ElevatedButton.icon(
                      onPressed: pickImage,
                      icon:  Icon(Icons.image, color: Colors.white, size: 22.sp,),
                      label: Text(loc.selectPhoto, style: GoogleFonts.inter(fontSize: 14.sp,color: ColorsManager.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.blue2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                     SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: isLoading ? null : registerDoctor,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.blue2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        minimumSize: Size(double.infinity, 30.sp),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          :  Text(
                        loc.insert,
                        style: GoogleFonts.inter(fontSize: 18.sp,color: ColorsManager.white, fontWeight: FontWeight.bold),
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