import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myTasks => 'My tasks';

  @override
  String get loading => 'Loading';

  @override
  String completed(int count) {
    return 'Completed - $count';
  }

  @override
  String get newTask => 'New';

  @override
  String get no => 'No';

  @override
  String get buttonSave => 'Save';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get taskLabelText => 'What should be done...';

  @override
  String get buttonDelete => 'Delete';

  @override
  String get importance => 'Importance';

  @override
  String get importanceLow => 'Low';

  @override
  String get importanceHigh => 'High';

  @override
  String get importanceNone => 'None';

  @override
  String get errorSavingTask => 'Failed to save task';

  @override
  String get titleDeadline => 'Do it before';

  @override
  String get errorDeletingTask => 'Failed to delete task';

  @override
  String get questionDeleteTask => 'Delete task?';

  @override
  String get warningDeletionIsIrreversible =>
      'Once deleted, the task cannot be restored.';

  @override
  String get errorCreationTask => 'Failed to create task';

  @override
  String get errorUpdatingTask => 'Failed to update task';

  @override
  String get errorLoadingTasks => 'An error occurred while loading tasks.';

  @override
  String get buttonTryAgain => 'Try again';

  @override
  String taskListIsEmpty(String showCompleted) {
    String _temp0 = intl.Intl.selectLogic(
      showCompleted,
      {
        'true': 'Task list is empty.',
        'other': 'The list of outstanding tasks is empty.',
      },
    );
    return '$_temp0';
  }

  @override
  String get offlineMode => 'Offline mode';

  @override
  String get buttonSync => 'Synchronize';
}
