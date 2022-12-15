import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class Switch extends FormRowTyped<bool> {
  external String get label;

  factory Switch({
    required String label,
  }) =>
      _createSwitch(
        _CreateSwitchOptions(
          label: label,
        ),
      );
}

@JS()
@anonymous
class _CreateSwitchOptions {
  external String get label;
  external factory _CreateSwitchOptions({
    required String label,
  });
}

@JS('createSwitch')
external Switch _createSwitch(_CreateSwitchOptions info);
