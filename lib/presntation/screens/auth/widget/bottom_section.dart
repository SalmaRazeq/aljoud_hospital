import 'package:flutter/material.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../l10n/app_localizations.dart';

class BottomSection extends StatelessWidget {
  BottomSection({super.key, required this.text, required this.body, this.routeName});
  String text;
  String body;
  String? routeName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            text,
            style: Theme.of(context).textTheme.displaySmall
        ),
        TextButton(
          onPressed: () {
            if (routeName != null && routeName!.isNotEmpty) {
              Navigator.pushNamed(context, routeName!);
            } else {
              // ممكن تحط هنا أكشن تاني زي مثلا إعادة إرسال الكود
              // أو تسيبه فاضي ما يعملش شيء
            }
          },
          child: Text(
              body,
              style: Theme.of(context).textTheme.displaySmall?.
              copyWith(color: Theme.of(context).colorScheme.onPrimary,
                  decoration: TextDecoration.underline)),
        )
      ],
    );
  }
}
