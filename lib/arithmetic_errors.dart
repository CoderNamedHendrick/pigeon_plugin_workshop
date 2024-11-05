import 'package:flutter/services.dart';

sealed class PluginPigeonException extends PlatformException {
  PluginPigeonException({
    required super.code,
    super.message,
    super.details,
    super.stacktrace,
  });

  factory PluginPigeonException.fromPlatformException(PlatformException e) {
    return switch (e.code) {
      'DIVISION_BY_ZERO' => DivisionByZeroException(
          message: e.message, details: e.details, stacktrace: e.stacktrace),
      _ => DefaultPluginPigeonException(
          message: e.message,
          details: e.details,
          stacktrace: e.stacktrace,
        ),
    };
  }
}

class DefaultPluginPigeonException extends PluginPigeonException {
  DefaultPluginPigeonException({
    super.message = 'An error occurred',
    super.details,
    super.stacktrace,
  }) : super(code: 'DEFAULT');
}

class DivisionByZeroException extends PluginPigeonException {
  DivisionByZeroException({
    super.message = 'Division by zero',
    super.details,
    super.stacktrace,
  }) : super(code: 'DIVISION_BY_ZERO');
}
