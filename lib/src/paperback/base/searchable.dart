import 'package:js/js.dart';

import '../../js.dart';
import '../models/paged_results.dart';
import '../models/search_field.dart';
import '../models/search_request.dart';
import '../models/tag_section.dart';
import 'requestable.dart';

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
