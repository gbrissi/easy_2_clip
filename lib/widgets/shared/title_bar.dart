import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Material(
        child: Row(
          children: [
            Expanded(child: MoveWindow()),
            MinimizeWindowButton(
              colors: WindowButtonColors(
                iconNormal: Colors.grey.shade900,
              ),
            ),
            appWindow.isMaximized
                ? RestoreWindowButton(
                    colors: WindowButtonColors(
                      iconNormal: Colors.grey.shade900,
                    ),
                  )
                : MaximizeWindowButton(
                    colors: WindowButtonColors(
                      iconNormal: Colors.grey.shade900,
                    ),
                  ),
            CloseWindowButton(
              colors: WindowButtonColors(
                iconNormal: Colors.grey.shade900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
