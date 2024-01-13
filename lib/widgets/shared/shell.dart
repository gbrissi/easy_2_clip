import 'package:flutter/material.dart';

class Shell extends StatelessWidget {
  const Shell({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
