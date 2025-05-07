import 'package:flutter/material.dart';

class AnimatedPositionedExample extends StatefulWidget {
  const AnimatedPositionedExample({super.key});

  @override
  State<AnimatedPositionedExample> createState() =>
      _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool _isPositioned = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Animated Positioned"),
          SizedBox(height: 10),
          SizedBox(
            width: 300,
            height: 150,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  left: _isPositioned ? 20 : 100,
                  top: _isPositioned ? 20 : 100,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isPositioned = !_isPositioned;
                      });
                    },
                    child: Text('Move Me'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
