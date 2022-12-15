import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class Header extends FormRowTyped<void> {
  external String get title;
  external String get subtitle;
  external String get imageUrl;

  factory Header({
    required String title,
    required String subtitle,
    required String imageUrl,
  }) =>
      _createHeader(
        _CreateHeaderOptions(
          title: title,
          subtitle: subtitle,
          imageUrl: imageUrl,
        ),
      );
}

@JS()
@anonymous
class _CreateHeaderOptions {
  external String get title;
  external String get subtitle;
  external String get imageUrl;
  external factory _CreateHeaderOptions({
    required String title,
    required String subtitle,
    required String imageUrl,
  });
}

@JS('createHeader')
external Header _createHeader(_CreateHeaderOptions info);
