import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get myTasks => 'My tasks';

  @override
  String get loading => 'Loading';

  @override
  String completed(Object count) {
    return 'Completed - $count';
  }

  @override
  String get newTask => 'New';

  @override
  String get no => 'No';

  @override
  String get save => 'Save';

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
  String get warningDeletionIsIrreversible => 'Once deleted, the task cannot be restored.';

  @override
  String get errorCreationTask => 'Failed to create task';

  @override
  String get errorUpdatingTask => 'Failed to update task';
}
