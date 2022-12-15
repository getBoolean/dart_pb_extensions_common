import 'package:dart_pb_extensions_common/src/js/js.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class Section {
  external String get id;
  external String? get header;
  external String? get footer;
  external Promise<List<FormRow>> Function() get rows;

  factory Section({
    required String id,
    String? header,
    String? footer,
    required Future<List<FormRow>> Function() rows,
  }) =>
      _createSection(
        _CreateSectionOptions(
          id: id,
          header: header,
          footer: footer,
          rows: () => Promise.of(rows()),
        ),
      );
}

@JS()
@anonymous
class _CreateSectionOptions {
  external String get id;
  external String? get header;
  external String? get footer;
  external Promise<List<FormRow>> Function() get rows;

  external factory _CreateSectionOptions({
    required String id,
    String? header,
    String? footer,
    required Promise<List<FormRow>> Function() rows,
  });
}

@JS('createSection')
external Section _createSection(_CreateSectionOptions options);
