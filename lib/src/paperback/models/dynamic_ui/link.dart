import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class Link extends FormRowTyped<String?> {
  external String get label;

  factory Link({
    required String label,
  }) =>
      _createLink(
        _CreateLinkOptions(
          label: label,
        ),
      );
}

@JS()
@anonymous
class _CreateLinkOptions {
  external String get label;
  external factory _CreateLinkOptions({
    required String label,
  });
}

@JS('createLink')
external Link _createLink(_CreateLinkOptions info);
