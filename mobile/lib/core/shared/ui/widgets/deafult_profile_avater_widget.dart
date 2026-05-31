import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';

import '../../../constant/constant.dart';

class DeafultProfileAvaterWidget extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const DeafultProfileAvaterWidget({
    super.key,
    this.imageUrl,
    this.radius = 30,
    this.iconSize = 24,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Colors.transparent,
        child: _buildAvatarContent(),
      ),
    );
  }

  Widget _buildAvatarContent() {
    // If URL is null or empty, show person icon
    if (imageUrl == null || imageUrl!.isEmpty) {
      return HugeIcon(
        icon: HugeIconsStrokeRounded.user,
        size: iconSize,
        color: iconColor ?? KColors.white,
      );
    }

    // Use CachedNetworkImage for network images with error handling
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      child: Center(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              iconColor ?? KColors.primaryDark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      child: Center(
        child: HugeIcon(
          icon: HugeIconsStrokeRounded.user,
          size: iconSize,
          color: iconColor ?? KColors.error,
        ),
      ),
    );
  }
}
