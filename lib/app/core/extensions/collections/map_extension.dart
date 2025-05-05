/// An extension on [Map] providing advanced utility methods
extension MapExtension<K, V> on Map<K, V> {
  /// Groups the values in the map by multiple keys using [keySelector].
  ///
  /// Each value can be grouped under multiple keys.
  ///
  /// - [keySelector]: A function that returns a list of keys to group each value by.
  ///
  /// Returns: A new `Map<String, List<V>>` where each key corresponds to a group of values.
  ///
  /// Example:
  /// ```dart
  /// final data = [
  ///   {'name': 'John', 'age': 30, 'city': 'New York'},
  ///   {'name': 'Jane', 'age': 25, 'city': 'London'},
  ///   {'name': 'Bob', 'age': 35, 'city': 'New York'},
  /// ];
  /// final grouped = data.asMap().groupByMultiple((item) => [item['city'], item['age']]);
  ///
  /// print(grouped);
  /// ```
  /// Output:
  /// ```
  /// {
  ///   'New York': [{'name': 'John', 'age': 30, 'city': 'New York'}, {'name': 'Bob', 'age': 35, 'city': 'New York'}],
  ///   '30': [{'name': 'John', 'age': 30, 'city': 'New York'}],
  ///   'London': [{'name': 'Jane', 'age': 25, 'city': 'London'}],
  ///   '25': [{'name': 'Jane', 'age': 25, 'city': 'London'}],
  ///   '35': [{'name': 'Bob', 'age': 35, 'city': 'New York'}]
  /// }
  /// ```
  Map<String, List<V>> groupByMultiple(
    List<dynamic> Function(V value) keySelector,
  ) {
    final result = <String, List<V>>{};
    forEach((_, value) {
      final keys = keySelector(value);
      for (final key in keys) {
        final stringKey = key.toString();
        result.putIfAbsent(stringKey, () => []).add(value);
      }
    });
    return result;
  }

  /// Updates a deeply nested value in the map by walking the given [path] and applying [update].
  ///
  /// - [path]: A list of keys used to reach the nested value.
  /// - [update]: A function that receives the current value and returns a new value.
  ///
  /// Returns: A **new map** with the nested value updated.
  ///
  /// Example:
  /// ```dart
  /// final map = {
  ///   'user': {
  ///     'name': 'John',
  ///     'address': {
  ///       'city': 'New York',
  ///       'state': 'NY',
  ///     },
  ///   }
  /// };
  ///
  /// final updated = map.updateNested(['user', 'address', 'city'], (v) => 'Los Angeles');
  ///
  /// print(updated);
  /// ```
  /// Output:
  /// ```
  /// {
  ///   'user': {
  ///     'name': 'John',
  ///     'address': {
  ///       'city': 'Los Angeles',
  ///       'state': 'NY',
  ///     },
  ///   }
  /// }
  /// ```
  Map<K, V> updateNested(
    List<dynamic> path,
    dynamic Function(dynamic value) update,
  ) {
    final updatedMap = Map<K, V>.from(this);
    dynamic current = updatedMap;

    for (int i = 0; i < path.length - 1; i++) {
      final key = path[i];
      if (current[key] is! Map) {
        current[key] = {};
      }
      current = current[key];
    }

    final lastKey = path.last;
    current[lastKey] = update(current[lastKey]);

    return updatedMap;
  }

  /// Converts this map to a URL query parameter string.
  ///
  /// Returns: A `String` of the format `'key1=value1&key2=value2'`.
  ///
  /// Example:
  /// ```dart
  /// final params = {'name': 'John', 'age': 30};
  /// final query = params.toQueryParams();
  /// print(query);
  /// ```
  /// Output:
  /// ```
  /// name=John&age=30
  /// ```
  String toQueryParams() {
    return entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key.toString())}=${Uri.encodeComponent(entry.value.toString())}',
        )
        .join('&');
  }
}
