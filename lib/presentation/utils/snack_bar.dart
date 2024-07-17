import 'package:flutter/material.dart';
import 'package:school_todo_list/l10n/l10n_extension.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Future<void> Function()? syncAction,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      actionOverflowThreshold: 0,
      action: SnackBarAction(
        label: context.loc.buttonSync,
        textColor: Theme.of(context).colorScheme.surface,
        onPressed: () async {
          if (syncAction != null) {
            await syncAction();
          }
        },
      ),
    ),
  );
}
