import 'package:flutter/material.dart';

class RefreshProgressIndicator extends StatefulWidget {
  final Duration duration;
  final void Function()? onComplete;

  const RefreshProgressIndicator({
    super.key,
    required this.duration,
    this.onComplete,
  });

  @override
  State<RefreshProgressIndicator> createState() =>
      _RefreshProgressIndicatorState();
}

class _RefreshProgressIndicatorState extends State<RefreshProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    animationController.addListener(() {
      setState(() {});

      if (animationController.isCompleted) {
        widget.onComplete?.call();

        animationController.reset();
        animationController.forward();
      }
    });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: animationController.value,
    );
  }
}
