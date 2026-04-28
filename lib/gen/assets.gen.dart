// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app_icon.png');

  /// File path: assets/images/app_name.svg
  String get appName => 'assets/images/app_name.svg';

  /// File path: assets/images/empty_books.png
  AssetGenImage get emptyBooks =>
      const AssetGenImage('assets/images/empty_books.png');

  /// File path: assets/images/gift_box.svg
  String get giftBox => 'assets/images/gift_box.svg';

  /// File path: assets/images/notificaiton.svg
  String get notificaiton => 'assets/images/notificaiton.svg';

  /// File path: assets/images/onboarding_1.jpg
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding_1.jpg');

  /// File path: assets/images/onboarding_2.jpg
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding_2.jpg');

  /// File path: assets/images/onboarding_3.jpg
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding_3.jpg');

  /// File path: assets/images/onboarding_4.jpg
  AssetGenImage get onboarding4 =>
      const AssetGenImage('assets/images/onboarding_4.jpg');

  /// File path: assets/images/open_book.svg
  String get openBook => 'assets/images/open_book.svg';

  /// File path: assets/images/rank_1.svg
  String get rank1 => 'assets/images/rank_1.svg';

  /// File path: assets/images/rank_2.svg
  String get rank2 => 'assets/images/rank_2.svg';

  /// File path: assets/images/rank_3.svg
  String get rank3 => 'assets/images/rank_3.svg';

  /// File path: assets/images/spalsh_icon.png
  AssetGenImage get spalshIcon =>
      const AssetGenImage('assets/images/spalsh_icon.png');

  String get menu =>  'assets/images/menu.svg';

  String get settings =>  'assets/images/settings.svg';

  String get power =>  'assets/images/power.svg';

  String get audio =>  'assets/images/audio.svg';

  String get bookmark =>  'assets/images/bookmark.svg';
  String get share =>  'assets/images/share.svg';
  String get message =>  'assets/images/message.svg';

  /// List of all assets
  List<dynamic> get values => [
    appIcon,
    appName,
    emptyBooks,
    giftBox,
    notificaiton,
    onboarding1,
    onboarding2,
    onboarding3,
    onboarding4,
    openBook,
    rank1,
    rank2,
    rank3,
    spalshIcon,
    menu,
    settings,
    power,
    audio,
    bookmark,
    share,
    message,
  ];
}

class $AssetsNavGen {
  const $AssetsNavGen();

  /// File path: assets/nav/nav_contest.svg
  String get navContest => 'assets/nav/nav_contest.svg';

  /// File path: assets/nav/nav_explore.svg
  String get navExplore => 'assets/nav/nav_explore.svg';

  /// File path: assets/nav/nav_home.svg
  String get navHome => 'assets/nav/nav_home.svg';

  /// File path: assets/nav/nav_library.svg
  String get navLibrary => 'assets/nav/nav_library.svg';

  /// File path: assets/nav/nav_read.svg
  String get navRead => 'assets/nav/nav_read.svg';

  /// File path: assets/nav/profile.svg
  String get profile => 'assets/nav/profile.svg';

  /// List of all assets
  List<String> get values => [
    navContest,
    navExplore,
    navHome,
    navLibrary,
    navRead,
    profile,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsNavGen nav = $AssetsNavGen();
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
