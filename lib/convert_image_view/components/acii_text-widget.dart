
import 'dart:async';

import 'package:flutter/material.dart';

class AsciiTextWidget extends StatelessWidget {
  const AsciiTextWidget({required this.stream, super.key});
  // final String art;
  final StreamController<String> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Text(
                "Done: ${snapshot.requireData}",
                softWrap: false,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: "Cascadia Code",
                ),
              );
            case ConnectionState.active:
              return Text(
                snapshot.requireData,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: "Cascadia Code",
                ),
              );
            default:
              return const Text(
                "Nada aqui... ainda",
                softWrap: false,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: "Cascadia Code",
                ),
              );
          }
        });
  }
}
