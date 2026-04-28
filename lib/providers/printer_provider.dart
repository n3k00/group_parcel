import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_printer_kit/pos_printer_kit.dart';

import '../core/services/print_service.dart';
import '../core/services/printer_observer_service.dart';
import '../core/services/printer_service.dart';
import '../data/repositories/printer_repository.dart';

final printerCoreProvider = Provider<PrinterCore>((ref) {
  final observer = ref.watch(printerObserverServiceProvider);
  final core = PrinterCore(
    logCallback: defaultPrinterLogWriter() == null
        ? null
        : (message) {
            observer.recordLog(message);
          },
  );
  unawaited(core.initialize());
  ref.onDispose(core.dispose);
  return core;
});

final printerObserverServiceProvider = Provider<PrinterObserverService>((ref) {
  final service = PrinterObserverService(
    logWriter: defaultPrinterLogWriter(),
  );
  ref.onDispose(service.dispose);
  return service;
});

final printServiceProvider = Provider<PrintService>((ref) {
  return const PrintService();
});

final printerServiceProvider = Provider<PrinterService>((ref) {
  return PrinterService(ref.watch(printerCoreProvider));
});

final printerRepositoryProvider = Provider<PrinterRepository>((ref) {
  return PrinterRepository(ref.watch(printerServiceProvider));
});

class PrinterState {
  const PrinterState({
    this.connectionStage = PrinterConnectionStage.idle,
    this.connectionMessage = 'Ready',
    this.printers = const [],
    this.connectedDevice,
    this.isBluetoothOn = false,
    this.isScanning = false,
    this.isBusy = false,
    this.statusText = 'Ready',
    this.errorMessage,
    this.printProgress,
    this.observedConnectionState,
    this.latestError,
    this.debugLogs = const [],
    this.lastPrintableImageBytes,
    this.lastPrintSucceeded = false,
  });

  final PrinterConnectionStage connectionStage;
  final String connectionMessage;
  final List<PrinterDevice> printers;
  final PrinterDevice? connectedDevice;
  final bool isBluetoothOn;
  final bool isScanning;
  final bool isBusy;
  final String statusText;
  final String? errorMessage;
  final PrinterPrintProgress? printProgress;
  final PrinterConnectionState? observedConnectionState;
  final PrinterOperationException? latestError;
  final List<String> debugLogs;
  final Uint8List? lastPrintableImageBytes;
  final bool lastPrintSucceeded;

  bool get isConnected => connectedDevice != null;

  String? get connectedPrinterName => connectedDevice?.name;

  PrinterState copyWith({
    PrinterConnectionStage? connectionStage,
    String? connectionMessage,
    List<PrinterDevice>? printers,
    PrinterDevice? connectedDevice,
    bool clearConnectedDevice = false,
    bool? isBluetoothOn,
    bool? isScanning,
    bool? isBusy,
    String? statusText,
    String? errorMessage,
    bool clearErrorMessage = false,
    PrinterPrintProgress? printProgress,
    bool clearPrintProgress = false,
    PrinterConnectionState? observedConnectionState,
    PrinterOperationException? latestError,
    bool clearLatestError = false,
    List<String>? debugLogs,
    Uint8List? lastPrintableImageBytes,
    bool clearLastPrintableImage = false,
    bool? lastPrintSucceeded,
  }) {
    return PrinterState(
      connectionStage: connectionStage ?? this.connectionStage,
      connectionMessage: connectionMessage ?? this.connectionMessage,
      printers: printers ?? this.printers,
      connectedDevice: clearConnectedDevice
          ? null
          : connectedDevice ?? this.connectedDevice,
      isBluetoothOn: isBluetoothOn ?? this.isBluetoothOn,
      isScanning: isScanning ?? this.isScanning,
      isBusy: isBusy ?? this.isBusy,
      statusText: statusText ?? this.statusText,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      printProgress: clearPrintProgress ? null : printProgress ?? this.printProgress,
      observedConnectionState:
          observedConnectionState ?? this.observedConnectionState,
      latestError: clearLatestError ? null : latestError ?? this.latestError,
      debugLogs: debugLogs ?? this.debugLogs,
      lastPrintableImageBytes: clearLastPrintableImage
          ? null
          : lastPrintableImageBytes ?? this.lastPrintableImageBytes,
      lastPrintSucceeded: lastPrintSucceeded ?? this.lastPrintSucceeded,
    );
  }
}

class PrinterNotifier extends Notifier<PrinterState> {
  late final PrinterCore _core;
  late final PrinterObserverService _observer;

  @override
  PrinterState build() {
    _observer = ref.watch(printerObserverServiceProvider);
    _core = ref.watch(printerCoreProvider);

    void syncCoreState() {
      state = _fromCore(previous: state);
    }

    _observer.attach(
      _core,
      onChanged: syncCoreState,
    );
    _core.addListener(syncCoreState);
    final stateSub = _core.onStateChanged.listen((_) => syncCoreState());
    final progressSub = _core.onPrintProgress.listen((progress) {
      state = _fromCore(
        previous: state,
        printProgress: progress,
      );
    });
    final errorSub = _core.onError.listen((error) {
      state = _fromCore(
        previous: state,
        errorMessage: error.message,
        lastPrintSucceeded: false,
      );
    });

    ref.onDispose(() {
      _core.removeListener(syncCoreState);
      _observer.detach();
      stateSub.cancel();
      progressSub.cancel();
      errorSub.cancel();
    });

    return _fromCore();
  }

  PrinterRepository get _repository => ref.read(printerRepositoryProvider);

  PrinterState _fromCore({
    PrinterState? previous,
    String? errorMessage,
    bool clearErrorMessage = false,
    PrinterPrintProgress? printProgress,
    Uint8List? lastPrintableImageBytes,
    bool? lastPrintSucceeded,
  }) {
    final connected = _core.connectedDevice;
    return PrinterState(
      connectionStage: _core.connectionState.stage,
      connectionMessage: _core.connectionState.message ?? _core.status,
      printers: List<PrinterDevice>.unmodifiable(_core.results),
      connectedDevice: connected,
      isBluetoothOn: _core.isBluetoothOn,
      isScanning: _core.isScanning,
      isBusy: _core.busy,
      statusText: _core.status,
      errorMessage: clearErrorMessage ? null : errorMessage ?? previous?.errorMessage,
      printProgress: printProgress ?? previous?.printProgress,
      observedConnectionState: _observer.snapshot.connectionState,
      latestError: clearErrorMessage
          ? null
          : _observer.snapshot.latestError,
      debugLogs: List<String>.unmodifiable(_observer.snapshot.logs),
      lastPrintableImageBytes:
          lastPrintableImageBytes ?? previous?.lastPrintableImageBytes,
      lastPrintSucceeded: lastPrintSucceeded ?? previous?.lastPrintSucceeded ?? false,
    );
  }

  Future<void> startScan() async {
    await _repository.startScan();
    state = _fromCore(previous: state, clearErrorMessage: true);
  }

  Future<void> disconnect() async {
    await _repository.disconnect();
    state = _fromCore(
      previous: state,
      clearErrorMessage: true,
      lastPrintSucceeded: false,
    );
  }

  Future<bool> printImageBytes(
    Uint8List imageBytes, {
    PrinterPrintConfig? config,
  }) async {
    final printConfig =
        config ?? ref.read(printServiceProvider).defaultVoucherConfig();
    final success = await _repository.printImage(
      imageBytes,
      config: printConfig,
    );
    state = _fromCore(
      previous: state,
      errorMessage: success ? null : _core.lastError?.message,
      clearErrorMessage: success,
      lastPrintableImageBytes: imageBytes,
      lastPrintSucceeded: success,
    );
    return success;
  }

  Future<bool> retryLastPrint() async {
    final bytes = state.lastPrintableImageBytes;
    if (bytes == null) {
      state = state.copyWith(
        errorMessage: 'No previous voucher image available to reprint.',
        lastPrintSucceeded: false,
      );
      return false;
    }

    return printImageBytes(bytes);
  }

  Future<bool> reprintLastVoucher() {
    return retryLastPrint();
  }

  Future<bool> testPrint() async {
    final success = await _repository.testPrint();
    state = _fromCore(
      previous: state,
      errorMessage: success ? null : _core.lastError?.message,
      clearErrorMessage: success,
      lastPrintSucceeded: success,
    );
    return success;
  }

  PrinterState clearError() {
    _core.clearError();
    return state.copyWith(clearErrorMessage: true);
  }
}

final printerStateProvider = NotifierProvider<PrinterNotifier, PrinterState>(
  PrinterNotifier.new,
);
