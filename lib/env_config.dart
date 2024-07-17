class EnvConfig {
  static const defaultAppName = 'To-Do ШМР';
  static const devAppName = '[dev] $defaultAppName';

  static const appName = String.fromEnvironment(
      'MY_APP_NAME',
      defaultValue: defaultAppName,
  );
  static const appSuffix = String.fromEnvironment('MY_APP_SUFFIX');

  static bool get isDevFlavor => appName == devAppName;
}