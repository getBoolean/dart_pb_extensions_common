import 'dart:convert';

import 'package:dart_pb_extensions_common/paperback.dart';
import 'package:dart_pb_extensions_common/js.dart';

/// Allows assigning a function to be callable from `window.functionName()`
@JS('Guya')
external set _createGuya(void Function() f);

void main() {
  // Solution to allowing interop with class methods
  // https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247
  _createGuya = allowInterop(() {
    final guya = Guya();
    final _ = jsify({
      'getChapterDetails': allowInterop(guya.getChapterDetails),
      'getChapters': allowInterop(guya.getChapters),
    });
  });
}

const kGuyaDomain = 'https://guya.cubari.moe';
const kGuyaApiBase = 'https://guya.cubari.moe/api';

final SourceInfo guyaInfo = SourceInfo(
  version: '2.0.0',
  name: 'Guya (Dart)',
  icon: 'icon.png',
  author: 'getBoolean',
  authorWebsite: 'https://github.com/getBoolean',
  description: 'Extension that pulls manga from Guya.moe.',
  contentRating: ContentRating.everyone,
  websiteBaseURL: kGuyaDomain,
  sourceTags: [
    SourceTag(
      text: 'Notifications',
      type: TagType.green,
    ),
  ],
);

class GuyaFuture extends Source {
  @override
  RequestManager get requestManager => RequestManager(requestsPerSecond: 5, requestTimeout: 10000);

  @override
  Future<MangaInfo> getMangaDetails(String mangaId) async {
    final request = Request(url: '$kGuyaApiBase/series_page_data/$mangaId', method: 'GET');
    final response = await requestManager.schedule(request, 1).toFuture();

    final responseData = response.data;
    final dynamic data = (responseData is String) ? jsonDecode(responseData) : response.data;
    if (data is! Map<String, Object?>) {
      throw JsError('Invalid response data: $responseData');
    }

    final series = asType<String>(data['series']);
    final altTitles = asType<List>(data['alt_titles']) ?? [];
    final List<String> titles = [series, ...altTitles].removeNull();
    final coverVolUrl = data['cover_vol_url'];
    final metadataElement = asType<Map>(data['metadata']);
    final synopsis = asType<String>(data['synopsis']);

    return MangaInfo(
      id: mangaId,
      titles: titles,
      image: coverVolUrl != null && coverVolUrl is String
          ? kGuyaDomain + coverVolUrl
          : 'https://i.imgur.com/GYUxEX8.png',
      status: MangaStatus.ongoing,
      author: metadataElement?[0]?[1],
      artist: metadataElement?[1]?[1],
      desc: synopsis,
    );
  }

  @override
  Future<List<Chapter>> getChapters(String mangaId) async {
    throw UnimplementedError();
  }

  @override
  Future<ChapterDetails> getChapterDetails(String mangaId, String chapterId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> filterUpdatedMangas(
    void Function(MangaUpdates updates) updates,
    Date time,
    List<String> ids,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<PagedResults> getSearchResults(SearchRequest query, Object? metadata) async {
    throw UnimplementedError();
  }
}

class Guya extends SourcePromise {
  @override
  RequestManager get requestManager => RequestManager(requestsPerSecond: 5, requestTimeout: 10000);

  @override
  String? getMangaShareUrl(String mangaId) => '$kGuyaDomain/read/manga/$mangaId';

  @override
  Promise<MangaInfo> getMangaDetails(String mangaId) {
    final request = Request(url: '$kGuyaApiBase/series_page_data/$mangaId', method: 'GET');
    final mangaInfo = requestManager.schedule(request, 1).toFuture().then((Response response) {
      final responseData = response.data;
      final dynamic data = (responseData is String) ? jsonDecode(responseData) : response.data;
      if (data is! Map<String, Object?>) {
        throw JsError('Invalid response data: $responseData');
      }

      final series = asType<String>(data['series']);
      final altTitles = asType<List>(data['alt_titles']) ?? [];
      final List<String> titles = [series, ...altTitles].removeNull();
      final coverVolUrl = data['cover_vol_url'];
      final metadataElement = asType<Map>(data['metadata']);
      final synopsis = asType<String>(data['synopsis']);

      return MangaInfo(
        id: mangaId,
        titles: titles,
        image: coverVolUrl != null && coverVolUrl is String
            ? kGuyaDomain + coverVolUrl
            : 'https://i.imgur.com/GYUxEX8.png',
        status: MangaStatus.ongoing,
        author: metadataElement?[0]?[1],
        artist: metadataElement?[1]?[1],
        desc: synopsis,
      );
    });

    return mangaInfo.toPromise();
  }

  @override
  Promise<List<Chapter>> getChapters(String mangaId) {
    throw UnimplementedError();
  }

  @override
  Promise<ChapterDetails> getChapterDetails(String mangaId, String chapterId) {
    throw UnimplementedError();
  }

  @override
  Promise<void>? filterUpdatedManga(
      void Function(MangaUpdates updates) updates, Date time, List<String> ids) {
    throw UnimplementedError();
  }

  @override
  Promise<void>? getHomePageSections(void Function(HomeSection section) sectionCallback) {
    throw UnimplementedError();
  }

  @override
  Promise<PagedResults> getSearchResults(SearchRequest query, Object? metadata) {
    throw UnimplementedError();
  }
}

T? asType<T>(Object? value) => value is T ? value : null;

extension ListUtils on List {
  List<V> removeNull<V>() => whereType<V>().toList();
}
