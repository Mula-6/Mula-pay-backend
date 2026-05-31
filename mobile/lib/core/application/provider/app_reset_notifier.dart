import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppResetProvider extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
}

final appResetProvider = NotifierProvider<AppResetProvider, int>(
  AppResetProvider.new,
);
