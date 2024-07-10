import 'package:school_todo_list/data/source/local/shared_prefs.dart';

class RevisionHolder {
  RevisionHolder(this._prefs);

  final SharedPrefsManager _prefs;

  int get revision => _prefs.readRevision();

  Future<void> saveRevision(int newValue) async =>
      await _prefs.writeRevision(newValue);

  static const revisionKey = "revision";
}
