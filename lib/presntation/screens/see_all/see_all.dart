import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/presntation/screens/home/categories_item/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/routes_manager.dart';
import 'category_details/CategoryDetailsScreen.dart';

class SeeAllScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.blue2,
          leading: IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, RoutesManager.home);
            },
              icon: Icon(Icons.arrow_back_rounded, size: 26.sp, color: ColorsManager.white,)),
          title: Text(AppLocalizations.of(context)!.categories, style: Theme.of(context).textTheme.bodyMedium),
        ),

        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 2, vertical: 20),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                      builder: (context) => CategoryDetailsScreen(category: categories[index]),
                  ));

                },
                child: categories[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

