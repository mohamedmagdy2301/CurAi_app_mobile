import 'package:logger/logger.dart';

class LoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true),
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
    return tag != null ? '\x1B[36m[$tag]\x1B[0m $message' : message;
  }
}

//! Usage Example
// LoggerHelper.debug('Debug message', tag: 'DEBUG');
// LoggerHelper.info('App started successfully.', tag: 'INFO');
// LoggerHelper.warning('Warning occurred!', tag: 'WARNING');
// LoggerHelper.error('An error happened!', tag: 'ERROR');
