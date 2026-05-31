import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:mobile/core/helpers/device.dart';
import 'package:mobile/core/shared/shared.dart';

import '../../../../features/kyc/application/provider/kyc_submtion_provider.dart';
import '../../../helpers/helper.dart';

class FaceCaptureWidget extends ConsumerStatefulWidget {
  final CameraDescription camera;

  const FaceCaptureWidget({super.key, required this.camera});

  @override
  ConsumerState<FaceCaptureWidget> createState() => _FaceCaptureWidgetState();
}

class _FaceCaptureWidgetState extends ConsumerState<FaceCaptureWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File? _capturedImage;
  bool _faceDetected = false;
  bool _capturing = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _captureAndCheckFace() async {
    try {
      setState(() {
        _capturing = true;
      });
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final imageFile = File(image.path);

      // Run face detection
      final inputImage = InputImage.fromFile(imageFile);
      final faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          enableContours: true,
          enableClassification: true,
        ),
      );

      final faces = await faceDetector.processImage(inputImage);
      faceDetector.close();

      if (faces.isEmpty) {
        // No face detected
        setState(() {
          _faceDetected = false;
          _capturedImage = null;
        });
        // ignore: use_build_context_synchronously
        DefaultSnackBar.showInfo("No face detected, please try again.");
      } else {
        // Face detected ✅
        setState(() {
          _faceDetected = true;
          _capturedImage = imageFile;
        });

        // Pass captured image to parent (for backend upload)
      }
    } catch (e) {
      logger.e("Error capturing face: $e");
    } finally {
      setState(() {
        _capturing = false;
      });
    }
  }

  void _submitProfile() async {
    if (_capturedImage == null) {
      DefaultSnackBar.showInfo("Please take a photo to continue.");
      return;
    }

    try {
      setState(() {
        _isSubmitting = true;
      });

      var profileUrl = await CloudinaryUpload.uploadImage(_capturedImage!.path);

      if (profileUrl == null) {
        DefaultSnackBar.showError(
          "Upload failed. Check your internet connection and try again.",
        );
        return;
      }

      var res = await ref
          .read(kycSubmtionProvider.notifier)
          .addProfileUrl(url: profileUrl);

      if (res?.successful == true) {
        DefaultSnackBar.showSuccess(
          res?.message ?? "Profile photo uploaded successfully",
        );
      } else {
        DefaultSnackBar.showError(
          res?.message ?? "We couldn't update your profile. Please try again.",
        );
      }
    } catch (e) {
      logger.e("Profile upload error", error: e);

      DefaultSnackBar.showError(
        "Something unexpected happened. Please try again.",
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: KDevice.getHeight(context) * 0.7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _capturedImage != null
                ? Image.file(_capturedImage!, fit: BoxFit.cover)
                : FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_controller);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
        ),
        const SizedBox(height: 20),
        // DefaultIconButton(icon: Icons.camera)
        Row(
          children: [
            Expanded(
              child: DefaultOutlinedButton(
                isLoading: _capturing,
                width: double.infinity,
                onPressed: _capturing ? null : _captureAndCheckFace,
                text: _capturedImage == null ? "Capture Selfie" : "Retake",
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DefaultButton(
                isLoading: _isSubmitting,
                width: double.infinity,
                onPressed: _faceDetected == false ? null : _submitProfile,
                text: "Submit",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
