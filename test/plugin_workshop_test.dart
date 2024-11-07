import 'package:async/async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_workshop/plugin_workshop.dart';

import 'pigeons/plugin_pigeon_test.dart';

class MockPluginWorkshopPlatform implements TestArithmeticHostApi {
  final PluginWorkshop? plugin;

  MockPluginWorkshopPlatform([this.plugin]);

  int result = 0;

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

  @override
  void startTimer() {
    for (int i = 0; i < 3; i++) {
      plugin?.onReceiveTimerResult(result);
      result += 1;
    }
  }

  @override
  void stopTimer() {
    result = 0;

    plugin?.onReceiveTimerResult(result);
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

  test('should return results on timer', () async {
    PluginWorkshop pluginWorkshopPlugin = PluginWorkshop();
    MockPluginWorkshopPlatform fakePlatform =
        MockPluginWorkshopPlatform(pluginWorkshopPlugin);
    TestArithmeticHostApi.setUp(fakePlatform);

    final Stream<int> timerStream = pluginWorkshopPlugin.timerResultStream;
    final streamQueue = StreamQueue(timerStream);

    await pluginWorkshopPlugin.startTimer();

    expect(await streamQueue.next, 0);
    expect(await streamQueue.next, 1);
    expect(await streamQueue.next, 2);

    await pluginWorkshopPlugin.stopTimer();
    expect(fakePlatform.result, 0);
    expect(await streamQueue.next, 0);

    await streamQueue.cancel();
  });
}
