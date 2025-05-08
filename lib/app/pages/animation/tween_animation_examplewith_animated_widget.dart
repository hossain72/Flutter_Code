import 'package:flutter/material.dart';

class RotationTransition extends AnimatedWidget {
  final Widget child;

  const RotationTransition({
    super.key,
    required Animation<double> animation,
    required this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.rotate(angle: animation.value, child: child);
  }
}

class TweenAnimationExample extends StatefulWidget {
  const TweenAnimationExample({super.key});

  @override
  State<TweenAnimationExample> createState() => _TweenAnimationExampleState();
}

class _TweenAnimationExampleState extends State<TweenAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tween Animated example"),
          SizedBox(height: 10),
          RotationTransition(
            animation: _rotationAnimation,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.teal,
              child: Center(
                child: Text('Spin', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_controller.status == AnimationStatus.completed) {
                _controller.reset();
                _controller.forward();
              } else if (_controller.status == AnimationStatus.dismissed) {
                _controller.forward();
              }
            },
            child: Text('Animate Again'),
          ),
        ],
      ),
    );
  }
}
