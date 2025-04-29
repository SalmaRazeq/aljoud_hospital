import 'package:aljoud_hospital/core/utils/assets_manager.dart';
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/booking_model.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabs = ["Upcoming", "Completed", "Canceled"];

  final List<Map<String, dynamic>> upcomingBookings = [
    {
      "doctorName": "Dr. Omar El Naggar",
      "specialty": "Cardiologist",
      "city": "Nasr City",
      "date": "Feb 23 ,2025",
      "time": "10:00 AM",
      "price": "100",
      "icon": Icons.calendar_month_outlined,
    },
    {
      "doctorName": "Dr. Sarah Amgad",
      "specialty": "Cardiologist",
      "city": "Abour City",
      "date": "Feb 24 ,2025",
      "time": "09:45 AM",
      "price": "250",
      "icon": Icons.videocam_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTab(int index, String label) {
    bool isSelected = _tabController.index == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? ColorsManager.blue3 : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: GoogleFonts.sourceSerif4(
              fontSize: 16,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard({
    required String doctorName,
    required String specialty,
    required String city,
    required String date,
    required String time,
    required String price,
    required IconData icon,
    required String headerTitle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.blue6,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headerTitle,
                      style: GoogleFonts.sourceSerif4(
                        color: ColorsManager.lightGreen,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "$date   $time",
                      style: GoogleFonts.sourceSerif4(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.lightGray,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "$price EGP",
                      style: GoogleFonts.sourceSerif4(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.black3,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ColorsManager.blue8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    icon,
                    color: ColorsManager.blue7,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AssetsManager.doctor1),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorName,
                        style: GoogleFonts.sourceSerif4(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.black3,
                        ),
                      ),
                      Text(
                        "$specialty , $city",
                        style: GoogleFonts.sourceSerif4(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.black3,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildBookingList(String status) {
    return upcomingBookings.map((booking) {
      return buildCard(
        doctorName: booking["doctorName"],
        specialty: booking["specialty"],
        city: booking["city"],
        date: booking["date"],
        time: booking["time"],
        price: booking["price"],
        icon: booking["icon"],
        headerTitle: "$status Appointments",
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "My Bookings",
              style: GoogleFonts.sourceSerif4(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: ColorsManager.black,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                tabs.length,
                    (index) => buildTab(index, tabs[index]),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs.map((tab) {
                  return ListView(
                    children: buildBookingList(tab),
                  );
                }).toList(),
              ),
            ),
            // Center(
            //   child: SizedBox(
            //     width: 200,
            //     child: ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: ColorsManager.blue,
            //         padding: REdgeInsets.symmetric(vertical: 15),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //       ),
            //       child: Text(
            //         'Confirm Booking',
            //         style: GoogleFonts.sourceSerif4(
            //           fontSize: 16.sp,
            //           fontWeight: FontWeight.w700,
            //           color: ColorsManager.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}


void addBooking(BookingModel booking) async {
  CollectionReference bookings = FirebaseFirestore.instance.collection('Bookings');

  try {
    await bookings.add(booking.toFirestore());
    print("Booking added successfully!");
  } catch (e) {
    print("Error adding booking: $e");
  }
}

