import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class GerandoComandas extends StatefulWidget {
  const GerandoComandas({Key? key}) : super(key: key);

  @override
  State<GerandoComandas> createState() => _GerandoComandasState();
}

class _GerandoComandasState extends State<GerandoComandas> {
  ScreenshotController screenshotController = ScreenshotController();

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
              child: SfBarcodeGenerator(value: 'sizeNumber'),
            )
          ],
        ),
      ),
    );
  }
}