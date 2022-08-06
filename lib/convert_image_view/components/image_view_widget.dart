import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewImageWidget extends StatelessWidget {
  const ViewImageWidget({required this.image, super.key});

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.width / 3.5,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 2,
                          strokeAlign: StrokeAlign.outside,
                          color: Colors.black45)),
                  child: image,
                  // Image.file(
                  //   file,
                  //   alignment: Alignment.center,
                  //   // width: 220,
                  //   fit: BoxFit.cover,
                  // ),
                );
  }
}