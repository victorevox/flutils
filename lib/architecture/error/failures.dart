library failures;

import 'package:flutils/architecture/architecture.dart';

abstract class Failure /* implements Built<Failure, FailureBuilder> */ {
  // Fields
  // @nullable
  String get code;
  // @nullable
  String get message;
  // Failure._();

  // factory Failure([void Function(FailureBuilder) updates]) = _$Failure;
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
    if ((e?.statusCode?? 0) >= 400 && (e?.statusCode?? 0) <= 403) {
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

  UnknowFailure({this.message = "Unknown Error"});

  static fromException(dynamic originalException) {
    String message;
    try {
      message = "Unknown Error Occurred";
      if (originalException.notification != null) {
        message = originalException.notification;
      }
      return UnknowFailure(message: message);
    } catch (e) {
      try {
        if (originalException.error != null) {
          message = originalException.error.toString();
        }
        return UnknowFailure(message: message);
      } catch (e) {
        try {
          if (originalException.message != null) {
            message = originalException.message;
          }
          return UnknowFailure(message: message);
        } catch (e) {
          return UnknowFailure();
        }
      }
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
