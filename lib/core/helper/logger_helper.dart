import 'package:logger/logger.dart';

class LoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  static void debug(String message, {String? tag}) {
    _logger.d(_formatMessage(tag, message));
  }

  static void info(String message, {String? tag}) {
    _logger.i(_formatMessage(tag, message));
  }

  static void warning(String message, {String? tag}) {
    _logger.w(_formatMessage(tag, message));
  }

  static void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _logger.e(
      _formatMessage(tag, message),
      error: error,
      stackTrace: stackTrace,
    );
  }

  static String _formatMessage(String? tag, String message) {
    return tag != null ? '[$tag] $message' : message;
  }
}

//! Usage Example
  // LoggerHelper.debug('This is a debug message', tag: 'debug');
  // LoggerHelper.info('Application started successfully.', tag: 'info');
  // LoggerHelper.warning('This is a warning message', tag: 'warning');
  // LoggerHelper.error('This is an error message', tag: 'error');
  // LoggerHelper.debug('This is a debug message');
  // LoggerHelper.info('Application started successfully.');
  // LoggerHelper.warning('This is a warning message');
  // LoggerHelper.error('This is an error message');
