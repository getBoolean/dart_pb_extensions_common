import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class Select extends FormRowTyped<List<String>> {
  external String get label;
  external List<String> get options;

  external bool? get allowsMultiselect;

  /// If multiselect is allowed, specify the minimum number of selected items required
  external num? get minimumOptionCount;

  /// Returns the label for the given option
  external String Function(String option) get displayLabel;

  factory Select({
    required String label,
    required List<String> options,
    bool? allowsMultiselect,
    num? minimumOptionCount,
    required String Function(String option) displayLabel,
  }) =>
      _createSelect(
        _CreateSelectOptions(
          label: label,
          options: options,
          allowsMultiselect: allowsMultiselect,
          minimumOptionCount: minimumOptionCount,
          displayLabel: displayLabel,
        ),
      );
}

@JS()
@anonymous
class _CreateSelectOptions {
  external String get label;
  external List<String> get options;
  external bool? get allowsMultiselect;
  external num? get minimumOptionCount;
  external String Function(String option) get displayLabel;
  external factory _CreateSelectOptions({
    required String label,
    required List<String> options,
    bool? allowsMultiselect,
    num? minimumOptionCount,
    required String Function(String option) displayLabel,
  });
}

@JS('createSelect')
external Select _createSelect(_CreateSelectOptions info);
