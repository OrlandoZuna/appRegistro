import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';


class ConnectionStatusModel extends ChangeNotifier{
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _connectionSubscription;

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  ConnectionStatusModel() {
    _connectionSubscription = _connectivity.onConnectivityChanged.listen((_) => _chekInternetConnection());
    _chekInternetConnection();
  }
  Future<void> _chekInternetConnection() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
      }else{
        _isOnline = false;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    notifyListeners();
  }

  @override
  void dispose(){
    _connectionSubscription.cancel();
    super.dispose();
  }
}
