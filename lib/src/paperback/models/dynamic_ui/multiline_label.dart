part of '../../paperback.dart';

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
external MultilineLabel _createMultilineLabel(_CreateMultilineLabelOptions info);
