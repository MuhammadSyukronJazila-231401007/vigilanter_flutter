import 'package:flutter/material.dart';
import 'background.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
      ),
    );
  }
}