import 'package:auth_http_client/auth_http_client.dart';
import 'package:http/http.dart' as http;
import 'package:json_http_client/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IHttpClient {
  Future<http.Response> delete(url, {Map<String, String> headers});

  Future<http.Response> get(url, {Map<String, String> headers});

  Future<http.Response> head(url, {Map<String, String> headers});

  Future<http.Response> patch(
    url, {
    Map<String, String> headers,
    body,
  });

  Future<http.Response> post(
    url, {
    Map<String, String> headers,
    body,
  });

  Future<http.Response> put(
    url, {
    Map<String, String> headers,
    body,
  });
}

class HttpClientImpl implements IHttpClient {
  http.Client client;
  final SharedPreferences sharedPreferences;

  HttpClientImpl({this.sharedPreferences}) {
    this.client = JsonHttpClient(
      client: HttpAuthClient(
        client: http.Client(),
        sharedPreferences: sharedPreferences,
      ),
    );
  }

  @override
  Future<http.Response> delete(url, {Map<String, String> headers}) {
    return client.delete(url, headers: headers);
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) {
    return client.get(url, headers: headers);
  }

  @override
  Future<http.Response> head(url, {Map<String, String> headers}) {
    return client.head(url, headers: headers);
  }

  @override
  Future<http.Response> patch(url, {Map<String, String> headers, body}) {
    return client.patch(url, headers: headers, body: body);
  }

  @override
  Future<http.Response> post(url, {Map<String, String> headers, body}) {
    return client.post(url, headers: headers, body: body);
  }

  @override
  Future<http.Response> put(url, {Map<String, String> headers, body}) {
    return client.put(url, headers: headers, body: body);
  }
}
