import 'package:aljoud_hospital/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../home/categories_item/categories_item.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final CategoriesItem category;

  const CategoryDetailsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.only(top: 5),
          child: Column(
            children: [
              AppBar(
                title: Text("${category.title} Doctors", style: Theme.of(context).textTheme.bodyLarge,),
                centerTitle: true,
                elevation: 0,
                leading:  _buildCircleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutesManager.seeAll);
                    }
                ),
                actions: [
                  _buildCircleButton(
                      icon: Icons.search,
                      onTap: () {
                        Navigator.pushReplacementNamed(context, RoutesManager.seeAll);
                      }
                  ),
                ],
              ),
              Padding(
                padding: REdgeInsets.only(left: 20, right: 20),
                child: Divider(color: Colors.black, thickness: 1,),
              ),


              Text(category.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: REdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: ColorsManager.blue3,
            shape: BoxShape.circle,
            border: Border.all(
                color: ColorsManager.blue4,
                width: 1,
            ),
          ),
          child: Icon(icon, size: 20.sp, color: ColorsManager.white,),
        ),
      ),
    );
  }

}
