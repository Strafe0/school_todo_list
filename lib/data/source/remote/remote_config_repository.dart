import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepository {
  RemoteConfigRepository(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  int? get errorColor => int.tryParse(
        _remoteConfig.getString(_ConfigFields.errorColor),
      );

  Future<void> init() async {
    _remoteConfig.setDefaults({
      _ConfigFields.errorColor: '0xFFFF3830',
    });
    await _remoteConfig.fetchAndActivate();
  }
}

abstract class _ConfigFields {
  static const errorColor = 'error_color';
}
