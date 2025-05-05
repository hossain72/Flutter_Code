import 'package:flutter/material.dart';
import 'package:flutter_code/app/core/extensions/build_context/build_context_device.dart';

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
              spacing: 20.h,
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
                AnimatedContainerExample(),
                AnimatedOpacityExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
