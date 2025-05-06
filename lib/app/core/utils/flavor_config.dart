import 'package:flutter/material.dart';

enum Flavor { dev, prod, test }

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

  static bool isPROD() => _instance?.flavor == Flavor.prod;

  static bool isDEV() => _instance?.flavor == Flavor.dev;

  static bool isTEST() => _instance?.flavor == Flavor.test;

  static final Map<Flavor, String> _map = {
    Flavor.prod: "Prod",
    Flavor.dev: "Dev",
    Flavor.test: "Test",
  };
}
