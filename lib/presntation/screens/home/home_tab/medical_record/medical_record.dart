import 'dart:math';

import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/presntation/screens/widgets/build_circleButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/dialog_utils/dialog_utils.dart';
import '../../../../../data/models/user_dm.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../providers/theme_provider.dart';
import 'build_table/build_table.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String? fullName, gender, day, month, year;
  String? medicalRecordId;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    DialogUtils.showLoading(context,
        message: AppLocalizations.of(context)!.loading);

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final firestore = FirebaseFirestore.instance;
        final userDocRef = firestore.collection('Users').doc(user.uid);

        DocumentSnapshot userDoc = await userDocRef.get();

        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          UserDM userDM = UserDM.fromFireStore(userData);

          if (userData['medicalRecordId'] == null ||
              (userData['medicalRecordId'] as String).isEmpty) {
            String generatedId =
                generateMedicalRecordId(userDM.fullName ?? "USR");
            await userDocRef.update({'medicalRecordId': generatedId});
          }

          setState(() {
            fullName = userDM.fullName ?? '...';
            gender = userDM.gender;
            day = userDM.day;
            month = userDM.month;
            year = userDM.year;
            medicalRecordId = userData['medicalRecordId'];
          });
        }
      }
    } catch (e) {
      DialogUtils.showMessage(e);
    } finally {
      Navigator.of(context).pop();
    }
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.white,
        side: BorderSide(color: ColorsManager.blue2, width: 1.5.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 6.h),
        elevation: 1,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: ColorsManager.blue2,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMedicalHistoryTab() {
    final loc = AppLocalizations.of(context)!;

    return CustomDataTable(
      rows: [
        [loc.date, loc.diagnosis, loc.doctor],
        ["04/02/2025", "Hypertension", "Dr. Omar"],
        ["10/02/2025", "Arrhythmia", "Dr. Hana"],
        ["15/02/2025", "Thalassemia", "Dr. Rashed"],
        ["22/02/2025", "Dilated Cardiomyopathy", "Dr. Omar"],
      ],
    );
  }

  Widget _buildMedicationsTab() {
    final loc = AppLocalizations.of(context)!;
    return CustomDataTable(
      rows: [
        [loc.medication, loc.dosage, loc.frequency],
        ["Lisinpril", "10 Mg", "Once Daily"],
        ["Atorvastatin", "20 Mg", "Twice Daily"],
        ["Metformin", "500 Mg", "Twice Daily"],
        ["Amlodipine", "5 Mg", "Once Daily"],
      ],
    );
  }

  Widget _buildLabResultsTab() {
    final loc = AppLocalizations.of(context)!;
    return CustomDataTable(
      rows: [
        [loc.test, loc.result, loc.date],
        ["Glucose", "95 Mg/dL", "03/10/2024"],
        ["Cholesterol", "180 Mg/dL", "03/10/2024"],
        ["Hemoglobin", "14.2 G/dL", "02/10/2024"],
        ["Calcium", "9.6 Mg/dL", "15/01/2024"],
      ],
    );
  }

  Widget _buildInfoRow({
    IconData? icon,
    String? title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18.sp, color: ColorsManager.blue2),
            SizedBox(width: 12.w),
          ],
          if (title != null) ...[
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ColorsManager.blue2,
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 13.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 20.h),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 5.w,
              ),
              BuildCircleButton(
                  icon: Icons.arrow_back_ios_new_outlined,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              Expanded(
                child: Center(
                  child: Text(loc.medicalRecords,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 20.sp,
                          color: Theme.of(context).colorScheme.primaryFixed)),
                ),
              ),
              SizedBox(width: 30.w),
            ],
          ),
          SizedBox(height: 10.h),
          Divider(
            color: Theme.of(context).dividerColor,
            thickness: 0.6.w,
            height: 20.h,
          ),
          SizedBox(
            height: 18.h,
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${loc.name} : ${fullName ?? '...'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _buildInfoRow(
                    title: "${loc.id} :", value: "${medicalRecordId ?? '..'}"),
                _buildInfoRow(
                    icon: Icons.calendar_today,
                    value: "${day ?? '..'}/${month ?? '..'}/${year ?? '..'}"),
                _buildInfoRow(
                    icon: Icons.person_outlined, value: "${gender ?? '..'}"),
                _buildInfoRow(
                  title: "${loc.bloodType} :",
                  value: "---",
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 40.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorsManager.hint),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              // هنا تم تعديلها عشان التابات تتوزع بالتساوي
              labelColor: Theme.of(context).colorScheme.primaryFixed,
              unselectedLabelColor: ColorsManager.hint,
              indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 1.5.w, color: ColorsManager.blue2),
                insets: EdgeInsets.symmetric(horizontal: 14.w),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 13.5.sp, fontWeight: FontWeight.w500),
              labelStyle: GoogleFonts.inter(
                  fontSize: 14.sp, fontWeight: FontWeight.w600),
              tabs: [
                Tab(text: loc.medicalHistory),
                Tab(text: loc.medications),
                Tab(text: loc.labResults),
              ],
            ),
          ),
          SizedBox(
            height: 350.h,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMedicalHistoryTab(),
                _buildMedicationsTab(),
                _buildLabResultsTab(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildButton(loc.addRecord, () {}),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildButton(loc.download, () {}),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildButton(loc.print, () {}),
                ),
              ],
            ),
          ),
        ]),
      ),
    )));
  }
}

String generateMedicalRecordId(String fullName) {
  // ناخد أول 3 حروف من الاسم (لو الاسم قصير ناخد طول الاسم كله)
  String namePart = fullName.trim().replaceAll(' ', '');
  if (namePart.length > 3) {
    namePart = namePart.substring(0, 3);
  }

  // نحول الحروف دي لأرقام عن طريق تحويل كل حرف لرقم ASCII ونجمعهم أو نعمل لهم صيغة رقمية
  int numericPart = 0;
  for (int i = 0; i < namePart.length; i++) {
    numericPart += namePart.codeUnitAt(i);
  }

  // نولد رقم عشوائي 3 أرقام
  int randomNumber = Random().nextInt(900) + 100; // من 100 إلى 999

  // ندمج الرقم الناتج من الحروف مع الرقم العشوائي
  return "${numericPart}${randomNumber}";
}
