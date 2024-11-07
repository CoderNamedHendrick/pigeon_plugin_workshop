import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plugin_workshop/pigeons/plugin_pigeon.dart';

import 'arithmetic_errors.dart';

export 'pigeons/plugin_pigeon.dart' show ArithmeticOperation;

class PluginWorkshop implements ArithmeticFlutterApi {
  final _hostApi = ArithmeticHostApi();

  PluginWorkshop() {
    ArithmeticFlutterApi.setUp(this);
    _timerStreamController = StreamController();
  }

  late StreamController<int> _timerStreamController;

  Stream<int> get timerResultStream => _timerStreamController.stream;

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

  Future<void> startTimer() async {
    try {
      await _hostApi.startTimer();
    } on PlatformException catch (e) {
      throw PluginPigeonException.fromPlatformException(e);
    } on Exception catch (e) {
      throw DefaultPluginPigeonException(message: e.toString());
    }
  }

  Future<void> stopTimer() async {
    try {
      await _hostApi.stopTimer();
    } on PlatformException catch (e) {
      throw PluginPigeonException.fromPlatformException(e);
    } on Exception catch (e) {
      throw DefaultPluginPigeonException(message: e.toString());
    }
  }

  @visibleForTesting
  @protected
  @override
  void onReceiveTimerResult(int result) {
    _timerStreamController.sink.add(result);
  }

  void dispose() {
    _timerStreamController.close();
    ArithmeticFlutterApi.setUp(null);
  }
}
