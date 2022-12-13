part of '../paperback.dart';

@JS()
abstract class Requestable {
  /// Manages the ratelimits and the number of requests that can be done per second
  /// This is also used to fetch pages when a chapter is downloading
  external RequestManager get requestManager;
}
