import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class Button extends FormRowTyped<String?> {
  external String get label;
  external void Function() get onTap;

  factory Button({
    required String label,
    required void Function() onTap,
  }) =>
      _createButton(
        _CreateButtonOptions(
          label: label,
          onTap: onTap,
        ),
      );
}

@JS()
@anonymous
class _CreateButtonOptions {
  external String get label;
  external void Function() get onTap;
  external factory _CreateButtonOptions({
    required String label,
    required void Function() onTap,
  });
}

@JS('createButton')
external Button _createButton(_CreateButtonOptions info);
