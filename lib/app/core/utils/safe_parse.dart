import 'package:flutter_code/app/core/utils/app_log.dart';

T? safeParse<T>(dynamic value, String fieldName) {
  try {
    if (value is T) return value;
    if (T == int) return int.tryParse(value.toString()) as T?;
    if (T == double) return double.tryParse(value.toString()) as T?;
    if (T == bool) {
      final v = value.toString().toLowerCase();
      if (v == "true") return true as T;
      if (v == "false") return false as T;
    }
    if (T == String) return value.toString() as T;
    if (T == DateTime) return DateTime.tryParse(value.toString()) as T?;
  } catch (e) {
    AppLog.error("[safeParse] Field $fieldName : $e");
  }
  AppLog.error(
    "[safeParse] Type mismatch in $fieldName: expected $T, git ${value.runtimeType}",
  );
  return null;
}
