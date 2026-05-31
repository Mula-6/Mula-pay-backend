import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/application/state/access_camera_state.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/shared/shared.dart';

class KycFaceRec extends ConsumerStatefulWidget {
  const KycFaceRec({super.key, this.profileUrl});
  final String? profileUrl;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KycFaceRecState();
}

class _KycFaceRecState extends ConsumerState<KycFaceRec> {
  late Future<List<CameraDescription>> _camerasFuture;
  bool _retake = false;

  @override
  void initState() {
    super.initState();
    _camerasFuture = availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            title: Row(
              children: [
                const DefaultAppBarBackButton(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Face Verification",
                        style: const TextStyle().copyWith(letterSpacing: 1.5),
                      ),
                      Text(
                        "Take a selfie to verify your identity",
                        style: KTextStyles.bodyMedium(
                          context,
                        ).copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: KSize.symmetricVertical,
                horizontal: KSize.symmetricHorizontalX,
              ),
              child: ref
                  .watch(accessCameraProvider)
                  .when(
                    data: (state) => _buildCameraStateContent(state),
                    error: (error, stack) =>
                        _buildErrorContent(error.toString()),
                    loading: () => _buildLoadingContent(),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for different camera states
  Widget _buildCameraStateContent(AccessCameraState state) {
    return state.when(
      allowed: () => widget.profileUrl == null
          ? _buildCameraWidget()
          : _retake == false
          ? _buildDisplayPic()
          : _buildCameraWidget(),
      notAllowed: () => _buildPermissionRequiredContent(
        title: "Camera Permission Required",
        message:
            "Camera access is denied. Please grant permission to continue KYC verification.",
        icon: Icons.camera_alt_outlined,
        buttonText: "Grant Permission",
        onPressed: () async {
          await Permission.camera.request();
          ref.invalidate(accessCameraProvider);
        },
      ),
      error: (message) => _buildErrorContent(message),
    );
  }

  Widget _buildDisplayPic() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: KDevice.getHeight(context) * 0.7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: widget.profileUrl!,
              fit: BoxFit.cover,

              // 🔄 While loading
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              // ❌ If error happens
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
        ),

        const SizedBox(height: 20),
        DefaultOutlinedButton(
          onPressed: () {
            setState(() {
              _retake = true;
            });
          },
          width: double.infinity,
          text: "Retake",
        ),
      ],
    );
  }

  // Camera Widget
  Widget _buildCameraWidget() {
    return FutureBuilder<List<CameraDescription>>(
      future: _camerasFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildCameraLoadingContent();
        } else if (snapshot.hasError) {
          return _buildErrorContent("Error loading camera: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildNoCameraContent();
        } else {
          final frontCamera = snapshot.data!.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
            orElse: () => snapshot.data!.first,
          );

          return FaceCaptureWidget(camera: frontCamera);
        }
      },
    );
  }

  // Camera Loading Widget
  Widget _buildCameraLoadingContent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surface,
        // borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Initializing camera...",
              style: KTextStyles.bodyMedium(context),
            ),
          ],
        ),
      ),
    );
  }

  // No Camera Found Widget
  Widget _buildNoCameraContent() {
    return SizedBox(
      height: KDevice.getHeight(context) * 0.8,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.videocam_off_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text("No Camera Found", style: KTextStyles.titleLarge(context)),
            const SizedBox(height: 8),
            Text(
              "We couldn't detect a camera on your device.",
              style: KTextStyles.bodyMedium(context).copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlphaOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            DefaultButton(
              width: double.infinity,
              onPressed: () {
                context.pop();
              },
              text: "Go Back",
            ),
          ],
        ),
      ),
    );
  }

  // Permission Required Widget
  Widget _buildPermissionRequiredContent({
    required String title,
    required String message,
    required IconData icon,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: KDevice.getHeight(context) * 0.8,
      child: Center(
        child: SlideInAnimationWapper(
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.surface.withAlphaOpacity(0.08),
                  colorScheme.surface,
                  colorScheme.surface,
                  colorScheme.secondary,
                ],
                stops: [0.0, 0.3, 1.0, 0.5],
              ),
              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlphaOpacity(0.05),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: colorScheme.primary.withAlphaOpacity(0.05),
                  blurRadius: 20,

                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: KColors.primary.withAlphaOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 60, color: KColors.primary),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: DefaultButton(
                      text: buttonText,
                      onPressed: () async {
                        openAppSettings();
                        ref.invalidate(accessCameraProvider);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  DefaultTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Cancel",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Loading Content Widget
  Widget _buildLoadingContent() {
    return Container(
      height: 400,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Checking camera permission...",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Error Content Widget
  Widget _buildErrorContent(String errorMessage) {
    return SizedBox(
      height: KDevice.getHeight(context) * 0.8,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red.shade400),
            const SizedBox(height: 16),
            Text(
              "Something went wrong",
              style: KTextStyles.titleLarge(context).copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: KColors.textError,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: KTextStyles.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.w600, color: KColors.textError),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DefaultButton(
              width: double.infinity,
              onPressed: () {
                ref.invalidate(accessCameraProvider);
              },
              text: "Retry",
            ),
          ],
        ),
      ),
    );
  }
}

// // Additional Helper Widgets
// class PermissionGuideCard extends StatelessWidget {
//   final String stepNumber;
//   final String title;
//   final String description;
//   final IconData icon;

//   const PermissionGuideCard({
//     super.key,
//     required this.stepNumber,
//     required this.title,
//     required this.description,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     cu
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//               color: primary,
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 stepNumber,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(icon, size: 18, color: primary),
//                     const SizedBox(width: 6),
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
