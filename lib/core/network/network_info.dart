import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo {
  Future<bool> get connection;
}

class NetWorkInfoImp implements NetWorkInfo {
  final InternetConnectionChecker isConnected;

  NetWorkInfoImp({required this.isConnected});

  @override
  Future<bool> get connection =>   isConnected.hasConnection;
}
