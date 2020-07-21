// GENERATED CODE - DO NOT MODIFY BY HAND

part of date_data;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DateData> _$dateDataSerializer = new _$DateDataSerializer();

class _$DateDataSerializer implements StructuredSerializer<DateData> {
  @override
  final Iterable<Type> types = const [DateData, _$DateData];
  @override
  final String wireName = 'DateData';

  @override
  Iterable<Object> serialize(Serializers serializers, DateData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'date',
      serializers.serialize(object.date,
          specifiedType: const FullType(DateTime)),
      'text',
      serializers.serialize(object.text, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DateData deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DateData extends DateData {
  @override
  final DateTime date;
  @override
  final String text;

  factory _$DateData([void Function(DateDataBuilder) updates]) =>
      (new DateDataBuilder()..update(updates)).build();

  _$DateData._({this.date, this.text}) : super._() {
    if (date == null) {
      throw new BuiltValueNullFieldError('DateData', 'date');
    }
    if (text == null) {
      throw new BuiltValueNullFieldError('DateData', 'text');
    }
  }

  @override
  DateData rebuild(void Function(DateDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DateDataBuilder toBuilder() => new DateDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateData && date == other.date && text == other.text;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, date.hashCode), text.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DateData')
          ..add('date', date)
          ..add('text', text))
        .toString();
  }
}

class DateDataBuilder implements Builder<DateData, DateDataBuilder> {
  _$DateData _$v;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  DateDataBuilder();

  DateDataBuilder get _$this {
    if (_$v != null) {
      _date = _$v.date;
      _text = _$v.text;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DateData;
  }

  @override
  void update(void Function(DateDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DateData build() {
    final _$result = _$v ?? new _$DateData._(date: date, text: text);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
