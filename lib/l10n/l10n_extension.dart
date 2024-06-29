import 'package:flutter/widgets.dart';
import 'package:school_todo_list/l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}

Future<AppLocalizations> get l10n {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final preferred = widgetsBinding.platformDispatcher.locales;
  const supported = AppLocalizations.supportedLocales;
  final locale = basicLocaleListResolution(preferred, supported);
  return AppLocalizations.delegate.load(locale);
}
