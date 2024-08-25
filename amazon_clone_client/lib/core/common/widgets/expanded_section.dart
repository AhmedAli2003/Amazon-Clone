import 'package:flutter/material.dart';

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  final double axisAlignment;
  final Duration duration;
  final Duration reversedDuration;
  final Curve curve;
  final Curve reversedCurve;
  const ExpandedSection({
    super.key,
    required this.child,
    this.expand = false,
    this.axisAlignment = 0.0,
    this.duration = const Duration(milliseconds: 500),
    this.reversedDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.reversedCurve = Curves.easeInOut,
  });

  @override
  State<ExpandedSection> createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reversedDuration,
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: widget.axisAlignment,
      child: widget.child,
    );
  }
}
