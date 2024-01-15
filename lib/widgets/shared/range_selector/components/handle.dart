import 'package:easy_2_clip/providers/range_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Direction {
  left,
  right,
}

class Handle extends StatefulWidget {
  const Handle({
    super.key,
    required this.onChanged,
    required this.direction,
    required this.leftPos,
  });
  final double leftPos;
  final Direction direction;
  final void Function(
    double verticalPosition,
  ) onChanged;

  @override
  State<Handle> createState() => _HandleState();
}

class _HandleState extends State<Handle> {
  late final rangeController = context.read<RangeSelectorController>();
  // IconData get rightIcon => Icons.chevron_right;
  // IconData get leftIcon => Icons.chevron_left;
  // IconData get icon =>
  //     widget.direction == Direction.left ? leftIcon : rightIcon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.leftPos,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onPanUpdate: (details) => widget.onChanged(details.globalPosition.dx),
          child: Container(
            width: rangeController.handleWidth,
            height: 40,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
