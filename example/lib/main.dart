import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:plugin_workshop/arithmetic_errors.dart';
import 'package:plugin_workshop/plugin_workshop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pluginWorkshopPlugin = PluginWorkshop();

  ArithmeticOperation? _operation;

  double? result;

  final firstInput = TextEditingController();
  final secondInput = TextEditingController();

  bool loading = false;

  void _toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (result != null) ...[
                      Text('Arithmetic operation result: $result'),
                      const SizedBox(height: 20),
                    ],
                    TextFormField(
                      controller: firstInput,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Enter first number',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Wrap(
                        spacing: 10,
                        children: [
                          ChoiceChip(
                            label: const Text('Add'),
                            labelStyle: const TextStyle(fontSize: 10),
                            selected: _operation == ArithmeticOperation.add,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _operation = ArithmeticOperation.add;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Subtract'),
                            labelStyle: const TextStyle(fontSize: 10),
                            selected:
                                _operation == ArithmeticOperation.subtract,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _operation = ArithmeticOperation.subtract;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Divide'),
                            labelStyle: const TextStyle(fontSize: 10),
                            selected: _operation == ArithmeticOperation.divide,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _operation = ArithmeticOperation.divide;
                                });
                              }
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Multiply'),
                            labelStyle: const TextStyle(fontSize: 10),
                            selected:
                                _operation == ArithmeticOperation.multiply,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  _operation = ArithmeticOperation.multiply;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: secondInput,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Enter second number',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _performOperation(context);
                      },
                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text('Perform Operation'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _performOperation(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (_operation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please select an arithmetic operation'),
        ),
      );
      return;
    }

    final input1 = double.tryParse(firstInput.text) ?? 0;
    final input2 = double.tryParse(secondInput.text) ?? 0;

    try {
      _toggleLoading();
      result = await _pluginWorkshopPlugin.performArithmeticOperation(
        input1,
        input2,
        _operation!,
      );

      setState(() {
        _operation = null;
      });
    } on DivisionByZeroException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Division by zero error: ${e.message}'),
        ),
      );
    } on PluginPigeonException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error: ${e.message}'),
        ),
      );
    } finally {
      _toggleLoading();
    }
  }
}
