import 'package:easy_2_clip/extensions/duration_extension.dart';
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
    return duration.stringify();
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
        DurationText(startDuration),
        const Spacer(),
        DurationText(endDuration),
      ],
    );
  }
}

class DurationText extends StatelessWidget {
  const DurationText(
    this.text, {
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(text),
      ),
    );
  }
}
