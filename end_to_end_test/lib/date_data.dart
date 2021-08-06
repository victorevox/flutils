library date_data;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'date_data.g.dart';

abstract class DateData implements Built<DateData, DateDataBuilder> {
  DateTime? get date;
  String? get text;

  DateData._();

  factory DateData([void Function(DateDataBuilder)? updates]) = _$DateData;

  String toJson() {
    return json.encode(serializers.serializeWith(DateData.serializer, this));
  }

  static DateData? fromJson(String jsonString) {
    return serializers.deserializeWith(DateData.serializer, json.decode(jsonString));
  }

  static Serializer<DateData> get serializer => _$dateDataSerializer;
}
