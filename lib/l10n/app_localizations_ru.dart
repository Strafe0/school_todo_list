import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get myTasks => 'Мои дела';

  @override
  String get loading => 'Загрузка';

  @override
  String completed(Object count) {
    return 'Выполнено - $count';
  }

  @override
  String get newTask => 'Новое';

  @override
  String get no => 'Нет';

  @override
  String get save => 'Сохранить';

  @override
  String get buttonCancel => 'Отмена';

  @override
  String get taskLabelText => 'Что нужно сделать...';

  @override
  String get buttonDelete => 'Удалить';

  @override
  String get importance => 'Важность';

  @override
  String get importanceLow => 'Низкая';

  @override
  String get importanceHigh => 'Высокая';

  @override
  String get importanceNone => 'Нет';

  @override
  String get errorSavingTask => 'Ошибка сохранения задачи';

  @override
  String get titleDeadline => 'Сделать до';

  @override
  String get errorDeletingTask => 'Ошибка удаления задачи';

  @override
  String get questionDeleteTask => 'Удалить задачу?';

  @override
  String get warningDeletionIsIrreversible => 'После удаления задачу нельзя будет восстановить.';

  @override
  String get errorCreationTask => 'Ошибка создания задачи';

  @override
  String get errorUpdatingTask => 'Ошибка обновления задачи';
}
