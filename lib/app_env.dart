// ignore_for_file: constant_identifier_names

enum Flavor {
  PROD,
  DEV,
  STG,
}

class AppEnv {
  static late BaseConfig config;

  static void setupEnv(Flavor flavor) {
    switch (flavor) {
      case Flavor.DEV:
        config = DevConfig();
        break;
      case Flavor.STG:
        config = StageConfig();
        break;
      case Flavor.PROD:
        config = ProdConfig();
        break;
    }
  }
}

abstract class BaseConfig {
  Flavor get flavor;
  String get serverUrl;
}

// DEV
class DevConfig implements BaseConfig {
  @override
  Flavor get flavor => Flavor.DEV;

  @override
  String get serverUrl => "https://demo-dev.com/api/";
}

// STG
class StageConfig implements BaseConfig {
  @override
  Flavor get flavor => Flavor.STG;

  @override
  String get serverUrl => "https://demo-stage.com/api/";
}

// PROD
class ProdConfig implements BaseConfig {
  @override
  Flavor get flavor => Flavor.PROD;

  @override
  String get serverUrl => "https://demo-prod.com/api/";
}
