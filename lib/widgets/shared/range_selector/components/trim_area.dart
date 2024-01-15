import 'package:easy_2_clip/providers/range_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrimArea extends StatefulWidget {
  const TrimArea({super.key});

  @override
  State<TrimArea> createState() => _TrimAreaState();
}

class _TrimAreaState extends State<TrimArea> {
  late final _rangeSelectorController = context.read<RangeSelectorController>();
  late double _trimAreaWidthState;
  double get _trimAreaWidth => _rangeSelectorController.trimAreaWidth;
  final GlobalKey _trimAreaKey = GlobalKey();

  void _updateTrimAreaPos() {
    if (_trimAreaWidthState != _trimAreaWidth && mounted) {
      setState(() {
        _trimAreaWidthState = _trimAreaWidth;
      });
    }
  }

  @override
  void initState() {
    _trimAreaWidthState = _trimAreaWidth;
    _rangeSelectorController.addListener(_updateTrimAreaPos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _rangeSelectorController.leftHandlePos,
      child: Container(
        key: _trimAreaKey,
        width: _trimAreaWidthState,
        height: 40,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
