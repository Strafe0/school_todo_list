import 'package:flutter/material.dart';
import 'package:school_todo_list/domain/entity/importance.dart';

TextSpan createTextSpanWithImportance({
  required Importance importance,
  required String text,
}) {
  return TextSpan(
    children: [
      if (importance == Importance.high)
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(
            Icons.priority_high,
            color: Colors.red,
          ),
        ),
      if (importance == Importance.low)
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Icon(
            Icons.arrow_downward,
            color: Colors.grey,
          ),
        ),
      TextSpan(text: text),
    ],
  );
}
