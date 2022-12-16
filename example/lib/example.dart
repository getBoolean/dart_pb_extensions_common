import 'package:dart_pb_extensions_common/paperback.dart';
import 'package:dart_pb_extensions_common/js.dart';

void main() {
  register(
    id: kGuyaId,
    info: guyaInfo,
    creator: () => Guya(),
  );
}

const kGuyaId = 'Guya';
const kGuyaDomain = 'https://guya.cubari.moe';
const kGuyaApiBase = 'https://guya.cubari.moe/api';

SourceInfo guyaInfo = SourceInfo(
  version: '2.0.0',
  name: 'Guya (Dart)',
  icon: 'icon.png',
  author: 'getBoolean',
  authorWebsite: 'https://github.com/getBoolean',
  description: 'Extension that pulls manga from Guya.moe.',
  contentRating: ContentRating.everyone,
  websiteBaseURL: kGuyaDomain,
  language: LanguageCode.english.code,
  sourceTags: [
    SourceTag(
      text: 'Notifications',
      type: TagType.green,
    ),
  ],
);

class Guya extends Source {
  final SourceStateManager stateManager = SourceStateManager();

  @override
  RequestManager get requestManager => RequestManager(
        requestsPerSecond: 5,
        requestTimeout: 10000,
        interceptor: RequestInterceptor(
          interceptRequest: (request) async {
            request.headers = {
              ...(request.headers ?? {}),
              ...{'referer': '$kGuyaDomain/'}
            };

            return request;
          },
          interceptResponse: (response) async => response,
        ),
      );

  @override
  Future<MangaInfo> getMangaDetails(String mangaId) async {
    final request = Request(url: '$kGuyaApiBase/series_page_data/$mangaId', method: 'GET');
    final response = await requestManager.schedule(request, 1);

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
