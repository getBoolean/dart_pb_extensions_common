part of '../paperback.dart';

@JS('Uint8')
external String get uint8;

@JS()
typedef ByteArray = Uint8List;

@JS()
class RawData {
  external List<num> get data;
  external num get length;

  @JS('toString')
  external void Function() get toJsString;

  factory RawData({
    required List<num> data,
    required num length,
  }) =>
      _createRawData(_CreateRawDataOptions(data: data, length: length));
}

extension RawDataToByteArrayExtension on RawData {
  ByteArray toByteArray() => createByteArray(this);
}

@JS()
@anonymous
class _CreateRawDataOptions {
  external List<num> get data;
  external num get length;

  external factory _CreateRawDataOptions({
    required List<num> data,
    required num length,
  });
}

@JS('createRawData')
external RawData _createRawData(_CreateRawDataOptions options);

@JS('createByteArray')
external ByteArray createByteArray(RawData rawData);
