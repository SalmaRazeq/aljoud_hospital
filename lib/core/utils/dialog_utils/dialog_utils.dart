import 'package:aljoud_hospital/core/utils/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogUtils {
  static void showLoading(context, {required String message, bool isDismissible = true}) {
    showDialog(barrierDismissible: isDismissible, context: context, builder: (context) =>
        CupertinoAlertDialog(
        content: SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 2,
                child: Text(
                  message, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w400),),),
              Expanded(flex: 1,
                child: SpinKitFadingCircle(size: 30.sp, color: ColorsManager.blue2,),),
            ],),),
        ),
    );
  }
  static void hide(context) {Navigator.pop(context);}
  static void showMessage(context, {String? title, String? body,
    String? posActionTitle, String? negActionTitle, VoidCallback? posAction, VoidCallback? negAction}) {
    showDialog(context: context,
        builder: (context) => CupertinoAlertDialog(
          title: title != null ? Text(title,
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400),)
                  : null,
          content: body != null ? Text(body,
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400))
                  : null,
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
