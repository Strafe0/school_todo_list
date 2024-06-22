import 'package:flutter/material.dart';
import 'package:school_todo_list/presentation/themes.dart';

BoxDecoration boxDecorationWithShadow(
    {required Color color, double radius = 9}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: color,
    boxShadow: const [
      BoxShadow(
        offset: Offset(0, 2),
        blurRadius: 2.0,
        blurStyle: BlurStyle.normal,
        color: shadow12,
      ),
      BoxShadow(
        offset: Offset(0, 0),
        blurRadius: 2.0,
        blurStyle: BlurStyle.normal,
        color: shadow6,
      ),
    ],
  );
}
