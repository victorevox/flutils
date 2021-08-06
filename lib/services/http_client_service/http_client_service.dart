import 'package:auth_http_client/auth_http_client.dart';
import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:http/http.dart' as http;
import 'package:json_http_client/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IHttpClient {
  Future<http.Response> delete(url, {Map<String, String>? headers});

  Future<http.Response> get(url, {Map<String, String>? headers});

  Future<http.Response> head(url, {Map<String, String>? headers});

  Future<http.Response> patch(
    url, {
    Map<String, String>? headers,
    body,
  });

  Future<http.Response> post(
    url, {
    Map<String, String>? headers,
    body,
  });

  Future<http.Response> put(
    url, {
    Map<String, String>? headers,
    body,
  });
}

class HttpClientImpl implements IHttpClient {
  late http.Client client;
  final SharedPreferences? sharedPreferences;
  
  /// Defines a function to get the URL in which a new token can be requested
  /// Defining this property activates the 'refreshToken' mechanism
  final String Function(String token, JWT decodedToken)? refreshTokenUrl;

  /// Defines a custom function to parse the response of your refresh token API, you must return a valid
  /// JWT, so it can replace your current session one
  final String Function(String body)? onParseRefreshTokenResponse;

  /// Defines the 'http' (POST, PUT, etc) method to be used when requesting a new token to the API
  final String refreshTokenMethod;

  /// Defines the JWT age thresshold in which the refresh token logic will trigger
  ///
  /// By default `1 day` is used
  final Duration maxAge;

  /// Every call to any [http.Client] method `post, put, delete, etc` will attempt to trigger the refresh token
  /// if applies, setting a `refreshTokenDebounceTime` will help to prevent excecive calls to the server
  ///
  /// By default `1 second` period time is used
  final Duration refreshTokenDebounceTime;

  /// This Callback is called whenever a refresh token have been successfull retrieved
  final void Function(String token)? onRefreshToken;

  HttpClientImpl({
    required this.client,
    this.sharedPreferences,
    this.refreshTokenUrl,
    this.onParseRefreshTokenResponse,
    required this.refreshTokenMethod,
    required this.maxAge,
    required this.refreshTokenDebounceTime,
    this.onRefreshToken,
  }) {
    this.client = JsonHttpClient(
      client: HttpAuthClient(
        client: http.Client(),
        sharedPreferences: sharedPreferences!,
      ),
    );
  }

  @override
  Future<http.Response> delete(url, {Map<String, String>? headers}) {
    return client.delete(url, headers: headers);
  }

  @override
  Future<http.Response> get(url, {Map<String, String>? headers}) {
    return client.get(url, headers: headers);
  }

  @override
  Future<http.Response> head(url, {Map<String, String>? headers}) {
    return client.head(url, headers: headers);
  }

  @override
  Future<http.Response> patch(url, {Map<String, String>? headers, body}) {
    return client.patch(url, headers: headers, body: body);
  }

  @override
  Future<http.Response> post(url, {Map<String, String>? headers, body}) {
    return client.post(url, headers: headers, body: body);
  }

  @override
  Future<http.Response> put(url, {Map<String, String>? headers, body}) {
    return client.put(url, headers: headers, body: body);
  }
}
