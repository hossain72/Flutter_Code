import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation Example")),
      body: Container(
        width: context.width,
        height: context.height,
        color: Colors.white,
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: ListTile(title: Text("Animated Container example")),
            ),
          ],
        ),
      ),
    );
  }
}
