import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

typedef LogFunction = void Function(
  Object? message,
  String tag,
  StackTrace stackTrace, {
  bool? isError,
  Level? level,
});

typedef Supplier<T> = FutureOr<T> Function();

/// A runtime store for error log events.
/// The main purpose is to collect errors when use choose to contain logs
/// for the feedback feature.
List<LogEvent> get errorLogEvents => _errorLogEvents.toList(growable: false);
final List<LogEvent> _errorLogEvents = [];

class LogUtil {
  const LogUtil._();

  static const String _tag = 'LOG';
  static bool isNativeLogging = false;
  static StreamController<LogEvent>? _controller;

  static StreamSubscription<LogEvent> addLogListener(
    void Function(LogEvent event) onData,
  ) {
    _controller ??= StreamController<LogEvent>.broadcast();
    return _controller!.stream.listen(onData);
  }

  static void i(
    Object? message, {
    String? tag,
    StackTrace? stackTrace,
    int level = 1,
  }) {
    tag =
        tag ?? (kDebugMode ? getStackTraceId(StackTrace.current, level) : _tag);
    _printLog(message, '$tag ❕', stackTrace, level: Level.CONFIG);
  }

  static void d(
    Object? message, {
    String? tag,
    StackTrace? stackTrace,
    int level = 1,
  }) {
    tag =
        tag ?? (kDebugMode ? getStackTraceId(StackTrace.current, level) : _tag);
    _printLog(message, '$tag 📣', stackTrace, level: Level.INFO);
  }

  static void w(
    Object? message, {
    String? tag,
    StackTrace? stackTrace,
    int level = 1,
  }) {
    tag =
        tag ?? (kDebugMode ? getStackTraceId(StackTrace.current, level) : _tag);
    _printLog(message, '$tag ⚠️', stackTrace, level: Level.WARNING);
  }

  static void dd(
    Supplier<Object?> call, {
    String? tag,
    StackTrace? stackTrace,
    int level = 1,
  }) {
    if (kDebugMode) {
      tag = tag ?? getStackTraceId(StackTrace.current, level);
      _printLog(call(), '$tag 👀', stackTrace, level: Level.INFO);
    }
  }

  static String getStackTraceId(StackTrace stackTrace, int level) {
    return stackTrace
        .toString()
        .split('\n')[level]
        .replaceAll(RegExp(r'(#\d+\s+)|(<anonymous closure>)'), '')
        .replaceAll('. (', '.() (');
  }

  static void e(
    Object? message, {
    String? tag,
    StackTrace? stackTrace,
    bool withStackTrace = true,
    int level = 1,
    bool report = true,
  }) {
    tag =
        tag ?? (kDebugMode ? getStackTraceId(StackTrace.current, level) : _tag);
    _printLog(
      message,
      '$tag ❌',
      stackTrace,
      isError: true,
      level: Level.SEVERE,
      withStackTrace: withStackTrace,
      report: report,
    );
  }

  static void json(
    Object? message, {
    String? tag,
    StackTrace? stackTrace,
    int level = 1,
  }) {
    tag =
        tag ?? (kDebugMode ? getStackTraceId(StackTrace.current, level) : _tag);
    _printLog(message, '$tag 💠', stackTrace);
  }

  static void _printLog(
    Object? message,
    String tag,
    StackTrace? stackTrace, {
    bool isError = false,
    Level level = Level.ALL,
    bool withStackTrace = true,
    bool report = false,
  }) {
    final DateTime time = DateTime.now();
    final String timeString = time.toIso8601String();
    final logEvent = LogEvent(timeString, tag, isError, message, stackTrace);

    _controller?.add(logEvent);
    // Handle errors.
    if (isError) {
      _errorLogEvents.add(logEvent);
      // Present errors rather than only log them in DEBUG mode.
      if (kDebugMode) {
        FlutterError.presentError(
          FlutterErrorDetails(
            exception: message ?? 'NULL',
            stack: stackTrace,
            library: tag == _tag ? 'Framework' : tag,
          ),
        );
      } else {
        dev.log(
          '$timeString - An error occurred.',
          time: time,
          name: tag,
          level: level.value,
          error: message,
          stackTrace: stackTrace,
        );
      }
    } else {
      dev.log(
        '$timeString - $message',
        time: time,
        name: tag,
        level: level.value,
        stackTrace: stackTrace ??
            (isError && withStackTrace ? StackTrace.current : null),
      );
    }
    // Produce native platform logs if applicable.
    if (isNativeLogging) {
      final nativeString = StringBuffer();
      if (tag.isNotEmpty) {
        nativeString.write('[$tag] ');
      }
      nativeString.write(message);
      if (stackTrace != null && stackTrace != StackTrace.empty) {
        nativeString.write('\n$stackTrace');
      }
      debugPrint(nativeString.toString());
    }
  }
}

@immutable
class LogEvent {
  const LogEvent(
    this.timeString,
    this.tag,
    this.isError,
    this.message,
    this.stackTrace,
  );

  final String timeString;
  final String tag;
  final bool isError;
  final Object? message;
  final StackTrace? stackTrace;

  @override
  String toString() {
    final sb = StringBuffer('$timeString $tag ');
    if (isError) {
      sb.write('[E] ');
    }
    sb.write(message);
    if (stackTrace != null && stackTrace != StackTrace.empty) {
      sb.write('\n$stackTrace');
    }
    return sb.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! LogEvent) {
      return false;
    }
    return timeString == other.timeString &&
        tag == other.tag &&
        isError == other.isError &&
        message == other.message &&
        stackTrace == other.stackTrace;
  }

  @override
  int get hashCode =>
      Object.hash(timeString, tag, isError, message, stackTrace);
}
