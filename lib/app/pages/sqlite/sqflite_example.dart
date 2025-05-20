import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';

class SqfliteExample extends StatefulWidget {
  const SqfliteExample({super.key});

  @override
  State<SqfliteExample> createState() => _SqfliteExampleState();
}

class _SqfliteExampleState extends State<SqfliteExample> {
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Scaffold(
      appBar: AppBar(title: Text("Sqflite example"),),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
