class CacheableItem<T> {
  final bool loading;
  final int? timestamp;
  final bool errored;
  final T? data;

  CacheableItem({
    this.loading = false,
    this.timestamp,
    this.errored = false,
    this.data,
  });
  

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CacheableItem<T> &&
      o.loading == loading &&
      o.timestamp == timestamp &&
      o.errored == errored &&
      o.data == data;
  }

  @override
  int get hashCode {
    return loading.hashCode ^
      timestamp.hashCode ^
      errored.hashCode ^
      data.hashCode;
  }


  CacheableItem<T> copyWith({
    bool? loading,
    int? timestamp,
    bool? errored,
    T? data,
  }) {
    return CacheableItem<T>(
      loading: loading ?? this.loading,
      timestamp: timestamp ?? this.timestamp,
      errored: errored ?? this.errored,
      data: data ?? this.data,
    );
  }
}
