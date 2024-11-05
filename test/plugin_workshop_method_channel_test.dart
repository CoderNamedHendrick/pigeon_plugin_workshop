import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_workshop/plugin_workshop_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelPluginWorkshop platform = MethodChannelPluginWorkshop();
  const MethodChannel channel = MethodChannel('plugin_workshop');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'add':
            final Map<String, dynamic> arguments =
                methodCall.arguments.cast<String, dynamic>();
            return arguments['input1'] + arguments['input2'];
          case 'subtract':
            final Map<String, dynamic> arguments =
                methodCall.arguments.cast<String, dynamic>();
            return arguments['input1'] - arguments['input2'];

          case 'multiply':
            final Map<String, dynamic> arguments =
                methodCall.arguments.cast<String, dynamic>();
            return arguments['input1'] * arguments['input2'];

          case 'divide':
            final Map<String, dynamic> arguments =
                methodCall.arguments.cast<String, dynamic>();
            return arguments['input1'] / arguments['input2'];

          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('add', () async {
    expect(await platform.add(5, 10), 15);
  });

  test('subtract', () async {
    expect(await platform.subtract(10, 5), 5);
  });

  test('multiply', () async {
    expect(await platform.multiply(5, 10), 50);
  });

  test('divide', () async {
    expect(await platform.divide(10, 5), 2);
  });
}
