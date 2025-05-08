import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';
import 'package:flutter_code/app/pages/animation/animated_builder_example.dart';
import 'package:flutter_code/app/pages/animation/animated_positioned_example.dart';
import 'package:flutter_code/app/pages/animation/animation_controller_example.dart';
import 'package:flutter_code/app/pages/animation/tween_animation_examplewith_animated_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'animated_container_example.dart';
import 'animated_opacity_example.dart';

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10.h,
              children: [
                /*InkWell(
                  onTap: () {
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: ListTile(title: Text("Animated Container example")),
                  ),
                ),*/
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainerExample(),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedOpacityExample(),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedPositionedExample(),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimationControllerExample(),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: AnimatedBuilderExample(),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: TweenAnimationExample(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
