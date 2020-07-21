library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutils/flutils.dart';
import 'date_data.dart';

part 'serializers.g.dart';

@SerializersFor([
  DateData,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(
        DateTimeSerializerPlugin(),
      )
      ..addPlugin(
        StandardJsonPlugin(),
      ))
    .build();
