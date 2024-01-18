import 'package:flutter/material.dart';

class RowSeparated extends StatelessWidget {
  const RowSeparated({
    super.key,
    required this.spacing,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });
  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _getSeparatedChildren(
        spacing,
        children,
      ),
    );
  }
}

List<Widget> _getSeparatedChildren(
  double spacing,
  List<Widget> children,
) {
  List<Widget> separatedChildren = [];
  for (var i = 0; i < children.length; i++) {
    separatedChildren.add(children[i]);
    if (i < separatedChildren.length) {
      separatedChildren.add(
        SizedBox(
          width: spacing,
        ),
      );
    }
  }

  return separatedChildren;
}
