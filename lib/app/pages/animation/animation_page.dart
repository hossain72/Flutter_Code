import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/animated_builder_example.dart';
import 'widgets/animated_container_example.dart';
import 'widgets/animated_cross_fade_example.dart';
import 'widgets/animated_opacity_example.dart';
import 'widgets/animated_positioned_example.dart';
import 'widgets/animation_controller_example.dart';
import 'widgets/hero_animation_example.dart';
import 'widgets/staggered_animation_example.dart';

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
                    child: HeroSourceScreen(),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: StaggeredAnimationExample(),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: AnimatedCrossFadeExample(),
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
