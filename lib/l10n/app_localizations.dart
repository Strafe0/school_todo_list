import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru'),
    Locale('en')
  ];

  /// No description provided for @myTasks.
  ///
  /// In ru, this message translates to:
  /// **'Мои дела'**
  String get myTasks;

  /// No description provided for @loading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка'**
  String get loading;

  /// No description provided for @completed.
  ///
  /// In ru, this message translates to:
  /// **'Выполнено - {count}'**
  String completed(int count);

  /// No description provided for @newTask.
  ///
  /// In ru, this message translates to:
  /// **'Новое'**
  String get newTask;

  /// No description provided for @no.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get no;

  /// No description provided for @buttonSave.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get buttonSave;

  /// No description provided for @buttonCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get buttonCancel;

  /// No description provided for @taskLabelText.
  ///
  /// In ru, this message translates to:
  /// **'Что нужно сделать...'**
  String get taskLabelText;

  /// No description provided for @buttonDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get buttonDelete;

  /// No description provided for @importance.
  ///
  /// In ru, this message translates to:
  /// **'Важность'**
  String get importance;

  /// No description provided for @importanceLow.
  ///
  /// In ru, this message translates to:
  /// **'Низкая'**
  String get importanceLow;

  /// No description provided for @importanceHigh.
  ///
  /// In ru, this message translates to:
  /// **'Высокая'**
  String get importanceHigh;

  /// No description provided for @importanceNone.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get importanceNone;

  /// No description provided for @errorSavingTask.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сохранения задачи'**
  String get errorSavingTask;

  /// No description provided for @titleDeadline.
  ///
  /// In ru, this message translates to:
  /// **'Сделать до'**
  String get titleDeadline;

  /// No description provided for @errorDeletingTask.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка удаления задачи'**
  String get errorDeletingTask;

  /// No description provided for @questionDeleteTask.
  ///
  /// In ru, this message translates to:
  /// **'Удалить задачу?'**
  String get questionDeleteTask;

  /// No description provided for @warningDeletionIsIrreversible.
  ///
  /// In ru, this message translates to:
  /// **'После удаления задачу нельзя будет восстановить.'**
  String get warningDeletionIsIrreversible;

  /// No description provided for @errorCreationTask.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка создания задачи'**
  String get errorCreationTask;

  /// No description provided for @errorUpdatingTask.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка обновления задачи'**
  String get errorUpdatingTask;

  /// No description provided for @errorLoadingTasks.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка при загрузке задач.'**
  String get errorLoadingTasks;

  /// No description provided for @buttonTryAgain.
  ///
  /// In ru, this message translates to:
  /// **'Попробовать снова'**
  String get buttonTryAgain;

  /// Task list is empty
  ///
  /// In ru, this message translates to:
  /// **'{showCompleted, select, true{Список задач пуст.} other{Список невыполненных задач пуст.}}'**
  String taskListIsEmpty(String showCompleted);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
