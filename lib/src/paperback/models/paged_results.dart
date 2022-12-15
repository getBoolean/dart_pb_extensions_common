import 'package:dart_pb_extensions_common/src/paperback.dart';
import 'package:js/js.dart';

@JS()
class PagedResults {
  external List<MangaTile> get results;
  external Object? get metadata;

  factory PagedResults({
    required List<MangaTile> results,
    Object? metadata,
  }) =>
      _createPagedResults(_CreatePagedResultsOptions(
        results: results,
        metadata: metadata,
      ));
}

@JS()
@anonymous
class _CreatePagedResultsOptions {
  external List<MangaTile> get results;
  external Object? get metadata;

  external factory _CreatePagedResultsOptions({
    required List<MangaTile> results,
    Object? metadata,
  });
}

@JS('createPagedResults')
external PagedResults _createPagedResults(_CreatePagedResultsOptions options);
