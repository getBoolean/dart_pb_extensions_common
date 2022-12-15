import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class InputField extends FormRowTyped<String> {
  external String get placeholder;
  external String? get label;
  external bool get maskInput;

  factory InputField({
    required String placeholder,
    String? label,
    required bool maskInput,
  }) =>
      _createInputField(
        _CreateInputFieldOptions(
          placeholder: placeholder,
          label: label,
          maskInput: maskInput,
        ),
      );
}

@JS()
@anonymous
class _CreateInputFieldOptions {
  external String get placeholder;
  external String? get label;
  external bool get maskInput;
  external factory _CreateInputFieldOptions({
    required String placeholder,
    String? label,
    required bool maskInput,
  });
}

@JS('createInputField')
external InputField _createInputField(_CreateInputFieldOptions info);
