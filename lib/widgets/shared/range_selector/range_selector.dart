import 'package:easy_2_clip/providers/range_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/duration_label.dart';
import 'components/left_handle.dart';
import 'components/right_handle.dart';
import 'components/select_area.dart';
import 'components/trim_area.dart';

class TrimRange {
  final Duration start;
  final Duration end;

  TrimRange({
    required this.start,
    required this.end,
  });
}

class RangeSelector extends StatefulWidget {
  const RangeSelector({
    super.key,
    required this.totalDuration,
    required this.onChanged,
  });
  final Duration totalDuration;
  final void Function(TrimRange range)? onChanged;

  @override
  State<RangeSelector> createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  late final double _selectAreaWidth = 500;
  late final ValueNotifier<Duration> _videoDuration =
      ValueNotifier(widget.totalDuration);

  @override
  void didUpdateWidget(oldWidget) {
    final int curDurationInMilli = widget.totalDuration.inMilliseconds;
    final int oldDurationInMilli = oldWidget.totalDuration.inMilliseconds;
    if (curDurationInMilli != oldDurationInMilli && mounted) {
      _videoDuration.value = Duration(milliseconds: curDurationInMilli);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider(
        create: (_) => RangeSelectorController(
          context: context,
          selectAreaWidth: _selectAreaWidth,
          duration: _videoDuration,
        ),
        child: SizedBox(
          width: _selectAreaWidth,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DurationLabel(),
              SizedBox(
                height: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SelectArea(),
                    TrimArea(),
                    LeftHandle(),
                    RightHandle(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
