
import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../home/categories_item/categories_item.dart';
import '../../widgets/build_circleButton.dart';
import 'doctor_card.dart';

class CategoryDetailsScreen extends StatelessWidget {
   final CategoriesItem category;

  CategoryDetailsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Doctor> doctors = [
      Doctor(
        name: "Dr. Omar El Naggar",
        specialty: category.title,
        rating: 3.5,
        experience: 12,
        month: "15 Feb",
        time : "12pm:9pm ",
        price: "350 L.E" ,
        image: "${AssetsManager.doctor1}", // Replace with real image
      ),
      Doctor(
        name: "Dr. Sarah Amgad",
        specialty: category.title,
        rating: 5.0,
        experience: 10,
        month: "19 Feb",
        time : '9am:4pm ',
        price: "550 L.E" ,
        image: "${AssetsManager.doctor2}",
      ),
      Doctor(
        name: "Dr. Rashed Ali",
        specialty: category.title,
        rating: 4.5,
        experience: 11,
        month: "20 Feb",
        time : "10am:7pm ",
        price: "500 L.E" ,
        image: "${AssetsManager.doctor3}",
      ),
      Doctor(
        name: "Dr. Hana Yasser",
        specialty: category.title,
        rating: 3.5,
        experience: 8,
        month: "23 Feb",
        time : '3pm:9pm ',
        price: "450 L.E" ,
        image: "${AssetsManager.doctor4}",
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildCircleButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () {
                        Navigator.pop(context);
                      }
                  ),
                  Text("${category.title} Doctors", style: Theme.of(context).textTheme.bodySmall,),
                  BuildCircleButton(
                      icon: Icons.search,
                      onTap: () {

                      }
                  ),
                ],
              ),
              Padding(
                padding: REdgeInsets.only(left: 20.w, right: 20.w, top: 5.h),
                child:  Divider(color: Theme.of(context).dividerColor, thickness: 1.w,),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(doctor: doctors[index]);
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int experience;
  final String month;
  final String time;
  final String price;
  final String image;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.experience,
    required this.month,
    required this.time,
    required this.price,
    required this.image,
  });
}