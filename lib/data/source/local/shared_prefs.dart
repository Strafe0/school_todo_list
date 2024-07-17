import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  SharedPrefsManager();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  late final SharedPreferences prefs;

  static const String revisionKey = "revision";

  int readRevision() {
    return prefs.getInt(revisionKey) ?? 0;
  }

  Future<void> writeRevision(int newValue) async {
    await prefs.setInt(revisionKey, newValue);
  }
}
