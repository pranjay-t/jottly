import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class ConnectionChecker {
  Future<bool> get isConnected;
}

class ConnectionCheckerImp extends ConnectionChecker {
  final InternetConnection internetConnection;
  ConnectionCheckerImp({required this.internetConnection});

  @override
  Future<bool> get isConnected async => await internetConnection.hasInternetAccess;
}