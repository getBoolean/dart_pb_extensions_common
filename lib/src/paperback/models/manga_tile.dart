import 'package:js/js.dart';

@JS()
class MangaTile {
  external String get id;
  external IconText get title;
  external String get image;
  external IconText? get subtitleText;
  external IconText? get primaryText;
  external IconText? get secondaryText;
  external num? get badge;

  factory MangaTile({
    required String id,
    required IconText title,
    required String image,
    IconText? subtitleText,
    IconText? primaryText,
    IconText? secondaryText,
    num? badge,
  }) =>
      _createMangaTile(_CreateMangaTileOptions(
        id: id,
        title: title,
        image: image,
        subtitleText: subtitleText,
        primaryText: primaryText,
        secondaryText: secondaryText,
        badge: badge,
      ));
}

@JS()
class IconText {
  external String get text;
  external String? get icon;

  factory IconText({
    required String text,
    String? icon,
  }) =>
      _createIconText(_CreateIconTextOptions(
        text: text,
        icon: icon,
      ));
}

@JS()
@anonymous
class _CreateMangaTileOptions {
  external String get id;
  external IconText get title;
  external String get image;
  external IconText? get subtitleText;
  external IconText? get primaryText;
  external IconText? get secondaryText;
  external num? get badge;

  external factory _CreateMangaTileOptions({
    required String id,
    required IconText title,
    required String image,
    IconText? subtitleText,
    IconText? primaryText,
    IconText? secondaryText,
    num? badge,
  });
}

@JS()
@anonymous
class _CreateIconTextOptions {
  external String get text;
  external String? get icon;

  external factory _CreateIconTextOptions({
    required String text,
    String? icon,
  });
}

@JS('createIconText')
external IconText _createIconText(_CreateIconTextOptions options);

@JS('createMangaTile')
external MangaTile _createMangaTile(_CreateMangaTileOptions options);
