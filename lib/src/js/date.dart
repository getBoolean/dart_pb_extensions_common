part of 'js.dart';

@JS('Date')
class JSDate {
  external factory JSDate([String? date]);
  @JS('Date')
  external factory JSDate.month([String? year, String? monthIndex]);
  @JS('Date')
  external factory JSDate.day([String? year, String? monthIndex, String? day]);
  @JS('Date')
  external factory JSDate.hours([String? year, String? monthIndex, String? day, String? hours]);
  @JS('Date')
  external factory JSDate.minutes([
    String? year,
    String? monthIndex,
    String? day,
    String? hours,
    String? minutes,
  ]);
  @JS('Date')
  external factory JSDate.seconds([
    String? year,
    String? monthIndex,
    String? day,
    String? hours,
    String? minutes,
    String? seconds,
  ]);
  @JS('Date')
  external factory JSDate.milliseconds([
    String? year,
    String? monthIndex,
    String? day,
    String? hours,
    String? minutes,
    String? seconds,
    String? milliseconds,
  ]);

  /// Converts a date to a string following the ISO 8601 Extended Format.
  ///
  /// The `toISOString()` method returns a string in simplified extended
  /// ISO format ([ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)),
  /// which is always 24 or 27 characters long
  /// (`YYYY-MM-DDTHH:mm:ss.sssZ` or `±YYYYYY-MM-DDTHH:mm:ss.sssZ`,
  /// respectively). The timezone is always zero UTC offset, as denoted
  /// by the suffix `Z`.
  external String toISOString();

  /// Converts a date to a string using the UTC timezone.
  ///
  /// The `toUTCString()` method converts a date to a string, interpreting
  /// it in the UTC time zone.
  ///
  /// Based on [rfc7231](https://datatracker.ietf.org/doc/html/rfc7231#section-7.1.1.1)
  /// and modified according to [ECMA-262 toUTCString](https://tc39.es/ecma262/#sec-date.prototype.toutcstring),
  /// it can have negative values.
  external String toUTCString();
}
