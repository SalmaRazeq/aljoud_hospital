
import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogUtils {
  static void showLoading(context,
      {required String message, bool isDismissible = true}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: SizedBox(
          height: 40,
          child: Row(
            children: [
              Text(
                message,
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 20.w),
              SpinKitFadingCircle(
                size: 30.sp,
                color: ColorsManager.blue2,
              ),
            ],
          ),
        ),

      ),
    );
  }

  static void hide(context) {
    Navigator.pop(context);
  }

  // VoidCallback => void function don't take parameters

  static void showMessage(context, {String? title, String? body,
    String? posActionTitle, String? negActionTitle, VoidCallback? posAction, VoidCallback? negAction}) {
    showDialog(context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title, style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400),) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if(posActionTitle != null)
              MaterialButton(onPressed: (){
                Navigator.pop(context);  //hide dialog
                posAction?.call();  //!= null
              }, child: Text(posActionTitle)),// ok button
            if(negActionTitle != null)
              MaterialButton(onPressed: (){
                Navigator.pop(context);
                negAction?.call();
              }, child: Text(negActionTitle))//cancel button
          ],
        ));
  }

}
