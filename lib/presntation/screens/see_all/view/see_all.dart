import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/categories_item/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../category_details/CategoryDetailsScreen.dart';
import '../view_model/doctor_view_model.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> specialties = [
      'Cardiology', 'Pulmonology', 'Dentistry', 'Orthopedics',
      'Pediatrics', 'Oncology', 'Ophthalmology', 'Dermatology',
      'OB-GYN', 'Surgery', 'Physical therapy', 'Psychiatry',
      'Neurology', 'Internal medicine', 'ENT',
    ];
    final List<CategoriesItem> categories = [
      CategoriesItem(imagePath: AssetsManager.cardiology, title: AppLocalizations.of(context)!.cardiology),
      CategoriesItem(imagePath: AssetsManager.pulmonology, title: AppLocalizations.of(context)!.pulmonology),
      CategoriesItem(imagePath: AssetsManager.dentistry, title: AppLocalizations.of(context)!.dentistry),
      CategoriesItem(imagePath: AssetsManager.orthopedics, title: AppLocalizations.of(context)!.orthopedics),
      CategoriesItem(imagePath: AssetsManager.pediatrics, title: AppLocalizations.of(context)!.pediatrics),
      CategoriesItem(imagePath: AssetsManager.oncology, title: AppLocalizations.of(context)!.oncology),
      CategoriesItem(imagePath: AssetsManager.ophthalmology, title: AppLocalizations.of(context)!.ophthalmology),
      CategoriesItem(imagePath: AssetsManager.dermatology, title: AppLocalizations.of(context)!.dermatology),
      CategoriesItem(imagePath: AssetsManager.obGYN, title: AppLocalizations.of(context)!.oBGYN),
      CategoriesItem(imagePath: AssetsManager.surgery, title: AppLocalizations.of(context)!.surgery),
      CategoriesItem(imagePath: AssetsManager.physicalTherapy, title: AppLocalizations.of(context)!.physicalTherapy),
      CategoriesItem(imagePath: AssetsManager.psychiatry, title: AppLocalizations.of(context)!.psychiatry),
      CategoriesItem(imagePath: AssetsManager.neurology, title: AppLocalizations.of(context)!.neurology),
      CategoriesItem(imagePath: AssetsManager.internalMedicine, title: AppLocalizations.of(context)!.internalMedicine),
      CategoriesItem(imagePath: AssetsManager.eNT, title: AppLocalizations.of(context)!.eNT),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutesManager.home);
          },
          icon: Icon(Icons.arrow_back_rounded, size: 25.sp, color: ColorsManager.white),
        ),
        title: Text(AppLocalizations.of(context)!.categories, style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: Consumer<DoctorViewModel>(
        builder: (context, value, child) {
          return Padding(
            padding: REdgeInsets.only(top: 25.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await value.getSpecialDoctor(specialty: specialties[index]);
                    print('Checking data for ${specialties[index]}: ${value.getDataForSpecialty(specialties[index])?.map((e) => e.drID).toList()}');
                    if (value.getDataForSpecialty(specialties[index])!.isNotEmpty) {
                      print('Navigating with specialty: ${specialties[index]}');
                      Navigator.pushNamed(context, RoutesManager.categoryDetails, arguments: specialties[index]);
                    } else {
                      print('No data available for specialty: ${specialties[index]}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('جاري تحميل البيانات، حاول مرة أخرى بعد لحظات')),
                      );
                    }
                  },
                  child: categories[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}