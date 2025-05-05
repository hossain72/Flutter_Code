/// Extension methods for [Iterable] to provide additional utility functions.
extension IterableExtension<T> on Iterable<T> {
  /// Groups elements by a key generated from each element.
  ///
  /// Example:
  /// ```dart
  /// final users = [
  ///   {'name': 'John', 'age': 25},
  ///   {'name': 'Jane', 'age': 25}
  /// ];
  /// final byAge = users.groupBy((user) => user['age']);
  /// // Output: {25: [{'name': 'John', 'age': 25}, {'name': 'Jane', 'age': 25}]}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final result = <K, List<T>>{};
    for (final element in this) {
      final key = keyFunction(element);
      (result[key] ??= []).add(element);
    }
    return result;
  }

  /// Returns distinct elements based on a key function.
  ///
  /// Example:
  /// ```dart
  /// final users = [
  ///   {'id': 1, 'name': 'John'},
  ///   {'id': 1, 'name': 'John Updated'}
  /// ];
  /// final unique = users.distinctBy((user) => user['id']);
  /// // Output: [{'id': 1, 'name': 'John'}]
  /// ```
  Iterable<T> distinctBy<K>(K Function(T) keyFunction) {
    final seen = <K>{};
    return where((element) => seen.add(keyFunction(element)));
  }

  /// Splits iterable into chunks of specified size.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].chunk(2);
  /// // Output: [[1, 2], [3, 4], [5]]
  /// ```
  Iterable<List<T>> chunk(int size) sync* {
    if (size <= 0) throw ArgumentError('Size must be positive');
    var iterator = this.iterator;
    while (iterator.moveNext()) {
      var chunk = [iterator.current];
      for (var i = 1; i < size && iterator.moveNext(); i++) {
        chunk.add(iterator.current);
      }
      yield chunk;
    }
  }

  /// Returns element at index or null if out of bounds.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].elementAtOrNull(5); // Output: null
  /// [1, 2, 3].elementAtOrNull(1); // Output: 2
  /// ```
  T? elementAtOrNull(int index) {
    if (index < 0) return null;
    var i = 0;
    for (final element in this) {
      if (i == index) return element;
      i++;
    }
    return null;
  }

  /// Returns first element matching predicate or null.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].firstWhereOrNull((e) => e > 5); // Output: null
  /// [1, 2, 3].firstWhereOrNull((e) => e > 1); // Output: 2
  /// ```
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Converts iterable to a map with index as key.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'b', 'c'].toIndexMap();
  /// // Output: {0: 'a', 1: 'b', 2: 'c'}
  /// ```
  Map<int, T> toIndexMap() {
    return Map.fromEntries(
      enumerate().map((entry) => MapEntry(entry.$1, entry.$2)),
    );
  }

  /// Returns iterable of (index, value) pairs.
  ///
  /// Example:
  /// ```dart
  /// ['a', 'b'].enumerate();
  /// // Output: [(0, 'a'), (1, 'b')]
  /// ```
  Iterable<(int, T)> enumerate() sync* {
    var index = 0;
    for (final element in this) {
      yield (index++, element);
    }
  }

  /// Returns sum of numeric elements or transformation.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].sum(); // Output: 6
  /// ['a', 'bb', 'ccc'].sum((e) => e.length); // Output: 6
  /// ```
  num sum([num Function(T)? selector]) {
    num result = 0;
    for (final element in this) {
      result += selector?.call(element) ?? (element as num);
    }
    return result;
  }

  /// Returns average of numeric elements or transformation.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].average(); // Output: 2.0
  /// ['a', 'bb', 'ccc'].average((e) => e.length); // Output: 2.0
  /// ```
  double average([num Function(T)? selector]) {
    if (isEmpty) return 0;
    return sum(selector) / length;
  }

  /// Partitions elements into two lists based on predicate.
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final (evens, odds) = numbers.partition((n) => n.isEven);
  /// // evens: [2, 4], odds: [1, 3, 5]
  /// ```
  (List<T>, List<T>) partition(bool Function(T) predicate) {
    final trueList = <T>[];
    final falseList = <T>[];
    for (final element in this) {
      if (predicate(element)) {
        trueList.add(element);
      } else {
        falseList.add(element);
      }
    }
    return (trueList, falseList);
  }

  /// Returns max element based on selector function.
  ///
  /// Example:
  /// ```dart
  /// ['cat', 'elephant', 'dog'].maxBy((s) => s.length); // Output: 'elephant'
  /// ```
  T? maxBy<R extends Comparable>(R Function(T) selector) {
    if (isEmpty) return null;
    return reduce((a, b) => selector(a).compareTo(selector(b)) > 0 ? a : b);
  }

  /// Returns min element based on selector function.
  ///
  /// Example:
  /// ```dart
  /// ['cat', 'elephant', 'dog'].minBy((s) => s.length); // Output: 'cat'
  /// ```
  T? minBy<R extends Comparable>(R Function(T) selector) {
    if (isEmpty) return null;
    return reduce((a, b) => selector(a).compareTo(selector(b)) < 0 ? a : b);
  }

  /// Returns true if all elements are equal.
  ///
  /// Example:
  /// ```dart
  /// [1, 1, 1].allEqual(); // Output: true
  /// [1, 2, 1].allEqual(); // Output: false
  /// ```
  bool allEqual() {
    if (isEmpty) return true;
    final first = elementAt(0);
    return every((element) => element == first);
  }
}
