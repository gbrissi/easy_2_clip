import 'package:easy_2_clip/providers/range_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DurationLabel extends StatefulWidget {
  const DurationLabel({super.key});

  @override
  State<DurationLabel> createState() => _DurationLabelState();
}

class _DurationLabelState extends State<DurationLabel> {
  late final _rangeController = context.read<RangeSelectorController>();
  String get startDuration => _getTextDuration(Duration.zero);
  late String endDuration;

  String _getTextDuration(Duration duration) {
    return duration.toString();
  }

  @override
  void initState() {
    endDuration = _getTextDuration(_rangeController.duration);
    _rangeController.durationStream.addListener(() {
      if (mounted) {
        setState(() {
          endDuration = _getTextDuration(_rangeController.duration);
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(startDuration),
        const Spacer(),
        Text(endDuration),
      ],
    );
  }
}
