import 'package:flutter/material.dart';

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
