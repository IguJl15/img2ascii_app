import 'package:flutter/material.dart';
import 'package:img2ascii_app/shared/body_div.dart';

class Recents extends StatelessWidget {
  const Recents({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyDiv(
      color: Theme.of(context).dividerColor,
      title: Text(
        "Recents",
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      ),
      child: Wrap(
        children: List<Widget>.generate(
          9, // quantidade itens recentes para teste
          (index) => RecentConvertion(
            text: "${index + 1}",
          ),
        ),
      ),
    );
  }
}

class RecentConvertion extends StatelessWidget {
  const RecentConvertion({
    this.text = "Oba",
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    var size = (MediaQuery.of(context).size.width / 2) - 24;

    return Container(
      margin: const EdgeInsets.all(4),
      width: size,
      height: size,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        // color: Theme.of(context).dialogBackgroundColor,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
