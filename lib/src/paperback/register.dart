import 'dart:js';

import 'base/source.dart';
import 'models/source_info.dart';

// Solution to allowing interop with class methods
// https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247

/// Registers a [Source] with the window so that it can be used by the
/// Paperback app.
void Function() registerSource(Source source) {
  return allowInterop(
    () => JsObject.jsify({
      'getChapterDetails': allowInterop(source.service.getChapterDetails),
      'getChapters': allowInterop(source.service.getChapters),
      'getMangaDetails': allowInterop(source.service.getMangaDetails),
      'getSearchResults': allowInterop(source.service.getSearchResults),
      'filterUpdatedManga': allowInterop(source.service.filterUpdatedManga),
      'getCloudflareBypassRequest': allowInterop(source.service.getCloudflareBypassRequest),
      'getHomePageSections': allowInterop(source.service.getHomePageSections),
      'getMangaShareUrl': allowInterop(source.service.getMangaShareUrl),
      'getSearchFields': allowInterop(source.service.getSearchFields),
      'getSearchTags': allowInterop(source.service.getSearchTags),
      'getSourceMenu': allowInterop(source.service.getSourceMenu),
      'getViewMoreItems': allowInterop(source.service.getViewMoreItems),
      'getWebsiteMangaDirectory': allowInterop(source.service.getWebsiteMangaDirectory),
      'supportsSearchOperators': allowInterop(source.service.supportsSearchOperators),
      'supportsTagExclusion': allowInterop(source.service.supportsTagExclusion),
    }),
  );
}

/// Registers a [SourceInfo] with the global [context] so that it can be used by
/// the Paperback app.
void registerSourceInfo(Map<String, SourceInfo> sourceInfo) {
  for (final entry in sourceInfo.entries) {
    context[entry.key] = entry.value.toJsMap();
  }
}
