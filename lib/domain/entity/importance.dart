import 'package:flutter/material.dart';
import 'package:school_todo_list/l10n/l10n_extension.dart';

enum Importance {
  none,
  low,
  high;

  String getImportanceText(BuildContext context) {
    return switch (this) {
      Importance.high => context.loc.importanceHigh,
      Importance.low => context.loc.importanceLow,
      _ => context.loc.importanceNone,
    };
  }
}
