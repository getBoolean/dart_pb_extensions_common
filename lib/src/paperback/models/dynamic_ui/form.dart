part of '../../paperback.dart';

@JS()
class Form {
  external Promise<List<Section>> Function() get sections;
  external Promise<void> Function(Object? values) get onSubmit;
  external Promise<bool> Function(Object? values) get validate;

  factory Form({
    required List<Section> Function() sections,
    required void Function(Object? values) onSubmit,
    required bool Function(Object? values) validate,
  }) =>
      _createForm(
        _CreateFormOptions(
          sections: sections,
          onSubmit: onSubmit,
          validate: validate,
        ),
      );
}

@JS()
@anonymous
class _CreateFormOptions {
  external List<Section> Function() get sections;
  external void Function(Object? values) get onSubmit;
  external bool Function(Object? values) get validate;
  external factory _CreateFormOptions({
    required List<Section> Function() sections,
    required void Function(Object? values) onSubmit,
    required bool Function(Object? values) validate,
  });
}

@JS('createForm')
external Form _createForm(_CreateFormOptions info);
