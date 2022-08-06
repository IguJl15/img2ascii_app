import 'package:flutter/material.dart';

class BodyDiv extends StatelessWidget {
  const BodyDiv({required this.child, this.title, this.color, super.key});

  final Color? color;
  final Widget? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          color: color?? Theme.of(context).dividerColor,
          borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: title
              )
            ] +
            [child],
      ),
    );
  }
}
