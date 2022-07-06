import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projeto/form_page.dart';
import 'package:projeto/utils/delay.dart';
import 'package:projeto/utils/util.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:core';

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
        '/': (context) => const FormPage(),
        '/home': (context) => const homePage(),
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
  String numeroConvertido = '0';
  int numberTest = 0;
  int numeroFor = 0;
  int sizeNumber = 5;
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
    final name = "screenshot_$time-$sizeNumber";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  criandoComandas(valor) {
    sizeNumber = int.tryParse(valor)!;
    setState(() async {
      for (numeroFor = 1; numeroFor <= sizeNumber; numeroFor++) {
        numberTest = numeroFor;
        numeroConvertido = numberTest.toString();
        await delay();
        await saveToGallery(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    final valor = routeArgs['valor'];
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: Colors.brown,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => criandoComandas(valor),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/IFood_logo.svg/1200px-IFood_logo.svg.png',
                height: 200,
                width: 200,
              ),
            ),
            const Text(
              '1',
              style: TextStyle( 
                fontSize: 45.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 200,
              child: SfBarcodeGenerator(
                value: '1',
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
  }
}
