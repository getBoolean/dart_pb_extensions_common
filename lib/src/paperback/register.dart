import 'dart:js';

import 'base/source.dart';
import 'models/source_info.dart';

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

void registerSourceInfo(Map<String, SourceInfo> sourceInfo) {
  for (final entry in sourceInfo.entries) {
    context[entry.key] = entry.value.toJsMap();
  }
}
