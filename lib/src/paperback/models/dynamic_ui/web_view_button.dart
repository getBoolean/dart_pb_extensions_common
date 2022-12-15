import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class WebViewButton extends FormRowTyped<String?> {
  external String get label;

  external void Function() get completionHandler;
}
