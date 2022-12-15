import 'package:dart_pb_extensions_common/src/js/js.dart';
import 'package:js/js.dart';

@JS()
class TrackedMangaChapterReadAction {
  external String get mangaId;
  external String get sourceMangaId;
  external String get sourceChapterId;
  external String get sourceId;
  external num get chapterNumber;
  external num get volumeNumber;
  external Date get readTime;
}
