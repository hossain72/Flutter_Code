import 'package:flutter/material.dart';

enum Flavor { DEV, PROD, TEST }

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor, Color color = Colors.blue}) {
    _instance ??= FlavorConfig._internal(flavor, _map[flavor]!, color);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.color);

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isPROD() => _instance?.flavor == Flavor.PROD;

  static bool isDEV() => _instance?.flavor == Flavor.DEV;

  static bool isTEST() => _instance?.flavor == Flavor.TEST;

  static final Map<Flavor, String> _map = {Flavor.PROD: "Prod", Flavor.DEV: "Dev", Flavor.TEST: "Test"};
}
