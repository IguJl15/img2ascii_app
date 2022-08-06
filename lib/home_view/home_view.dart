import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:img2ascii_app/shared/body_div.dart';
import 'package:img2ascii_app/shared/app_bar_widget.dart';

import 'components/pick_photo_button.dart';
import 'components/recent_convertion.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _picker = ImagePicker();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        slivers: <Widget>[
          const AppBarWidget(
            // title: Text(
            text: "Convert image to ASCII",
            // textAlign: TextAlign.center,
            // style: Theme.of(context).textTheme.headline2,
            // maxLines: 2,
            // ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                BodyDiv(
                  title: Text(
                    "Pick a image",
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PickPhotoButton(
                        picker: _picker,
                        source: ImageSource.camera,
                        text: "Take photo",
                      ),
                      PickPhotoButton(
                        picker: _picker,
                        source: ImageSource.gallery,
                        text: "Choose from gallery",
                      )
                    ],
                  ),
                ),
                const Recents(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
