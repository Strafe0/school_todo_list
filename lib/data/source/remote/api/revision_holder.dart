import 'package:school_todo_list/data/source/local/shared_prefs.dart';

class RevisionHolder {
  RevisionHolder(this._prefs);

  final SharedPrefsManager _prefs;

  int get localRevision => _prefs.readLocalRevision();

  int get remoteRevision => _prefs.readRemoteRevision();

  Future<void> saveLocalRevision(int newValue) async =>
      await _prefs.writeLocalRevision(newValue);

  Future<void> saveRemoteRevision(int newValue) async =>
      await _prefs.writeRemoteRevision(newValue);

  Future<void> increaseLocalRevision() async {
    await _prefs.writeLocalRevision(localRevision + 1);
  }

  Future<void> increaseRemoteRevision() async {
    await _prefs.writeRemoteRevision(remoteRevision + 1);
  }

  static const revisionKey = "revision";
}
