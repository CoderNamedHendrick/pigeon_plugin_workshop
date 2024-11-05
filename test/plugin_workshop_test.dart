import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_workshop/plugin_workshop.dart';

import 'pigeons/plugin_pigeon_test.dart';

class MockPluginWorkshopPlatform implements TestArithmeticHostApi {
  @override
  double performArithmeticOperation(
      double input1, double input2, ArithmeticOperation operation) {
    return switch (operation) {
      ArithmeticOperation.add => input1 + input2,
      ArithmeticOperation.subtract => input1 - input2,
      ArithmeticOperation.multiply => input1 * input2,
      ArithmeticOperation.divide => input1 / input2,
    };
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('perform Arithmetic Operation', () async {
    PluginWorkshop pluginWorkshopPlugin = PluginWorkshop();
    MockPluginWorkshopPlatform fakePlatform = MockPluginWorkshopPlatform();
    TestArithmeticHostApi.setUp(fakePlatform);

    expect(
        await pluginWorkshopPlugin.performArithmeticOperation(
            5, 10, ArithmeticOperation.add),
        15);
    expect(
        await pluginWorkshopPlugin.performArithmeticOperation(
            5, 10, ArithmeticOperation.subtract),
        -5);
    expect(
        await pluginWorkshopPlugin.performArithmeticOperation(
            5, 10, ArithmeticOperation.multiply),
        50);
    expect(
        await pluginWorkshopPlugin.performArithmeticOperation(
            5, 10, ArithmeticOperation.divide),
        0.5);
  });
}
