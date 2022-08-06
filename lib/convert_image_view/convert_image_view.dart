import 'dart:async';
import 'dart:io';

import 'package:img2ascii_app/ascii_img_converter.dart';
import 'package:img2ascii_app/shared/body_div.dart';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img_pkg;

import 'components/acii_text-widget.dart';
import 'components/image_view_widget.dart';

class ConvertImageView extends StatelessWidget {
  ConvertImageView(
    this.file, {
    super.key,
  }) {
    imgConverter = AsciiImageConverter();
    originalImage = imgConverter.loadImage(file.path);
    width = (originalImage.width / 5).round();
    height = (width * (originalImage.height / originalImage.width)).round();
  }

  final File file;
  late final AsciiImageConverter imgConverter;
  late final img_pkg.Image originalImage;

  final artStream = StreamController<String>();

  final widthController = StreamController<int>.broadcast();
  final heightController = StreamController<int>.broadcast();
  final invertController = StreamController<bool>.broadcast();
  late int width;
  late int height;
  bool invert = false;

  var art = "";

  void createArt() async {
    final img_pkg.Image redimensionada =
        imgConverter.resizeImage(originalImage, width, height);
    art = imgConverter.fromImgToASCII(redimensionada, invert: invert);
    artStream.sink.add(art);
  }

  @override
  Widget build(BuildContext context) {
    // createArt();

    // artStream.sink.add(art);

    widthController.stream.listen((event) {
      width = event;
    });
    heightController.stream.listen((event) {
      height = event;
    });
    invertController.stream.listen((event) {
      invert = event;
    });

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Setting output",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true),
      body: ListView(
        children: [
          BodyDiv(
            title: Text(
              "Options",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            // color: Colors.teal[100],
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ViewImageWidget(
                    image: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const LinkButton(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StepNumberWidget(
                        streamController: widthController,
                        title: Text("Width",
                            style: Theme.of(context).textTheme.titleSmall),
                        max: originalImage.width,
                        min: 1,
                        step: 2,
                        initValue: width,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      StepNumberWidget(
                        streamController: heightController,
                        title: Text("Height",
                            style: Theme.of(context).textTheme.titleSmall),
                        max: originalImage.height,
                        min: 1,
                        step: 2,
                        initValue: height,
                      ),
                    ],
                  ),
                ]),
                InvertSwtichButton(
                    value: invert,
                    title: const Text("Invert"),
                    subtitle: const Text("Useful for dark backgrounds"),
                    streamController: invertController),
                ElevatedButton(
                    onPressed: () {
                      createArt();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Generate ascii art  ",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.white),
                        ),
                        const Icon(Icons.check)
                      ],
                    ))
              ],
            ),
          ),
          // IconButton(
          //   onPressed: () {

          //   },
          //   icon: const Icon(Icons.replay_circle_filled_rounded),
          // ),
          BodyDiv(
              title: Text(
                "Output",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              child: Container(
                color: Colors.white,
                child: AsciiTextWidget(
                  stream: artStream,
                ),
              ))
        ],
      ),
    );
  }
}

class InvertSwtichButton extends StatefulWidget {
  InvertSwtichButton({
    required this.value,
    required this.streamController,
    this.title,
    this.subtitle,
    super.key,
  });

  final Widget? subtitle;
  final StreamController<bool> streamController;
  final Widget? title;
  bool value;

  @override
  State<InvertSwtichButton> createState() => _InvertSwtichButtonState();
}

class _InvertSwtichButtonState extends State<InvertSwtichButton> {
  @override
  Widget build(BuildContext context) {
    widget.streamController.stream
        .listen((event) => setState(() => widget.value = event));

    return SwitchListTile(
      value: widget.value,
      onChanged: (bool newValue) =>
          setState(() => widget.streamController.sink.add(newValue)),
      title: widget.title,
      subtitle: widget.subtitle,
    );
  }
}

class LinkButton extends StatelessWidget {
  const LinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.turn_right_rounded,
          color: Colors.grey,
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.link)),
        const RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.turn_left_rounded,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class StepNumberWidget extends StatefulWidget {
  StepNumberWidget({
    required this.streamController,
    this.title,
    this.min,
    this.max,
    this.step = 1,
    this.initValue,
    super.key,
  }) {
    if (initValue != null) {
      streamController.sink.add(initValue!);
    }
  }

  final Widget? title;
  final StreamController<int> streamController;

  final int? min;
  final int? max;

  final int step;
  final int? initValue;

  @override
  State<StepNumberWidget> createState() => _StepNumberWidgetState();
}

class _StepNumberWidgetState extends State<StepNumberWidget> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    widget.streamController.stream
        .listen((event) => setState(() => value = event));

    return Container(
      margin: const EdgeInsets.all(4),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        // direction: Axis.vertical,
        children: [
          Container(
            child: widget.title,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  value = value - widget.step;
                  if (widget.min != null) {
                    value = (value < widget.min! ? widget.min : value)!;
                  }
                  widget.streamController.sink.add(value);
                },
                icon: Icon(
                  Icons.remove,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                width: 30,
                child: Text(
                  value.toString(),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                  onPressed: () {
                    value = value + widget.step;
                    if (widget.max != null) {
                      value = (value > widget.max! ? widget.max : value)!;
                    }
                    widget.streamController.sink.add(value);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
