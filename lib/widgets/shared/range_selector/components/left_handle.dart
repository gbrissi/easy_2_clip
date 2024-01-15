import 'package:easy_2_clip/providers/range_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'handle.dart';

class LeftHandle extends StatefulWidget {
  const LeftHandle({super.key});

  @override
  State<LeftHandle> createState() => _LeftHandleState();
}

class _LeftHandleState extends State<LeftHandle> {
  late final _rangeSelectorController = context.read<RangeSelectorController>();
  double get _leftPos => _rangeSelectorController.leftHandlePos;
  late double _leftPosState;

  void _updatePos() {
    if (_leftPosState != _leftPos && mounted) {
      setState(() {
        _leftPosState = _leftPos;
      });
    }
  }

  @override
  void initState() {
    _leftPosState = _leftPos;
    _rangeSelectorController.addListener(_updatePos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Handle(
      leftPos: _leftPos,
      direction: Direction.left,
      onChanged: _rangeSelectorController.setLeftHandlePos,
    );
  }
}
