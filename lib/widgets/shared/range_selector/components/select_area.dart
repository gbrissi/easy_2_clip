import 'package:easy_2_clip/providers/range_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectArea extends StatefulWidget {
  const SelectArea({
    super.key,
  });

  @override
  State<SelectArea> createState() => _SelectAreaState();
}

class _SelectAreaState extends State<SelectArea> {
  late final _rangeSelectorController = context.read<RangeSelectorController>();
  final GlobalKey _areaKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final areaBox = _areaKey.currentContext!.findRenderObject() as RenderBox;
      final Offset areaOffset = areaBox.localToGlobal(Offset.zero);
      _rangeSelectorController.setOffsetArea(areaOffset);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _areaKey,
      width: double.infinity,
      color: Colors.grey.shade900,
    );
  }
}
