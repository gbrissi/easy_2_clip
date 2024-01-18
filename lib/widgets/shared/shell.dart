import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:easy_2_clip/widgets/shared/title_bar.dart';
import 'package:flutter/material.dart';

class Shell extends StatelessWidget {
  const Shell({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleBar(),
        Expanded(
          child: Scaffold(
            body: child,
          ),
        ),
      ],
    );
  }
}
