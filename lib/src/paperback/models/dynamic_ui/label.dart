import 'package:js/js.dart';

import 'form_row.dart';

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