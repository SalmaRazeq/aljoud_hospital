import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../l10n/app_localizations.dart';
import '../../../../../auth/widget/doctor_item/doctor_textField.dart';

class InsertDoctorScreen extends StatelessWidget {
  const InsertDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController specializationController = TextEditingController();
    TextEditingController rattingController = TextEditingController();
    TextEditingController yearExperienceController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();
    final loc = AppLocalizations.of(context)!;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      AssetsManager.insertDr,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DoctorTextField(
                    hintText: loc.fullName,
                    controller: fullNameController,
                    icon: Icons.person_outlined,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return loc.plzFullName;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  DoctorTextField(
                    hintText: loc.specialization,
                    controller: specializationController,
                    icon: Icons.location_on_outlined,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return loc.plzEnterSpecialization;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DoctorTextField(
                            hintText: loc.yearsOfExperience,
                            controller: yearExperienceController,
                            icon: Icons.work_outline,
                            keyBoardType:
                                const TextInputType.numberWithOptions(),
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return loc.plzEnterYearsOfExperience;
                              }
                              return null;
                            }),
                      ),
                      SizedBox(
                        width: 4.h,
                      ),
                      Expanded(
                        flex: 2,
                        child: DoctorTextField(
                            hintText: loc.price,
                            controller: priceController,
                            icon: Icons.attach_money,
                            keyBoardType:
                                const TextInputType.numberWithOptions(),
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return loc.plzEnterPrice;
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() == false) return;
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        padding: REdgeInsets.symmetric(horizontal: 70.h)),
                    child: Padding(
                      padding: REdgeInsets.all(6),
                      child: Text(loc.insert,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
