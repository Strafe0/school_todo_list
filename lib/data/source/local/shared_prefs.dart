import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  SharedPrefsManager();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  late final SharedPreferences prefs;

  static const String localRevisionKey = "local_revision";
  static const String remoteRevisionKey = "remote_revision";

  int readLocalRevision() {
    return prefs.getInt(localRevisionKey) ?? 0;
  }

  Future<void> writeLocalRevision(int newValue) async {
    await prefs.setInt(localRevisionKey, newValue);
  }

  int readRemoteRevision() {
    return prefs.getInt(remoteRevisionKey) ?? 0;
  }

  Future<void> writeRemoteRevision(int newValue) async {
    await prefs.setInt(remoteRevisionKey, newValue);
  }
}
