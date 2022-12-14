import 'dart:js';

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
      'getChapterDetails': allowInterop(guya.service.getChapterDetails),
      'getChapters': allowInterop(guya.service.getChapters),
    });
  });

  context['GuyaInfo'] = guyaInfo.toJsMap();
}

const kGuyaDomain = 'https://guya.cubari.moe';
const kGuyaApiBase = 'https://guya.cubari.moe/api';

SourceInfo guyaInfo = SourceInfo(
  version: '2.0.0',
  name: 'Guya (Dart)',
  icon: 'icon.png',
  author: 'getBoolean',
  authorWebsite: 'https://github.com/getBoolean',
  description: 'Extension that pulls manga from Guya.moe.',
  contentRating: ContentRating.everyone.value,
  websiteBaseURL: kGuyaDomain,
  language: LanguageCode.english.code,
  sourceTags: [
    SourceTag(
      text: 'Notifications',
      type: TagType.green.value,
    ),
  ],
);

class Guya extends Source {
  @override
  RequestManager get requestManager => RequestManager(requestsPerSecond: 5, requestTimeout: 10000);

  @override
  Future<MangaInfo> getMangaDetails(String mangaId) async {
    final request = Request(url: '$kGuyaApiBase/series_page_data/$mangaId', method: 'GET');
    final response = await requestManager.schedule(request, 1).toFuture();

    final responseData = response.data;
    final dynamic data = (responseData is String) ? parseJson(responseData) : response.data;
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

T? asType<T>(Object? value) => value is T ? value : null;

extension ListUtils on List {
  List<V> removeNull<V>() => whereType<V>().toList();
}