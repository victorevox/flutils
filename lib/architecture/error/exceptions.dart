import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final String message;
  final String code;
  final int statusCode;

  ServerException({@required this.message, this.code = "ServerException", this.statusCode});

  static ServerException fromResponse(http.Response response) {
    if (!(response is http.Response)) {
      return ServerException(message: "Unknown server exception");
    }
    try {
      final decoded = jsonDecode(response.body);
      final Map<String, dynamic> error = decoded["error"];
      final String message = error["message"];
      final int statusCode = error["statusCode"] ?? response.statusCode;
      return ServerException(
        message: message,
        statusCode: statusCode,
        code: response.reasonPhrase,
      );
    } catch (e) {}
    return ServerException(message: response.body);
  }
}