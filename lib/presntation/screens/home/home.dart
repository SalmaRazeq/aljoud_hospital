import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.blue.shade800],
                ),
                borderRadius:  BorderRadius.only(
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: ColorsManager.white,
                          child: const Icon(
                            Icons.person_2_outlined,
                            color: ColorsManager.black2,
                          ),
                        ),
                        SizedBox(width: 12.w,),
                        Text('Hello, Ahmed',
                          style: GoogleFonts.sourceSerif4(
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp,
                              color: ColorsManager.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h,),
                    Padding(
                      padding: REdgeInsets.only(left: 8.0),
                      child: Text(
                        'Find your doctor',
                        style: GoogleFonts.sourceSerif4(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white),
                      ),
                    ),
                    SizedBox( height: 22.h,),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600 ,color: Theme.of(context).colorScheme.shadow),
                          filled: true,
                          isDense: true,
                          fillColor: ColorsManager.white,
                          contentPadding: REdgeInsets.symmetric(vertical: 14, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: Padding(
                            padding: REdgeInsets.all(8),
                            child: Icon(
                              Icons.search,
                              size: 22.sp,
                              color: ColorsManager.blue,
                            ),
                          ),

                        ),
                      ),
                    )
                  ]),
            ),
        ),
    );
  }
}
