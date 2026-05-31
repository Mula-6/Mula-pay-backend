

import 'package:freezed_annotation/freezed_annotation.dart';
part  'home_state.freezed.dart';

@freezed 
sealed class HomeState with _$HomeState{
  const factory HomeState.initial() = _Initial;

  
}