import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:aljoud_hospital/core/utils/routes_manager.dart';
import 'package:aljoud_hospital/data/models/doctor_model.dart';
import 'package:aljoud_hospital/presntation/screens/payment/widget/containers.dart';
import 'package:aljoud_hospital/presntation/screens/widgets/build_circleButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../see_all/category_details/CategoryDetailsScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({required this.doctor, super.key});
  final DoctorModel doctor;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.blue2,
        body: Stack(
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
              child: Row(
                children: [
                  BuildCircleButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(width: 30.w),
                  Text('Payment Methods',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 20.sp,
                          color: Theme.of(context).colorScheme.primary))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.81,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                padding: REdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Theme.of(context).colorScheme.primaryFixed)),
                        Container(
                          width: 80.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: ColorsManager.lightGray,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              '${widget.doctor.price}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontSize: 16.sp, color: ColorsManager.black),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40.h),

                    Container(
                      width: 85.w,
                      height: 33.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ColorsManager.black,
                        ),
                      ),
                      child: Center(
                        child: Text('Pay with',
                            style: Theme.of(context).textTheme.bodySmall?.
                            copyWith(fontSize: 17.sp, color: ColorsManager.black)),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // Payment Options
                    BuildContainer(
                      label: 'Cash',
                      value: 'cash',
                      iconPath: AssetsManager.cashIcon,
                      groupValue: selectedMethod,
                      onChanged: (val) {
                        setState(() {
                          selectedMethod = val!;
                        });
                      },
                    ),
                    BuildContainer(
                      label: 'xxxx-5239',
                      value: 'visa1',
                      iconPath: AssetsManager.monsterCardIcon,
                      groupValue: selectedMethod,
                      onChanged: (val) {
                        setState(() {
                          selectedMethod = val!;
                        });
                      },
                    ),
                    BuildContainer(
                      label: 'xxxx-6874',
                      value: 'visa2',
                      iconPath: AssetsManager.visaIcon,
                      groupValue: selectedMethod,
                      onChanged: (val) {
                        setState(() {
                          selectedMethod = val!;
                        });
                      },
                    ),
                    BuildContainer(
                      label: 'Add new card',
                      value: 'new_card',
                      iconPath: AssetsManager.circleIcon,
                      groupValue: selectedMethod,
                      onChanged: (val) {
                        setState(() {
                          selectedMethod = val!;
                          // ممكن هنا تفتح صفحة لإضافة بطاقة جديدة
                        });
                      },
                    ),

                    const Spacer(),

                    Center(
                      child: SizedBox(
                          width: 200.w,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RoutesManager.home);
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.blue2,
                              padding: REdgeInsets.symmetric(vertical: 10.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Confirm',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

