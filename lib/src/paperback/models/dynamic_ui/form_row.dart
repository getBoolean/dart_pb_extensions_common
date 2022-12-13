import 'package:js/js.dart';

@JS()
class FormRow {
  external String get id;
  external Object? get value;
}

@JS()
class FormRowTyped<T> extends FormRow {
  @override
  external T get value;
}
