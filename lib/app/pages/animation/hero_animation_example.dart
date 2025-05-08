import 'package:flutter/material.dart';

// Hero Animation Example
// Place this in two different screens for transition

// First screen:
class HeroSourceScreen extends StatelessWidget {
  const HeroSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HeroDestinationScreen()),
          );
        },
        child: Hero(
          tag: 'hero-rectangle',
          child: Container(width: 100, height: 50, color: Colors.blue),
        ),
      ),
    );
  }
}

// Second screen:
class HeroDestinationScreen extends StatelessWidget {
  const HeroDestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation')),
      body: Center(
        child: Hero(
          tag: 'hero-rectangle',
          child: Container(width: 300, height: 150, color: Colors.blue),
        ),
      ),
    );
  }
}
