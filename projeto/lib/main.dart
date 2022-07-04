import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

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
      home: const homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  ScreenshotController = ScreenshotController = ScreenshotController();
  String numero = '52';

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: ScreenshotController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    '53',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: SfBarcodeGenerator(
                      value: numero,
                      symbology: QRCode(),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 200,
                height: 80,
                child: SfBarcodeGenerator(value: numero),
              )
            ],
          )),
    );
  }
}
