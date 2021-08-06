import './../../../../end_to_end_test/lib/date_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final isoDateString = "2020-07-21T17:47:03.005Z";
  final jsonString = """{
    "date":"$isoDateString",
    "text":"some text"
    }""";

  test("decode", () {
    final data = DateData.fromJson(jsonString)!;
    expect(data.date, DateTime.parse(isoDateString));
  });

  test("encode", () {
    final encoded = DateData.fromJson(jsonString)!.toJson();
    expect(encoded.indexOf(isoDateString) >= 0, true);
  });
}
