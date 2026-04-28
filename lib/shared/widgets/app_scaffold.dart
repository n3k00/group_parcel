import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
    this.drawer,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.isBlocking = false,
    this.blockingOverlay,
    this.leading,
    this.canPop = true,
    this.onBackNavigation,
  });

  final String title;
  final Widget body;
  final List<Widget> actions;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final bool isBlocking;
  final Widget? blockingOverlay;
  final Widget? leading;
  final bool canPop;
  final VoidCallback? onBackNavigation;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      drawer: drawer,
      appBar: AppBar(
        automaticallyImplyLeading: !isBlocking,
        leading: leading,
        title: Text(title),
        actions: isBlocking ? const [] : actions,
        backgroundColor: appBarBackgroundColor,
        foregroundColor: appBarForegroundColor,
      ),
      body: body,
      floatingActionButton: isBlocking ? null : floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );

    return PopScope(
      canPop: !isBlocking && canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !isBlocking && onBackNavigation != null) {
          onBackNavigation!();
        }
      },
      child: Stack(
        children: [
          scaffold,
          if (isBlocking)
            Positioned.fill(
              child:
                  blockingOverlay ??
                  ColoredBox(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
            ),
        ],
      ),
    );
  }
}
