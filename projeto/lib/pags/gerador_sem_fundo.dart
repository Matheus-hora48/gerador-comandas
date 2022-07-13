import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projeto/utils/delay.dart';
import 'package:projeto/utils/util.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:core';

class GeradorSemFundo extends StatefulWidget {
  const GeradorSemFundo({Key? key}) : super(key: key);

  @override
  State<GeradorSemFundo> createState() => _GeradorSemFundoState();
}

class _GeradorSemFundoState extends State<GeradorSemFundo> {
  ScreenshotController screenshotController = ScreenshotController();
  String numeroConvertido = '0';
  int numberTest = 0;
  int numeroFor = 0;
  int sizeNumber = 0;
  final String _number = '52';
  String ticket = '0';
  int colorBody = 0;
  int colorIncio = 0xFF;
  int colorFinal = 0;

  saveToGallery(BuildContext context) {
    if (_number.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Imagem salva na galeria.'),
        //   ),
        // );
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

  @override
  criandoComandas(valor) async {
    sizeNumber = int.tryParse(valor)!;
    for (numeroFor = 1; numeroFor <= sizeNumber; numeroFor++) {
      numberTest = numeroFor;
      numeroConvertido = numberTest.toString();
      await readQRCode();
      await delay();
      await saveToGallery(context);
      setState(() {
        numeroConvertido;
      });
      await delay();
    }
    Navigator.pushReplacementNamed(context, "/finalizada");
  }

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        "#FFFFFF", "Cancelar", false, ScanMode.QR);
    setState(() {
      ticket = code != '-1' ? code : "Não validado";
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    final valor = routeArgs['valor'];
    final color = routeArgs['color'];
    var arquivo = routeArgs['arquivo'];

    colorBody = int.tryParse(color)!;

    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
          backgroundColor: Color(colorBody),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 255),
                child: Container(
                  width: 215,
                  height: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 680),
                child: Container(
                  width: 220,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          criandoComandas(valor);
                        });
                      },
                      child: Image.file(
                        arquivo,
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  Text(
                    numeroConvertido,
                    style: const TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: SfBarcodeGenerator(
                      value: ticket,
                      symbology: QRCode(),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 80,
                    child: SfBarcodeGenerator(value: numeroConvertido),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
