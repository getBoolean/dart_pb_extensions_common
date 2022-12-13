import 'package:js/js.dart';

import 'form_row.dart';

@JS()
class WebViewButton extends FormRowTyped<String?> {
  external String get label;

  external void Function() get completionHandler;
}
