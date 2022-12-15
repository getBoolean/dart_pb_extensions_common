import 'package:js/js.dart';

import '../../../js/js.dart';
import 'form_row.dart';

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
    required Promise<List<FormRow>> Function() rows,
  }) =>
      _createSection(
        _CreateSectionOptions(
          id: id,
          header: header,
          footer: footer,
          rows: rows,
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
