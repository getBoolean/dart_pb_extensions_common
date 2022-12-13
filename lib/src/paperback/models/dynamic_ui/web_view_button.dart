part of '../../paperback.dart';

@JS()
class WebViewButton extends FormRowTyped<String?> {
  external String get label;

  external void Function() get completionHandler;
}
