import '../../../core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class SwitchAuthPage extends StatelessWidget {
  final String label, link, route;
  final bool isArabic;
  const SwitchAuthPage(
      {super.key,
      required this.label,
      required this.link,
      required this.route,
      this.isArabic = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Text(label),
        buildTextButton(
            label: link,
            onPressed: () {
              Navigator.pushNamed(context, route);
            }),
      ],
    );
  }
}
