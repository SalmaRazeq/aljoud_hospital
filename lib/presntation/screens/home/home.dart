
import 'package:aljoud_hospital/presntation/screens/home/home_tab/home_tab.dart';
import 'package:aljoud_hospital/presntation/screens/home/liveChat_tab/liveChat.dart';
import 'package:aljoud_hospital/presntation/screens/home/profile_tab/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../l10n/app_localizations.dart';
import 'myBooking_tab/myBooking.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> tabs = [
    HomeScreen(),
    LiveChatScreen(),
    MyBookingScreen(),
    ProfileScreen()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
          child: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },

              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: const ImageIcon(AssetImage(AssetsManager.homeIcon),),
                    label: AppLocalizations.of(context)!.home),
                BottomNavigationBarItem(
                    icon: const ImageIcon(AssetImage(AssetsManager.liveChatIcon)),
                    label: AppLocalizations.of(context)!.liveChat),
                BottomNavigationBarItem(
                    icon: const ImageIcon(AssetImage(AssetsManager.scheduleIcon)),
                    label: AppLocalizations.of(context)!.myBooking),
                BottomNavigationBarItem(
                  icon: const ImageIcon(AssetImage(AssetsManager.userIcon)),
                  label: AppLocalizations.of(context)!.profile,
                ),
              ]),
        ),
        body: tabs[selectedIndex],
      ),
    );
  }
}
