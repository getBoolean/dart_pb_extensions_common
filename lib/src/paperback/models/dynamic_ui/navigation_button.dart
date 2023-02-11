import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class NavigationButton extends FormRowTyped<String?> {
  external String get label;
  external Form get form;

  factory NavigationButton({
    required String label,
    required Form form,
  }) =>
      _createNavigationButton(
        _CreateNavigationButtonOptions(
          label: label,
          form: form,
        ),
      );
}

@JS()
@anonymous
class _CreateNavigationButtonOptions {
  external String get label;
  external Form get form;
  external factory _CreateNavigationButtonOptions({
    required String label,
    required Form form,
  });
}

@JS('createNavigationButton')
external NavigationButton _createNavigationButton(
    _CreateNavigationButtonOptions info);
