import 'package:freezed_annotation/freezed_annotation.dart';
part 'access_camera_state.freezed.dart';

@freezed
sealed class AccessCameraState with _$AccessCameraState {
  const factory AccessCameraState.allowed() = _Allowed;
  const factory AccessCameraState.notAllowed() = _NotAllowed;
  const factory AccessCameraState.error(String e) = _Error;
 
}
