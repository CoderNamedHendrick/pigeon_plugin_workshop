import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'plugin_workshop_method_channel.dart';

abstract class PluginWorkshopPlatform extends PlatformInterface {
  /// Constructs a PluginWorkshopPlatform.
  PluginWorkshopPlatform() : super(token: _token);

  static final Object _token = Object();

  static PluginWorkshopPlatform _instance = MethodChannelPluginWorkshop();

  /// The default instance of [PluginWorkshopPlatform] to use.
  ///
  /// Defaults to [MethodChannelPluginWorkshop].
  static PluginWorkshopPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PluginWorkshopPlatform] when
  /// they register themselves.
  static set instance(PluginWorkshopPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<double> add(double firstNumber, double secondNumber) {
    throw UnimplementedError('add() has not been implemented.');
  }

  Future<double> subtract(double firstNumber, double secondNumber) {
    throw UnimplementedError('subtract() has not been implemented.');
  }

  Future<double> multiply(double firstNumber, double secondNumber) {
    throw UnimplementedError('multiply() has not been implemented.');
  }

  Future<double> divide(double firstNumber, double secondNumber) {
    throw UnimplementedError('divide() has not been implemented.');
  }
}
