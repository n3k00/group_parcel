import 'package:flutter/material.dart';

class PrimaryAppBar extends AppBar {
  PrimaryAppBar({
    super.key,
    required String title,
    List<Widget> actions = const [],
  }) : super(title: Text(title), actions: actions);
}
