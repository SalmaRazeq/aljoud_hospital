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

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Stream<DocumentSnapshot> getUserStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }
    return FirebaseFirestore.instance.collection('Users').doc(user.uid).snapshots();
  }

  Future<void> _generateMedicalRecordIdIfMissing(
      DocumentSnapshot snapshot, UserDM userDM) async {
    final docRef = FirebaseFirestore.instance.collection('Users').doc(userDM.id);
    if (snapshot['medicalRecordId'] == null || (snapshot['medicalRecordId'] as String).isEmpty) {
      String generatedId = generateMedicalRecordId(userDM.fullName ?? "USR");
      await docRef.update({'medicalRecordId': generatedId});
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

  Widget _buildInfoRow({IconData? icon, String? title, required String value}) {
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
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 20.h),
          child: StreamBuilder<DocumentSnapshot>(
            stream: getUserStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text("مافيش داتا "));
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;
              final userDM = UserDM.fromFireStore(userData);

              // تحقق وإنشاء المعرف إذا كان مفقود
              _generateMedicalRecordIdIfMissing(snapshot.data!, userDM);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 5.w),
                        BuildCircleButton(
                          icon: Icons.arrow_back_ios_new_outlined,
                          onTap: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              loc.medicalRecords,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 20.sp,
                                color: Theme.of(context).colorScheme.primaryFixed,
                              ),
                            ),
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
                    SizedBox(height: 18.h),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${loc.name} : ${userDM.fullName ?? '...'}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 15.sp),
                          ),
                          SizedBox(height: 10.h),
                          _buildInfoRow(
                              title: "${loc.id} :", value: "${userData['medicalRecordId'] ?? '..'}"),
                          _buildInfoRow(
                              icon: Icons.calendar_today,
                              value: "${userDM.day ?? '..'}/${userDM.month ?? '..'}/${userDM.year ?? '..'}"),
                          _buildInfoRow(
                              icon: Icons.person_outlined, value: "${userDM.gender ?? '..'}"),
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
                        labelColor: Theme.of(context).colorScheme.primaryFixed,
                        unselectedLabelColor: ColorsManager.hint,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 1.5.w, color: ColorsManager.blue2),
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
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Expanded(child: _buildButton(loc.addRecord, () {})),
                          SizedBox(width: 10.w),
                          Expanded(child: _buildButton(loc.download, () {})),
                          SizedBox(width: 10.w),
                          Expanded(child: _buildButton(loc.print, () {})),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

String generateMedicalRecordId(String fullName) {
  String namePart = fullName.trim().replaceAll(' ', '');
  if (namePart.length > 3) {
    namePart = namePart.substring(0, 3);
  }
  int numericPart = 0;
  for (int i = 0; i < namePart.length; i++) {
    numericPart += namePart.codeUnitAt(i);
  }
  int randomNumber = Random().nextInt(900) + 100; // من 100 إلى 999
  return "$numericPart$randomNumber";
}
