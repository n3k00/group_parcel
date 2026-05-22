import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/parcel_strings.dart';
import '../../../../core/layout/app_responsive.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../providers/printer_provider.dart';
import '../../../../shared/helpers/printer_connect_navigation.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../sync/presentation/providers/sync_provider.dart';
import '../providers/parcel_form_provider.dart';
import '../widgets/parcel_form_view.dart';
import '../widgets/parcel_next_action_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(parcelFormProvider.notifier).reset();
      unawaited(ref.read(syncProvider.notifier).syncNow());
    });
  }

  @override
  Widget build(BuildContext context) {
    final printerState = ref.watch(printerStateProvider);
    final printerConnected = printerState.isConnected;
    final printerBusy = printerState.isBusy || printerState.isScanning;
    final theme = Theme.of(context);

    return AppScaffold(
      title: ParcelStrings.homeTitle,
      drawer: const AppDrawer(currentRoute: HomeScreen.routeName),
      actions: [
        IconButton(
          key: const Key('home-printer-action'),
          tooltip: 'Printers',
          onPressed: () {
            openPrinterConnectPage(context, ref);
          },
          icon: Icon(
            printerConnected
                ? Icons.bluetooth_connected
                : Icons.bluetooth_disabled,
            color: printerConnected
                ? Colors.green
                : printerBusy
                ? Colors.amber.shade700
                : theme.colorScheme.outline,
          ),
        ),
      ],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const ParcelNextActionButton(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth = constraints.maxWidth >= AppBreakpoints.medium
              ? AppResponsive.centeredContentWidth(
                  context,
                  horizontalPadding: AppSpacing.lg,
                )
              : constraints.maxWidth;

          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: contentWidth,
              child: ListView(
                padding: AppSpacing.screenPadding,
                children: const [ParcelFormView()],
              ),
            ),
          );
        },
      ),
    );
  }
}
