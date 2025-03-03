// GridView.count(
// padding: REdgeInsets.symmetric(vertical: 20),
// crossAxisCount: 3,
// crossAxisSpacing: 10,
// mainAxisSpacing: 14,
// shrinkWrap: true,
// physics: const NeverScrollableScrollPhysics(),
// children: [
// CategoriesItem(imagePath: AssetsManager.cardiology, title: AppLocalizations.of(context)!.cardiology),
// CategoriesItem(imagePath: AssetsManager.pulmonology, title: AppLocalizations.of(context)!.pulmonology),
// CategoriesItem(imagePath: AssetsManager.dentistry, title: AppLocalizations.of(context)!.dentistry),
// CategoriesItem(imagePath: AssetsManager.orthopedics, title: AppLocalizations.of(context)!.orthopedics),
// CategoriesItem(imagePath: AssetsManager.pediatrics, title: AppLocalizations.of(context)!.pediatrics),
// CategoriesItem(imagePath: AssetsManager.oncology, title: AppLocalizations.of(context)!.oncology),
// CategoriesItem(imagePath: AssetsManager.ophthalmology, title: AppLocalizations.of(context)!.ophthalmology),
// CategoriesItem(imagePath: AssetsManager.dermatology, title: AppLocalizations.of(context)!.dermatology),
// CategoriesItem(imagePath: AssetsManager.obGYN, title: AppLocalizations.of(context)!.oBGYN),
// CategoriesItem(imagePath: AssetsManager.surgery, title: AppLocalizations.of(context)!.surgery),
// CategoriesItem(imagePath: AssetsManager.physicalTherapy, title: AppLocalizations.of(context)!.physicalTherapy),
// CategoriesItem(imagePath: AssetsManager.psychiatry, title: AppLocalizations.of(context)!.psychiatry),
// CategoriesItem(imagePath: AssetsManager.neurology, title: AppLocalizations.of(context)!.neurology),
// CategoriesItem(imagePath: AssetsManager.internalMedicine, title: AppLocalizations.of(context)!.internalMedicine),
// CategoriesItem(imagePath: AssetsManager.eNT, title: AppLocalizations.of(context)!.eNT),
// ],
// ),
//
//
//
//
// import 'package:aljoud_hospital/core/utils/color_manager.dart';
// import 'package:aljoud_hospital/core/utils/routes_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/utils/assets_manager.dart';
// import '../home/categories_item/categories_item.dart';
//
// class SeeAllScreen extends StatefulWidget {
// const SeeAllScreen({super.key});
//
// @override
// State<SeeAllScreen> createState() => _SeeAllScreenState();
// }
//
// class _SeeAllScreenState extends State<SeeAllScreen> {
// @override
// Widget build(BuildContext context) {
// return SafeArea(
// child: Scaffold(
// appBar: AppBar(
// backgroundColor: ColorsManager.blue2,
// leading: IconButton(onPressed: (){
// Navigator.pushReplacementNamed(context, RoutesManager.home);
// }, icon: const Icon(Icons.arrow_back, size: 30, color: ColorsManager.white,)),
// title: Text(AppLocalizations.of(context)!.categories, style: Theme.of(context).textTheme.bodyMedium),
// ),
//
// body: GridView.count(
// padding: REdgeInsets.symmetric(vertical: 20, horizontal: 5),
// crossAxisCount: 3,
// crossAxisSpacing: 5,
// mainAxisSpacing: 14,
// shrinkWrap: true,
// physics: const NeverScrollableScrollPhysics(),
// children: [
// InkWell(
// onTap: (){
//
// },
// child: CategoriesItem(imagePath: AssetsManager.cardiology, title: AppLocalizations.of(context)!.cardiology)),
// InkWell(
// onTap: (){
//
// },
// child: CategoriesItem(imagePath: AssetsManager.pulmonology, title: AppLocalizations.of(context)!.pulmonology)),
// InkWell(
// onTap: (){
//
// },
// child: CategoriesItem(imagePath: AssetsManager.dentistry, title: AppLocalizations.of(context)!.dentistry)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.orthopedics, title: AppLocalizations.of(context)!.orthopedics)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.pediatrics, title: AppLocalizations.of(context)!.pediatrics)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.oncology, title: AppLocalizations.of(context)!.oncology)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.ophthalmology, title: AppLocalizations.of(context)!.ophthalmology)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.dermatology, title: AppLocalizations.of(context)!.dermatology)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.obGYN, title: AppLocalizations.of(context)!.oBGYN)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.surgery, title: AppLocalizations.of(context)!.surgery)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.physicalTherapy, title: AppLocalizations.of(context)!.physicalTherapy)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.psychiatry, title: AppLocalizations.of(context)!.psychiatry)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.neurology, title: AppLocalizations.of(context)!.neurology)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.internalMedicine, title: AppLocalizations.of(context)!.internalMedicine)),
// InkWell(
// onTap: (){},
// child: CategoriesItem(imagePath: AssetsManager.eNT, title: AppLocalizations.of(context)!.eNT)),
// ],
// ),
// ),
// );
// }
// }
