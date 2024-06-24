import 'package:flutter/material.dart';

class BackgroundContainerWidget extends StatefulWidget {
  final Widget child;
  const BackgroundContainerWidget({required this.child, Key? key})
      : super(key: key);

  @override
  _BackgroundContainerWidgetState createState() =>
      _BackgroundContainerWidgetState();
}

class _BackgroundContainerWidgetState extends State<BackgroundContainerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _animation = _controller.drive(Tween(begin: 0.0, end: 1.0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xFFD0EBE1),
                Color(0xFFFDFFC2),
                Color(0xFFFFB0E3),
                Color(0xFF94FFD8),
                Color(0xFFFF847C),
              ],
              stops: const [0.0, 0.2, 0.4, 0.6, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror,
              transform: GradientRotation(_animation.value *
                  2 *
                  3.141592653589793),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
