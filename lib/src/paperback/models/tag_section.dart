import 'package:js/js.dart';

@JS()
class Tag {
  /// An internal identifier of this tag
  external String get id;

  /// A user-presentable representation of how people read the tag. This
  /// may be the same as [Tag.id]
  external String get label;
}

/// A category of tags
@JS()
class TagSection {
  /// The internal identifier of this tag category
  external String get id;

  /// How the tag category should be rendered to the user
  external String get label;

  /// A list of [Tag] objects which should be rendered under this category
  external List<Tag> get tags;
}

@JS()
@anonymous
class CreateTagOptions {
  external String get id;
  external String get label;

  /// Create a tag
  ///
  /// Arguments:
  /// - [id]: An internal identifier of this tag
  /// - [label]: A user-presentable representation of how people read the tag. This
  /// may be the same as [id]
  external factory CreateTagOptions({required String id, required String label});
}

@JS()
external Tag createTag(CreateTagOptions tag);

@JS()
@anonymous
class CreateTagSectionOptions {
  external String get id;
  external String get label;
  external List<Tag> get tags;

  /// Create a category of tags
  ///
  /// Arguments:
  /// - [id]: The internal identifier of this tag category
  /// - [label]: How the tag category should be rendered to the user
  /// - [tags]: A list of [Tag] objects which should be rendered under this category
  external factory CreateTagSectionOptions({
    required String id,
    required String label,
    required List<Tag> tags,
  });
}

@JS()
external TagSection createTagSection(CreateTagSectionOptions tagSection);
