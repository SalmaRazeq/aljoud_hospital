import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/booking_model.dart';
import '../../../../l10n/app_localizations.dart';


class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<BookingModel>> _bookingsFuture;

  late List<String> tabs;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final loc = AppLocalizations.of(context)!;
    tabs = [loc.upComing, loc.completed, loc.canceled];
    _tabController = TabController(length: tabs.length, vsync: this);
    _bookingsFuture = getBookings();

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTab(int index, String label) {
    bool isSelected = _tabController.index == index;
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 4.w),
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
          setState(() {});
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          padding: REdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: isSelected ? ColorsManager.blue3 : ColorsManager.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            label,
            style: GoogleFonts.sourceSerif4(
              fontSize: 12.sp,
              color: isSelected ? ColorsManager.white : ColorsManager.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard({
    required BookingModel booking,
    required String headerTitle,
  }) {
    return Container(
        margin: REdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorsManager.lightBlue, ///change for dark mood
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              ),
              padding: REdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headerTitle,
                        style: GoogleFonts.sourceSerif4(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.lightGreen,
                        ),
                      ),

                      SizedBox(height: 2.h),

                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          "${booking.appointmentDate} - ${booking.appointmentTime}",
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        booking.meetingType == 'Online'
                            ? Icons.videocam_outlined
                            : Icons.calendar_month_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 22.sp,
                      ),
                      SizedBox(height: 4.h,),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          "${booking.price}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.sp)
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: REdgeInsets.all(14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26.r,
                    backgroundImage: AssetImage('${booking.image}'),
                  ),

                  SizedBox(width: 12.w),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${booking.doctorName}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14.sp)
                      ),
                      Text(
                        "${booking.doctorSpecialty}",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
    );
  }

  List<Widget> buildBookingList(List<BookingModel> bookings, String status) {
    return bookings.map((booking) {
      return buildCard(
        booking: booking,
        headerTitle: Localizations.localeOf(context).languageCode == 'ar'
            ? "${AppLocalizations.of(context)!.appointments} $status"
            : "$status ${AppLocalizations.of(context)!.appointments}",
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorsManager.beige,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.only(top: 20.h, left: 18.w, right: 18.w),
          child: Column(
            children: [

              Text(
                loc.myBooking,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 24.sp)
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  tabs.length,
                      (index) => buildTab(index, tabs[index]),
                ),
              ),

              SizedBox(height: 16.h),
              Expanded(
                  child: FutureBuilder<List<BookingModel>>(
                      future: _bookingsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${loc.error}: ${snapshot.error}"));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return  Center(child: Text(loc.noBookingsFound));
                        }
                        else {
                          List<BookingModel> bookings = snapshot.data!;
                          return TabBarView(
                            controller: _tabController,
                            children: tabs.map((tab) {
                              List<BookingModel> filteredBookings = bookings.where((booking) {
                                if (tab == loc.upComing) {
                                  return booking.status?.toLowerCase() == 'upcoming';
                                } else if (tab == loc.completed) {
                                  return booking.status?.toLowerCase() == 'completed';
                                } else {
                                  return booking.status?.toLowerCase() == 'canceled';
                                }
                              }).toList();


                              return ListView(
                                children: buildBookingList(filteredBookings, tab),
                              );
                            }).toList(),
                          );
                        }
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<BookingModel>> getBookings() async {
    try {
      // استرجاع بيانات الحجوزات من Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(BookingModel.collectionName).get();

      // تحويل البيانات إلى قائمة من BookingModel
      List<BookingModel> bookings = snapshot.docs.map((doc) {
        return BookingModel.fromFirestore(doc);
      }).toList();

      return bookings;
    } catch (e) {
      print("Error retrieving bookings: $e");
      return [];
    }
  }

}

