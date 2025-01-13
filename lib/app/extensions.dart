// extension on String

import 'package:complete_advanced_flutter/data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    return this ?? empty;
  }
}

// extension on Integer
extension NonNullIn on int? {
  int orZero() {
    return this ?? zero;
  }
}
