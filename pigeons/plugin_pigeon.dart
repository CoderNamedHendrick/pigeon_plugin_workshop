import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeons/plugin_pigeon.dart',
  dartTestOut: 'test/pigeons/plugin_pigeon_test.dart',
  kotlinOut:
      'android/src/main/kotlin/com/hendrick/plugin_workshop/PluginPigeon.g.kt',
  kotlinOptions: KotlinOptions(errorClassName: 'PluginPigeonError'),
  swiftOut: 'ios/Classes/PluginPigeon.g.swift',
  swiftOptions: SwiftOptions(errorClassName: 'PluginPigeonError'),
))
enum ArithmeticOperation { add, subtract, multiply, divide }

@HostApi(dartHostTestHandler: 'TestArithmeticHostApi')
abstract class ArithmeticHostApi {
  double performArithmeticOperation(
      double input1, double input2, ArithmeticOperation operation);

  void startTimer();

  void stopTimer();
}

@FlutterApi()
abstract class ArithmeticFlutterApi {
  void onReceiveTimerResult(int result);
}
