import 'package:app/start.dart';

import 'app_env.dart';

void main() async {
  AppEnv.setupEnv(Flavor.DEV);
  await start();
}
