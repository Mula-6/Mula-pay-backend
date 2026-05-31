import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/state/access_camera_state.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessCameraStatusProvider extends AsyncNotifier<AccessCameraState> {
  @override
  Future<AccessCameraState> build() async {
    return _checkStatus();
  }

  Future<AccessCameraState> _checkStatus() async {
    try {
      final status = await Permission.camera.status;

      if (status.isGranted) {
        return AccessCameraState.allowed();
      }

      return AccessCameraState.notAllowed();
    } catch (e) {
      return AccessCameraState.error(e.toString());
    }
  }

  Future<void> updateCurrentState() async {
    state = const AsyncLoading();

    try {
      final status = await Permission.camera.request();

      if (status.isGranted) {
        state = AsyncData(AccessCameraState.allowed());
        return;
      }

      state = AsyncData(AccessCameraState.notAllowed());
    } catch (e) {
      state = AsyncData(AccessCameraState.error(e.toString()));
    }
  }
}

final accessCameraProvider =
    AsyncNotifierProvider<AccessCameraStatusProvider, AccessCameraState>(
      AccessCameraStatusProvider.new,
    );
