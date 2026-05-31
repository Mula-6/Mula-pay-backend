// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsGifsGen {
  const $AssetsGifsGen();

  /// File path: assets/gifs/404_gif.gif
  AssetGenImage get a404Gif => const AssetGenImage('assets/gifs/404_gif.gif');

  /// List of all assets
  List<AssetGenImage> get values => [a404Gif];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/pngs
  $AssetsImagesPngsGen get pngs => const $AssetsImagesPngsGen();
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/mulapay--logo-grayscale.png
  AssetGenImage get mulapayLogoGrayscale =>
      const AssetGenImage('assets/logo/mulapay--logo-grayscale.png');

  /// File path: assets/logo/mulapay-high-resolution-logo-grayscale-transparent.png
  AssetGenImage get mulapayHighResolutionLogoGrayscaleTransparent =>
      const AssetGenImage(
        'assets/logo/mulapay-high-resolution-logo-grayscale-transparent.png',
      );

  /// File path: assets/logo/mulapay-logo-transparent.png
  AssetGenImage get mulapayLogoTransparent =>
      const AssetGenImage('assets/logo/mulapay-logo-transparent.png');

  /// File path: assets/logo/mulapay-main-logo.png
  AssetGenImage get mulapayMainLogo =>
      const AssetGenImage('assets/logo/mulapay-main-logo.png');

  /// File path: assets/logo/mulapay-splash.png
  AssetGenImage get mulapaySplash =>
      const AssetGenImage('assets/logo/mulapay-splash.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    mulapayLogoGrayscale,
    mulapayHighResolutionLogoGrayscaleTransparent,
    mulapayLogoTransparent,
    mulapayMainLogo,
    mulapaySplash,
  ];
}

class $AssetsImagesPngsGen {
  const $AssetsImagesPngsGen();

  /// File path: assets/images/pngs/emailVerification.png
  AssetGenImage get emailVerification =>
      const AssetGenImage('assets/images/pngs/emailVerification.png');

  /// File path: assets/images/pngs/googleIcon.png
  AssetGenImage get googleIcon =>
      const AssetGenImage('assets/images/pngs/googleIcon.png');

  /// File path: assets/images/pngs/onboarding1.gif
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/pngs/onboarding1.gif');

  /// File path: assets/images/pngs/onboarding3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/pngs/onboarding3.png');

  /// File path: assets/images/pngs/onboarding4.png
  AssetGenImage get onboarding4 =>
      const AssetGenImage('assets/images/pngs/onboarding4.png');

  /// File path: assets/images/pngs/onboarding5.png
  AssetGenImage get onboarding5 =>
      const AssetGenImage('assets/images/pngs/onboarding5.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    emailVerification,
    googleIcon,
    onboarding1,
    onboarding3,
    onboarding4,
    onboarding5,
  ];
}

class Assets {
  const Assets._();

  static const String aEnv = 'assets/.env';
  static const $AssetsGifsGen gifs = $AssetsGifsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
