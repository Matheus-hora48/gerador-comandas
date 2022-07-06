import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projeto/form_page.dart';
import 'package:projeto/utils/util.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gerador de comandas",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FormPage(),
        '/home': (context) => homePage(),
      },
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  ScreenshotController screenshotController = ScreenshotController();
  int sizeNumber = 11;
  final String _number = '52';
  int number = 0;

  saveToGallery(BuildContext context) {
    if (_number.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Imagem salva na galeria.'),
          ),
        );
      }).catchError((e) => print(e));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  criandoComandas() {
    setState(() async {
      for (int x = 1; x <= sizeNumber; x++) {
        SizedBox(child: SfBarcodeGenerator(value: x.toString()));
        await saveToGallery(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: Colors.brown,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/IFood_logo.svg/1200px-IFood_logo.svg.png',
              height: 200,
              width: 200,
            ),
            const Text(
              '52',
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 200,
              child: SfBarcodeGenerator(
                value: '23',
                symbology: QRCode(),
              ),
            ),
            SizedBox(
              width: 200,
              height: 80,
              child: SfBarcodeGenerator(value: '1'),
            )
          ],
        ),
      ),
    );
    ;
  }
}
