import 'package:js/js.dart';

import '../../js/js.dart';
import '../models/paged_results.dart';
import '../models/search_field.dart';
import '../models/search_request.dart';
import '../models/tag_section.dart';
import 'requestable.dart';

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

  external Promise<bool> Function()? get supportsTagExclusion;
  external Promise<bool> Function()? get supportsSearchOperators;
}
