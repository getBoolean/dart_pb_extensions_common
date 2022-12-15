import 'package:js/js.dart';

import '../../../js/js.dart';
import 'section.dart';

@JS()
class Form {
  external Promise<List<Section>> Function() get sections;
  external Promise<void> Function(Object? values) get onSubmit;
  external Promise<bool> Function(Object? values) get validate;

  factory Form({
    required Future<List<Section>> Function() sections,
    required Future<void> Function(Object? values) onSubmit,
    required Future<bool> Function(Object? values) validate,
  }) =>
      _createForm(
        _CreateFormOptions(
          sections: () => Promise.of(sections()),
          onSubmit: (Object? values) => Promise.of(onSubmit(values)),
          validate: (Object? values) => Promise.of(validate(values)),
        ),
      );
}

@JS()
@anonymous
class _CreateFormOptions {
  external Promise<List<Section>> Function() get sections;
  external Promise<void> Function(Object? values) get onSubmit;
  external Promise<bool> Function(Object? values) get validate;

  external factory _CreateFormOptions({
    required Promise<List<Section>> Function() sections,
    required Promise<void> Function(Object? values) onSubmit,
    required Promise<bool> Function(Object? values) validate,
  });
}

@JS('createForm')
external Form _createForm(_CreateFormOptions info);
