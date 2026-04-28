import 'package:flutter/material.dart';

class SyncStatusCard extends StatelessWidget {
  const SyncStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(child: ListTile(title: Text('Sync status')));
  }
}
