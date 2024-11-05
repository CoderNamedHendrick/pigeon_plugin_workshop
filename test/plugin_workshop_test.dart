import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_workshop/plugin_workshop.dart';
import 'package:plugin_workshop/plugin_workshop_platform_interface.dart';
import 'package:plugin_workshop/plugin_workshop_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPluginWorkshopPlatform
    with MockPlatformInterfaceMixin
    implements PluginWorkshopPlatform {
  @override
  Future<double> add(double firstNumber, double secondNumber) =>
      Future.value(firstNumber + secondNumber);

  @override
  Future<double> divide(double firstNumber, double secondNumber) =>
      Future.value(firstNumber / secondNumber);

  @override
  Future<double> multiply(double firstNumber, double secondNumber) =>
      Future.value(firstNumber * secondNumber);

  @override
  Future<double> subtract(double firstNumber, double secondNumber) =>
      Future.value(firstNumber - secondNumber);
}

void main() {
  final PluginWorkshopPlatform initialPlatform =
      PluginWorkshopPlatform.instance;

  test('$MethodChannelPluginWorkshop is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPluginWorkshop>());
  });

  test('getPlatformVersion', () async {
    PluginWorkshop pluginWorkshopPlugin = PluginWorkshop();
    MockPluginWorkshopPlatform fakePlatform = MockPluginWorkshopPlatform();
    PluginWorkshopPlatform.instance = fakePlatform;

    expect(await pluginWorkshopPlugin.add(5, 10), 15);
    expect(await pluginWorkshopPlugin.subtract(10, 5), 5);
    expect(await pluginWorkshopPlugin.multiply(5, 10), 50);
    expect(await pluginWorkshopPlugin.divide(10, 5), 2);
  });
}
