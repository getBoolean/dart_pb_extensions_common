import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class MultilineLabel extends FormRowTyped<String> {
  external String get label;

  factory MultilineLabel({
    required String label,
  }) =>
      _createMultilineLabel(
        _CreateMultilineLabelOptions(
          label: label,
        ),
      );
}

@JS()
@anonymous
class _CreateMultilineLabelOptions {
  external String get label;
  external factory _CreateMultilineLabelOptions({
    required String label,
  });
}

@JS('createMultilineLabel')
external MultilineLabel _createMultilineLabel(
    _CreateMultilineLabelOptions info);
