import 'package:built_value/serializer.dart';

class BuiltForceNumberParsePlugin implements SerializerPlugin {
  Object? beforeSerialize(Object? object, FullType specifiedType) {
    return object;
    // if (!(object is DateTime)) return object;
    // return DateTime.parse(object as String).toUtc().microsecondsSinceEpoch;
    // return (object as DateTime).toIso8601String();
  }

  Object? afterSerialize(Object? object, FullType specifiedType) {
    // if ((specifiedType.root != DateTime)) return object;
    // return DateTime.fromMillisecondsSinceEpoch(object).toIso8601String();
    return object;
  }

  Object? beforeDeserialize(Object? object, FullType specifiedType) {
    if (specifiedType.root != num && specifiedType.root != int &&  specifiedType.root != double) return object;
    if (object is num) {
      return object;
    } else if (object is String) {
      if(specifiedType.root == double) {
        return double.parse(object);
      } else if (specifiedType.root == int) {
        return int.parse(object);
      } else {
        return num.parse(object);
      }
    } else if (object is double) {
      if(specifiedType.root == double) {
        return object;
      } else if (specifiedType.root == int) {
        return object.toDouble();
      } else {
        return object.toDouble();
      }
    } else if (object is int) {
      if(specifiedType.root == double) {
        return object.toInt();
      } else if (specifiedType.root == int) {
        return object;
      } else {
        return object.toInt();
      }
    }
    return object;
  }

  Object? afterDeserialize(Object? object, FullType specifiedType) => object;
}
