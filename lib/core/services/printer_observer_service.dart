import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pos_printer_kit/pos_printer_kit.dart';

typedef PrinterLogWriter = void Function(String message);

class PrinterObserverSnapshot {
  const PrinterObserverSnapshot({
    required this.connectionState,
    this.printProgress,
    this.latestError,
    this.logs = const [],
  });

  final PrinterConnectionState connectionState;
  final PrinterPrintProgress? printProgress;
  final PrinterOperationException? latestError;
  final List<String> logs;

  PrinterObserverSnapshot copyWith({
    PrinterConnectionState? connectionState,
    PrinterPrintProgress? printProgress,
    bool clearPrintProgress = false,
    PrinterOperationException? latestError,
    bool clearLatestError = false,
    List<String>? logs,
  }) {
    return PrinterObserverSnapshot(
      connectionState: connectionState ?? this.connectionState,
      printProgress:
          clearPrintProgress ? null : printProgress ?? this.printProgress,
      latestError: clearLatestError ? null : latestError ?? this.latestError,
      logs: logs ?? this.logs,
    );
  }
}

class PrinterObserverService {
  PrinterObserverService({
    PrinterLogWriter? logWriter,
    this.maxLogs = 100,
  }) : _logWriter = logWriter;

  final PrinterLogWriter? _logWriter;
  final int maxLogs;

  StreamSubscription<PrinterConnectionState>? _stateSub;
  StreamSubscription<PrinterPrintProgress>? _progressSub;
  StreamSubscription<PrinterOperationException>? _errorSub;
  VoidCallback? _onChanged;

  PrinterObserverSnapshot _snapshot = const PrinterObserverSnapshot(
    connectionState: PrinterConnectionState(
      stage: PrinterConnectionStage.idle,
      message: 'Ready',
    ),
  );

  PrinterObserverSnapshot get snapshot => _snapshot;

  void attach(
    PrinterCore core, {
    required VoidCallback onChanged,
  }) {
    detach();
    _onChanged = onChanged;

    _snapshot = _snapshot.copyWith(
      connectionState: core.connectionState,
      clearLatestError: true,
      clearPrintProgress: true,
    );

    _stateSub = core.onStateChanged.listen((value) {
      _snapshot = _snapshot.copyWith(connectionState: value);
      _onChanged?.call();
    });

    _progressSub = core.onPrintProgress.listen((value) {
      _snapshot = _snapshot.copyWith(printProgress: value);
      _onChanged?.call();
    });

    _errorSub = core.onError.listen((value) {
      _snapshot = _snapshot.copyWith(latestError: value);
      _onChanged?.call();
    });
  }

  void recordLog(String message) {
    final nextLogs = <String>[
      ..._snapshot.logs,
      message,
    ];
    if (nextLogs.length > maxLogs) {
      nextLogs.removeRange(0, nextLogs.length - maxLogs);
    }
    _snapshot = _snapshot.copyWith(logs: nextLogs);
    _logWriter?.call(message);
    _onChanged?.call();
  }

  void detach() {
    _stateSub?.cancel();
    _progressSub?.cancel();
    _errorSub?.cancel();
    _stateSub = null;
    _progressSub = null;
    _errorSub = null;
    _onChanged = null;
  }

  void dispose() {
    detach();
  }
}

PrinterLogWriter? defaultPrinterLogWriter() {
  if (!kDebugMode) {
    return null;
  }

  return (message) {
    debugPrint('[pos_printer_kit] $message');
  };
}
