import 'plugin_workshop_platform_interface.dart';

class PluginWorkshop {
  Future<double> add(double firstNumber, double secondNumber) {
    return PluginWorkshopPlatform.instance.add(firstNumber, secondNumber);
  }

  Future<double> subtract(double firstNumber, double secondNumber) {
    return PluginWorkshopPlatform.instance.subtract(firstNumber, secondNumber);
  }

  Future<double> multiply(double firstNumber, double secondNumber) {
    return PluginWorkshopPlatform.instance.multiply(firstNumber, secondNumber);
  }

  Future<double> divide(double firstNumber, double secondNumber) {
    return PluginWorkshopPlatform.instance.divide(firstNumber, secondNumber);
  }
}
