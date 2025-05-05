import 'dart:math';

/// Extension methods to enhance List functionality with common operations.
extension ListExtension<T> on List<T> {
  /// Removes duplicate items based on a custom [selector] function.
  ///
  /// Returns a new list containing only the first occurrence of each unique key.
  ///
  /// Example:
  /// ```dart
  /// final list = ['apple', 'banana', 'apricot'];
  /// final result = list.distinctBy((e) => e[0]); // ['apple', 'banana']
  /// ```
  List<T> distinctBy<R>(R Function(T) selector) {
    final distinctList = <T>[];
    final seenKeys = <R>{};

    for (final item in this) {
      final key = selector(item);
      if (seenKeys.add(key)) {
        distinctList.add(item);
      }
    }

    return distinctList;
  }

  /// Returns the first element that satisfies the [predicate], or `null` if none found.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final result = list.firstWhereOrNull((e) => e > 2); // 3
  /// ```
  T? firstWhereOrNull(bool Function(T) predicate) {
    for (final element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// Groups the list elements into a [Map] based on a [selector] key.
  ///
  /// Example:
  /// ```dart
  /// final list = ['apple', 'banana', 'apricot'];
  /// final grouped = list.groupBy((e) => e[0]); // {a: [apple, apricot], b: [banana]}
  /// ```
  Map<R, List<T>> groupBy<R>(R Function(T) selector) {
    return fold<Map<R, List<T>>>({}, (map, element) {
      final key = selector(element);
      (map[key] ??= []).add(element);
      return map;
    });
  }

  /// Splits the list into two lists: one that matches the [predicate], and one that doesn't.
  ///
  /// Returns a list containing two sublists: `[matched, unmatched]`.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4];
  /// final result = list.partition((e) => e.isEven); // [[2, 4], [1, 3]]
  /// ```
  List<List<T>> partition(bool Function(T) predicate) {
    final matched = <T>[];
    final unmatched = <T>[];

    for (final item in this) {
      (predicate(item) ? matched : unmatched).add(item);
    }

    return [matched, unmatched];
  }

  /// Breaks the list into chunks of the given [size].
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final result = list.chunk(2); // [[1, 2], [3, 4], [5]]
  /// ```
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, min(i + size, length)));
    }
    return chunks;
  }

  /// Returns the element at [index], or `null` if the index is out of range.
  ///
  /// Example:
  /// ```dart
  /// final list = [10, 20];
  /// final value = list.elementAtOrNull(3); // null
  /// ```
  T? elementAtOrNull(int index) {
    return (index >= 0 && index < length) ? this[index] : null;
  }

  /// Returns a shuffled copy of the list without modifying the original list.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final shuffled = list.shuffled(); // e.g. [3, 1, 2]
  /// ```
  List<T> shuffled() {
    final listCopy = List<T>.from(this);
    listCopy.shuffle();
    return listCopy;
  }

  /// Returns `true` if the list is `null` or empty.
  bool get isNullOrEmpty => isEmpty;

  /// Returns `true` if the list is not null and not empty.
  bool get isNotNullOrEmpty => isNotEmpty;
}
