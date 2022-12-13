import 'package:js/js.dart';

import '../../paperback.dart';

@JS()
class HomeSection {
  /// An internal identifier of this HomeSection
  external String get id;

  /// The title of this section.
  ///
  /// Common examples of HomeSection titles would be 'Latest Manga', 'Updated Manga',
  /// 'Hot Manga', etc.
  external String get title;

  /// Type of the section
  ///
  /// Defaults to [HomeSectionType.singleRowNormal]
  external String? get type;

  /// A list of [MangaTile] objects which should be shown under this section
  external List<MangaTile>? get items;

  /// Should you be able to scroll, and view more manga on this section?
  /// This method, when true, triggers the [Source.getViewMoreRequest] method
  /// when the user tries to scroll further on the HomePage section. This usually means
  /// that it will traverse to another page, and render more information
  @JS('view_more')
  external Object? get viewMore;

  factory HomeSection({
    required String id,
    required String title,
    String type = 'singleRowNormal',
    List<MangaTile>? items,
    Object? viewMore,
  }) =>
      _createHomeSection(
        _CreateHomeSectionOptions(
          id: id,
          title: title,
          type: type,
          items: items,
          viewMore: viewMore,
        ),
      );
}

enum HomeSectionType {
  singleRowNormal("singleRowNormal"),
  singleRowLarge("singleRowLarge"),
  doubleRow("doubleRow"),
  featured("featured");

  final String value;

  const HomeSectionType(this.value);

  @override
  String toString() => value;
}

@JS()
@anonymous
class _CreateHomeSectionOptions {
  external String get id;
  external String get title;
  external String? get type;
  external List<MangaTile>? get items;
  external Object? get viewMore;

  external factory _CreateHomeSectionOptions({
    required String id,
    required String title,
    String? type,
    List<MangaTile>? items,
    Object? viewMore,
  });
}

@JS('createHomeSection')
external HomeSection _createHomeSection(_CreateHomeSectionOptions options);
