import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part '../../../data/repo/storage/storage_repo_impl.dart';



abstract class StorageRepo {
  Future<void> set<T>({required String key, required T value});
  T? get<T>({required String key});
  Future<void> delete({required String key});

  Future<void> clearStorage();
}
