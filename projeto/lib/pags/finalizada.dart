import 'package:flutter/material.dart';

class FinalizadaComandas extends StatefulWidget {
  const FinalizadaComandas({Key? key}) : super(key: key);

  @override
  State<FinalizadaComandas> createState() => _FinalizadaComandasState();
}

class _FinalizadaComandasState extends State<FinalizadaComandas> {
  int comandasGeradas = 1;
  String comandasGeradasString = '';

  void _openIndexPage() {
    Navigator.pushReplacementNamed(
      context,
      "/",
    );
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    // final valor = routeArgs['valor'];
    // comandasGeradas = int.tryParse(valor)!;
    // comandasGeradasString = comandasGeradas.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de comandas'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Comandas geradas',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: _openIndexPage,
            color: Colors.red,
            child: const Text(
              'Voltar inicio',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          )
        ],
      )),
    );
  }
}
