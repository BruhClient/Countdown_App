import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  final int forwardDuration;
  final int endDuration;

  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.left,
    this.forwardDuration = 300,
    this.endDuration = 300,
    RouteSettings? settings,
  }) : super(
            transitionDuration: Duration(milliseconds: forwardDuration),
            reverseTransitionDuration: Duration(milliseconds: endDuration),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.left:
        return const Offset(-1, 0);
      case AxisDirection.right:
        return const Offset(1, 0);
    }
  }
}
