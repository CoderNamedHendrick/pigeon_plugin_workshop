import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'plugin_workshop_platform_interface.dart';

/// An implementation of [PluginWorkshopPlatform] that uses method channels.
class MethodChannelPluginWorkshop extends PluginWorkshopPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('plugin_workshop');

  @override
  Future<double> add(double firstNumber, double secondNumber) async {
    final result = await methodChannel.invokeMethod<double>(
        'add', <String, double>{'input1': firstNumber, 'input2': secondNumber});
    return result ?? 0;
  }

  @override
  Future<double> subtract(double firstNumber, double secondNumber) async {
    final result = await methodChannel.invokeMethod<double>('subtract',
        <String, double>{'input1': firstNumber, 'input2': secondNumber});
    return result ?? 0;
  }

  @override
  Future<double> multiply(double firstNumber, double secondNumber) async {
    final result = await methodChannel.invokeMethod<double>('multiply',
        <String, double>{'input1': firstNumber, 'input2': secondNumber});
    return result ?? 0;
  }

  @override
  Future<double> divide(double firstNumber, double secondNumber) async {
    final result = await methodChannel.invokeMethod<double>('divide',
        <String, double>{'input1': firstNumber, 'input2': secondNumber});
    return result ?? 0;
  }
}
