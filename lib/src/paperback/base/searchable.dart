part of '../paperback.dart';

@JS()
abstract class Searchable extends Requestable {
  external Promise<PagedResults> Function(
    SearchRequest query,
    Object? metadata,
  ) get getSearchResults;

  external Promise<List<TagSection>> Function()? get getSearchTags;
  external Promise<List<SearchField>> Function()? get getSearchFields;

  external Promise<bool>? Function() get supportsTagExclusion;
  external Promise<bool>? Function() get supportsSearchOperators;
}
