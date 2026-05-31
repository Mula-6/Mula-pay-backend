import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitMain {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  Future<SharedPreferences> initSharedPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<FlutterSecureStorage> initSecureStorage() async {
    return FlutterSecureStorage();
  }
}
