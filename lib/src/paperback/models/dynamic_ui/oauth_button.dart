import 'package:dart_pb_extensions_common/src/js/js_promise.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form_row.dart';
import 'package:js/js.dart';

@JS()
class OAuthButton extends FormRowTyped<String?> {
  external String get label;

  external String get authorizeEndpoint;
  external String get clientId;
  external OAuthResponseType get responseType;
  external String? get redirectUri;
  external List<String>? get scopes;

  /// Store this inside the keychain in the state manager
  external Promise<void> Function(String accessToken, String? refreshToken) get successHandler;

  factory OAuthButton({
    required String label,
    required String authorizeEndpoint,
    required String clientId,
    required OAuthResponseType responseType,
    String? redirectUri,
    List<String>? scopes,
    required Future<void> Function(String accessToken, String? refreshToken) successHandler,
  }) =>
      _createOAuthButton(
        _CreateOAuthButtonOptions(
          label: label,
          authorizeEndpoint: authorizeEndpoint,
          clientId: clientId,
          responseType: responseType,
          redirectUri: redirectUri,
          scopes: scopes,
          successHandler: (String accessToken, String? refreshToken) =>
              Promise.of(successHandler(accessToken, refreshToken)),
        ),
      );
}

@JS()
class OAuthResponseType {
  /// type must be one of the following: "code", "pkce", or "token"
  ///
  /// [OAuthResponseTypeEnum] can be used to check this
  external String get type;

  /// Only required for "pkce" and "code" response types
  external String? get tokenEndpoint;

  /// Only required for "pkce" response type
  external num? get pkceCodeLength;
}

enum OAuthResponseTypeEnum {
  code('code'),
  pkce('pkce'),
  token('token');

  final String value;

  const OAuthResponseTypeEnum(this.value);

  @override
  String toString() => value;
}

@JS()
@anonymous
class _CreateOAuthButtonOptions {
  external String get label;
  external String get authorizeEndpoint;
  external String get clientId;
  external OAuthResponseType get responseType;
  external String? get redirectUri;
  external List<String>? get scopes;
  external Promise<void> Function(String accessToken, String? refreshToken) get successHandler;

  external factory _CreateOAuthButtonOptions({
    required String label,
    required String authorizeEndpoint,
    required String clientId,
    required OAuthResponseType responseType,
    String? redirectUri,
    List<String>? scopes,
    required Promise<void> Function(String accessToken, String? refreshToken) successHandler,
  });
}

@JS('createOAuthButton')
external OAuthButton _createOAuthButton(_CreateOAuthButtonOptions info);
