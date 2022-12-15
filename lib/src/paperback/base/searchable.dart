import 'package:dart_pb_extensions_common/src/js/js.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/requestable.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/paged_results.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/search_field.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/search_request.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/tag_section.dart';
import 'package:js/js.dart';

@JS()
abstract class Searchable extends Requestable {
  @JS()
  external Promise<PagedResults> getSearchResults(
    SearchRequest query,
    Object? metadata,
  );

  @JS()
  external Promise<List<TagSection>>? getSearchTags();

  @JS()
  external Promise<List<SearchField>>? getSearchFields();

  @JS()
  external Promise<bool>? supportsTagExclusion();

  @JS()
  external Promise<bool>? supportsSearchOperators();
}
