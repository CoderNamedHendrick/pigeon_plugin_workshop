// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:plugin_workshop/plugin_workshop.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('add test', (tester) async {
    final PluginWorkshop plugin = PluginWorkshop();
    final double result =
        await plugin.performArithmeticOperation(5, 10, ArithmeticOperation.add);
    expect(result, 15);
  });

  testWidgets('subtract test', (tester) async {
    final PluginWorkshop plugin = PluginWorkshop();
    final double result = await plugin.performArithmeticOperation(
        10, 5, ArithmeticOperation.subtract);
    expect(result, 5);
  });

  testWidgets('multiply test', (tester) async {
    final PluginWorkshop plugin = PluginWorkshop();
    final double result = await plugin.performArithmeticOperation(
        5, 10, ArithmeticOperation.multiply);
    expect(result, 50);
  });

  testWidgets('divide test', (tester) async {
    final PluginWorkshop plugin = PluginWorkshop();
    final double result = await plugin.performArithmeticOperation(
        10, 5, ArithmeticOperation.divide);
    expect(result, 2);
  });
}
