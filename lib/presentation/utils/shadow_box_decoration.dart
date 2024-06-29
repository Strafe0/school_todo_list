import 'package:flutter/material.dart';
import 'package:school_todo_list/presentation/themes.dart';

const BoxDecoration defaultBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(9)),
  color: Color(0xFFE6E6E6),
  boxShadow: [
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
