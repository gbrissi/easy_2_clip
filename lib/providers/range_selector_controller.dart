import 'package:easy_2_clip/widgets/shared/range_selector/range_selector.dart';
import 'package:flutter/material.dart';

class RangeSelectorController extends ChangeNotifier {
  final double selectAreaWidth;

  final ValueNotifier<Duration> durationStream;
  Duration get duration => durationStream.value;

  final BuildContext context;
  Offset _offsetArea = Offset.zero;

  double get screenWidth => MediaQuery.of(context).size.width;
  double get handleWidth => 5;

  final ValueNotifier<double> _leftHandlePos = ValueNotifier(0);
  final ValueNotifier<double> _rightHandlePos = ValueNotifier(0);

  set leftHandlePos(double position) => _leftHandlePos.value = position;
  set rightHandlePos(double position) => _rightHandlePos.value = position;

  double get leftHandlePos => _leftHandlePos.value;
  double get rightHandlePos => _rightHandlePos.value;

  double get trimAreaWidth => rightHandlePos - leftHandlePos + handleWidth;

  void setOffsetArea(Offset value) => _offsetArea = value;

  Duration _getDurationFromPercentage(
    double percentage,
    Duration totalDuration,
  ) {
    final int durationInMilli = totalDuration.inMilliseconds;
    final int percentageInMilli = ((percentage * durationInMilli) / 100).ceil();
    final Duration newDuration = Duration(milliseconds: percentageInMilli);

    return newDuration;
  }

  double _getTotalWidthPercentage(double curWidth) {
    final double percentage = (curWidth / selectAreaWidth) * 100;
    return percentage;
  }

  Duration _getDurationFromPosition(double position) =>
      _getDurationFromPercentage(
        _getTotalWidthPercentage(position),
        duration,
      );

  void _triggerOnChangedCallback() {
    final Duration start = _getDurationFromPosition(leftHandlePos);
    final Duration end = _getDurationFromPosition(rightHandlePos);
    final TrimRange range = TrimRange(start: start, end: end);

    // TODO: Trigger callback.
  }

  setLeftHandlePos(double position) {
    final double newPosition = position - _offsetArea.dx;
    if (rightHandlePos > newPosition && position >= _offsetArea.dx) {
      leftHandlePos = newPosition;
      notifyListeners();
    }
  }

  setRightHandlePosition(double position) {
    final double newPosition = position - _offsetArea.dx;
    if (leftHandlePos < newPosition &&
        position <= _offsetArea.dx + selectAreaWidth) {
      rightHandlePos = newPosition;
      notifyListeners();
    }
  }

  RangeSelectorController({
    required this.context,
    required this.selectAreaWidth,
    required ValueNotifier<Duration> duration,
  }) : durationStream = duration {
    _leftHandlePos.addListener(_triggerOnChangedCallback);
    _rightHandlePos.addListener(_triggerOnChangedCallback);
  }

  @override
  void dispose() {
    _leftHandlePos.removeListener(_triggerOnChangedCallback);
    _rightHandlePos.removeListener(_triggerOnChangedCallback);
    super.dispose();
  }
}
