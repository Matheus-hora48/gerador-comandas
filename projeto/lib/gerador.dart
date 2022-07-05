import 'package:flutter/cupertino.dart';
import 'package:projeto/events/numeros_events.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class GeradorComandas extends StatelessWidget {
  const GeradorComandas({Key? key, required NumerosEvent event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/IFood_logo.svg/1200px-IFood_logo.svg.png',
              height: 200,
              width: 200,
            ),
            const Text(
              '32',
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 200,
              child: SfBarcodeGenerator(
                value:'32',
                symbology: QRCode(),
              ),
            ),
            SizedBox(
              width: 200,
              height: 80,
              child: SfBarcodeGenerator(value: '32'),
            )
    ],);
  }
}

