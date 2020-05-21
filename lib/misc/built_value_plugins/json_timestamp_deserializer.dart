import 'package:built_value/serializer.dart';

class DateTimeSerializerPlugin implements SerializerPlugin {
  Object beforeSerialize(Object object, FullType specifiedType) {
    return object;
    // if (!(object is DateTime)) return object;
    // return DateTime.parse(object as String).toUtc().microsecondsSinceEpoch;
    // return (object as DateTime).toIso8601String();
  }

  Object afterSerialize(Object object, FullType specifiedType) {
    // if ((specifiedType.root != DateTime)) return object;
    // return DateTime.fromMillisecondsSinceEpoch(object).toIso8601String();
    return object;
  }
  Object beforeDeserialize(Object object, FullType specifiedType) {
    if(specifiedType.root != DateTime) return object;
    if(object is num) {
      return DateTime.fromMicrosecondsSinceEpoch(object).microsecondsSinceEpoch;
    }
    return DateTime.parse(object as String).toUtc().microsecondsSinceEpoch;
  }
  Object afterDeserialize(Object object, FullType specifiedType) => object;
}