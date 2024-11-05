import 'package:flutter/services.dart';
import 'package:plugin_workshop/pigeons/plugin_pigeon.dart';

import 'arithmetic_errors.dart';

export 'pigeons/plugin_pigeon.dart' show ArithmeticOperation;

class PluginWorkshop {
  final _hostApi = ArithmeticHostApi();

  Future<double> performArithmeticOperation(
      double input1, double input2, ArithmeticOperation operation) async {
    try {
      return await _hostApi.performArithmeticOperation(
          input1, input2, operation);
    } on PlatformException catch (e) {
      throw PluginPigeonException.fromPlatformException(e);
    } on Exception catch (e) {
      throw DefaultPluginPigeonException(message: e.toString());
    }
  }
}
