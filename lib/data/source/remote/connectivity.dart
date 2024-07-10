import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionChecker {
  ConnectionChecker();

  final Connectivity _connectivity = Connectivity();

  Stream<bool> get connectionStream =>
      _connectivity.onConnectivityChanged.map((connectivityResult) {
        return !connectivityResult.contains(ConnectivityResult.none);
      }).distinct();

  Future<bool> hasConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();

    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
