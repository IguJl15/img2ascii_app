import 'dart:io';
import 'package:image/image.dart';

class Pixel {
  Pixel(this.color);

  int color;
  get alpha => 0xFF & (color >> 24);
  get red => 0xFF & (color >> 16);
  get green => 0xFF & (color >> 8);
  get blue => 0xFF & (color);
}

class AsciiImageConverter {
  Image loadImage(String path) {
    var file = File(path);

    if (!file.existsSync()) {
      throw FileSystemException("Impossível ler o arquivo.", path);
    }

    var bytes = file.readAsBytesSync();
    var img = decodeImage(bytes);

    if (img == null) {
      throw FileSystemException("Erro ao ler o arquivo.", path);
    }

    return img;
  }

  int getLuminanceFromPixel(Pixel pixel) {
    return ((0.299 * pixel.red + 0.587 * pixel.green + 0.114 * pixel.blue) *
            (pixel.alpha / 255))
        .round();
  }

  String fromImgToASCII(Image image,
      {String? asciiChars, bool invert = false}) {
    StringBuffer asciiArt = StringBuffer("");

    for (var i = 0; i < image.height; i++) {
      for (var j = 0; j < image.width; j++) {
        asciiArt.write(toASCII(
          getLuminanceFromPixel(Pixel(image.getPixelSafe(j, i))),
          asciiChars: asciiChars,
          invert: invert,
        ));
      }
      asciiArt.write("\n");
    }

    return asciiArt.toString();
  }

  Image resizeImage(Image image, [int? width, int? height]) {
    if (height == null && width == null) {
      height = image.height;
      width = image.width;
    }

    height ??= (width! * (image.height / image.width)).toInt();
    width ??= (height * (image.width / image.height)).toInt();

    // adjust for font proportion TODO: Implement as a parameter
    width = adjustWidthProportion(width);

    return copyResize(image, height: height, width: width);
  }

  int adjustWidthProportion(int width, {double ratio = 2}) => (width * ratio).round();

  String toASCII(
    int luminance, {
    String? asciiChars,
    bool useCustom = false,
    bool invert = false,
  }) {
    asciiChars = asciiChars ?? "\$@8W#abr?i!lI;:,\"^`'.  ";

    // var customasciiChars = "Wwli:,. ";

    var luminanceRatio = luminance / 255; // 0.3
    luminanceRatio = invert ? 1 - luminanceRatio : luminanceRatio;
    //                        1 - 0.3 = 0.7 <- inverted -> 0.3

    var posCaractere = (luminanceRatio * (asciiChars.length - 1)).floor();

    return asciiChars[posCaractere];
  }
  // List<int> getLuminanceValues(Image image) {
  //   int pixel;
  //   int luminance;
  //
  //   var fita = <int>[];
  //
  //   for (var i = 0; i < image.height; i++) {
  //     for (var j = 0; j < image.width; j++) {
  //       pixel = image.getPixelSafe(j, i);
  //       luminance = getLuminanceFromPixel(pixel);
  //       fita.add(luminance);
  //     }
  //   }
  //   return fita;
  // }
//   void printLuminance(Image image) {
//     int pixelValue;
//     int luminance;
//
//     var list = <int>[];
//
//     for (var i = 0; i < image.height; i++) {
//       for (var j = 0; j < image.width; j++) {
//         pixelValue = image.getPixelSafe(j, i);
//         luminance = getLuminanceFromPixel(Pixel(pixelValue));
//         print("Lu: $luminance");
//       }
//     }
//   }
}
