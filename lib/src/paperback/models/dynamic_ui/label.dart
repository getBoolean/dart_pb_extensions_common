import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class Label extends FormRowTyped<String?> {
  external String get label;

  factory Label({
    required String label,
  }) =>
      _createLabel(
        _CreateLabelOptions(
          label: label,
        ),
      );
}

@JS()
@anonymous
class _CreateLabelOptions {
  external String get label;
  external factory _CreateLabelOptions({
    required String label,
  });
}

@JS('createLabel')
external Label _createLabel(_CreateLabelOptions info);
