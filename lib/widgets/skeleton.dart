import 'package:flutter/material.dart';


class Skeleton extends StatelessWidget {
   Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;
   Color primaryColor = Color(0xFF2967FF);
   Color grayColor = Color(0xFF8D8D8E);

  double defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding:  EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
           BorderRadius.all(Radius.circular(defaultPadding))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}