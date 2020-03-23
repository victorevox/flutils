library failures;

import 'package:flutils/architecture/architecture.dart';

abstract class Failure {
  String get code;
  String get message;
}

class ServerFailure implements Failure {
  @override
  String code;
  @override
  String message;
  int statusCode;

  ServerFailure({
    this.code,
    this.message,
    this.statusCode,
  });

  static ServerFailure fromServerException(ServerException e) {
    if (e.statusCode >= 400 && e.statusCode <= 403) {
      return UnauthorizedServerFailure(
        code: e.code,
        message: e.message,
      );
    }
    return ServerFailure(
      message: e.message,
      code: e.code,
      statusCode: e.statusCode,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ServerFailure &&
        o.code == code &&
        o.message == message &&
        o.statusCode == statusCode;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ statusCode.hashCode;
}

class UnauthorizedServerFailure implements ServerFailure {
  @override
  String code;

  @override
  String message;

  @override
  int statusCode;

  UnauthorizedServerFailure({
    this.code,
    this.message,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UnauthorizedServerFailure &&
        o.code == code &&
        o.message == message &&
        o.statusCode == statusCode;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ statusCode.hashCode;
}

class UnknowFailure implements Failure {
  String get code => "UnknowFailure";

  @override
  String message;

  UnknowFailure({this.message});

  static fromException(dynamic e) {
    try {
      String message = "Unknown Error Occurred";
      if (e.message != null) {
        message = e.message;
      }
      return UnknowFailure(message: message);
    } catch (e) {
      return UnknowFailure();
    }
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UnknowFailure && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
