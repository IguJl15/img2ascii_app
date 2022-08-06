import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {required this.text,
      // required this.imagePath,
      this.centerTitle = true,
      super.key});

  final String text;
  // final String imagePkath;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    // 2
    return SliverAppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: centerTitle,
      expandedHeight: MediaQuery.of(context).size.height / 5,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: centerTitle,
      ),
    );
  }
}
