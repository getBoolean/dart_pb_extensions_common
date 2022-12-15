import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
// ignore: implementation_imports
import 'package:html/src/utils.dart' show Pair;

class Parser {
  Pair<String, String?> getElementNameTuple(Element e) {
    return parser.getElementNameTuple(e);
  }

  Document parse(
    dynamic input, {
    String? encoding,
    bool generateSpans = false,
    String? sourceUrl,
  }) =>
      parser.parse(
        input,
        encoding: encoding,
        generateSpans: generateSpans,
        sourceUrl: sourceUrl,
      );

  DocumentFragment parseFragment(
    dynamic input, {
    String? encoding,
    bool generateSpans = false,
    String? sourceUrl,
  }) =>
      parser.parseFragment(
        input,
        encoding: encoding,
        generateSpans: generateSpans,
        sourceUrl: sourceUrl,
      );
}
