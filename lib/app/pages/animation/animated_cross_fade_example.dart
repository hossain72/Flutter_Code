import 'package:flutter/material.dart';

class AnimatedCrossFadeExample extends StatefulWidget {
  const AnimatedCrossFadeExample({super.key});

  @override
  State<AnimatedCrossFadeExample> createState() =>
      _AnimatedCrossFadeExampleState();
}

class _AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Animated cross fade example"),
        SizedBox(height: 10),
        AnimatedCrossFade(
          duration: Duration(seconds: 1),
          firstChild: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Center(
                child:
                    Text('First Child', style: TextStyle(color: Colors.white))),
          ),
          secondChild: Container(
            width: 200,
            height: 100,
            color: Colors.red,
            child: Center(
                child: Text('Second Child',
                    style: TextStyle(color: Colors.white))),
          ),
          crossFadeState:
              _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showFirst = !_showFirst;
            });
          },
          child: Text('Switch'),
        ),
      ],
    );
  }
}
