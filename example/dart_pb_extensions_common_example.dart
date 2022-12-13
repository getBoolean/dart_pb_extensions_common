import 'dart:convert';

import 'package:dart_pb_extensions_common/dart_pb_extensions_common.dart';

import 'utils.dart';

void main() {
  functionName();
}

const kGuyaDomain = 'https://guya.cubari.moe';
const kGuyaApiBase = 'https://guya.cubari.moe/api';

const SourceInfo guyaInfo = SourceInfo(
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

class Guya extends Source {
  const Guya(super.cheerio);

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
      if (data! is Map<String, Object?>) {
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
    final $ = cheerio.load('');
    // TODO: implement getChapters
    throw UnimplementedError();
  }

  @override
  Promise<ChapterDetails> getChapterDetails(String mangaId, String chapterId) {
    // TODO: implement getChapterDetails
    throw UnimplementedError();
  }

  @override
  Promise<void>? filterUpdatedManga(
      void Function(MangaUpdates updates) updates, Date time, List<String> ids) {
    // TODO: implement filterUpdatedManga
    throw UnimplementedError();
  }

  @override
  Promise<void>? getHomePageSections(void Function(HomeSection section) sectionCallback) {
    // TODO: implement getHomePageSections
    throw UnimplementedError();
  }

  @override
  Promise<PagedResults> getSearchResults(SearchRequest query, Object? metadata) {
    // TODO: implement getSearchResults
    throw UnimplementedError();
  }
}
