import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/data/models/user_dm.dart';
import 'package:aljoud_hospital/presntation/screens/patient_details/widget/build_textField.dart';
import 'package:aljoud_hospital/presntation/screens/widgets/build_circleButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/dialog_utils/dialog_utils.dart';
import '../../../data/models/doctor/doctor_model.dart';
import '../../../data/models/patient_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/theme_provider.dart';
import '../payment/payment.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({required this.doctor, super.key});
  final DoctorModel doctor;

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedAge = '30+';
  String gender = 'female';


  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: themeProvider.isLightTheme() ? ColorsManager.lightGray.withOpacity(0.9) : ColorsManager.darkBlue,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                 margin: REdgeInsets.all(8) ,
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              BuildCircleButton(
                                  icon: Icons.arrow_back_ios_new_outlined,
                                  onTap: () {
                                    Navigator.pop(context);
                                  }),
                              Expanded(
                                child: Center(
                                  child: Text(
                                      loc.patientDetails,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 20.sp,
                                          color: Theme.of(context).colorScheme.primaryFixed)
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.w),
                            ],
                          ),
                  
                          SizedBox(
                            height: 32.h,
                          ),
                          Text(loc.patientName, style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(
                            height: 10.h,
                          ),
                  
                          BuildTextField(
                              icon: Icons.person,
                              hintText: loc.enterName,
                              controller: nameController,
                              validator: (input) {
                                if (input == null || input
                                    .trim()
                                    .isEmpty) {
                                  return loc.plzEnterName;
                                }
                                return null;
                              },),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(loc.selectYourAgeRange, style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(
                            height: 3.h,
                          ),
                          Wrap(
                            spacing: 8,
                            children: ['20+', '30+', '40+', '50+', '60+'].map((age) {
                              final isSelected = selectedAge == age;
                              return ChoiceChip(
                                labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12.sp,color: Theme.of(context).colorScheme.primaryFixed),
                                label: Text(
                                  age,
                                  style: TextStyle(
                                      color: isSelected
                                          ? ColorsManager.white
                                          : ColorsManager.black),
                                ),
                                selected: isSelected,
                                selectedColor: ColorsManager.blue3,
                                backgroundColor: ColorsManager.white,
                                onSelected: (val) {
                                  setState(() {
                                    selectedAge = age;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                  
                          Text(loc.phone, style: Theme.of(context).textTheme.bodySmall,),
                          SizedBox(
                            height: 10.h,
                          ),
                  
                          BuildTextField(
                            icon: Icons.phone,
                            hintText: loc.enterPhone,
                            keyBoardType: const TextInputType.numberWithOptions(),
                            controller: phoneNumController,
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return loc.plzPhone;
                              }
                              if (input.length != 11) {
                                return loc.password11digits;
                              }
                              return null;
                            },),
                  
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(loc.height, style: Theme.of(context).textTheme.bodySmall),
                                    SizedBox(height: 8.h),
                                    BuildTextField(icon: Icons.height,
                                        hintText: loc.cm,
                                        controller: heightController,
                                        keyBoardType: const TextInputType.numberWithOptions(),
                                        validator: (input) {
                                          if (input == null || input.trim().isEmpty) {
                                            return loc.enterHeight;
                                          }
                                          return null;
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(loc.weight, style: Theme.of(context).textTheme.bodySmall),
                                    SizedBox(height: 8.h),
                                    BuildTextField(
                                      icon: Icons.monitor_weight_outlined,
                                      hintText: loc.kg,
                                      controller: weightController,
                                      keyBoardType: const TextInputType.numberWithOptions(),
                                      validator: (input) {
                                        if (input == null || input.trim().isEmpty) {
                                          return loc.enterWeight;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h,),
                          Text(loc.gender, style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [loc.male, loc.female].map((g) {
                              return Expanded(
                                  child: Padding(
                                    padding: REdgeInsets.symmetric(horizontal: 5),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: gender == g
                                              ? ColorsManager.blue3
                                              : ColorsManager.white,
                                          foregroundColor: gender == g
                                              ? ColorsManager.white
                                              : ColorsManager.black,
                                          side: const BorderSide(color: ColorsManager.blue2),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            gender = g;
                                          });
                                        },
                                        child: Text(g)),
                                  ));
                            }).toList(),
                          ),
                  
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(loc.problem, style: Theme.of(context).textTheme.bodySmall),
                          SizedBox(
                            height: 10.h,
                          ),
                          Column(
                            children: [
                              TextField(
                                controller: problemController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: loc.tellTheDrYourProblem,
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: REdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                  
                              SizedBox(height: 28.h,),
                  
                              Center(
                                child: SizedBox(
                                    width: 240.w,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        savePatientDetails();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: REdgeInsets.symmetric(vertical: 6.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                      child: Text(
                                        loc.confirmBooking,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ]),
                  )),
            ),
          )),
    );
  }

  void savePatientDetails() async {
    //if (_formKey.currentState!.validate() == false) return;

    try {
      DialogUtils.showLoading(context, message: AppLocalizations.of(context)!.pleaseWait);

      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception("User is not logged in");

      await savePatientAutoId(userId);

      if (mounted) {
        DialogUtils.hide(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(doctor: widget.doctor),
          ),
        );
      }
    } catch (error) {
      DialogUtils.hide(context);
      DialogUtils.showMessage(context, body: error.toString());
      print(error);
    }
  }

  Future<void> savePatientAutoId(String uid) async {
    final patientCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(uid)
        .collection(PatientModel.collectionName);

    PatientModel patient = PatientModel(
      patientId: uid,
      patientName: nameController.text,
      patientPhone: phoneNumController.text,
      ageRange: selectedAge,
      gender: gender,
      height: double.tryParse(heightController.text),
      weight: double.tryParse(weightController.text),
      problemDescription: problemController.text,
    );

    await patientCollection.add(patient.toFireStore());
 }




}