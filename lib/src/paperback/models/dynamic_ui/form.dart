part of '../../paperback.dart';

@JS()
class Form {
  external Promise<List<Section>> Function() get sections;
  external Promise<void> Function(Object? values) get onSubmit;
  external Promise<bool> Function(Object? values) get validate;
}
