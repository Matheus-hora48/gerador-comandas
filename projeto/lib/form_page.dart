import 'package:flutter/material.dart';
import 'package:projeto/controllers/comandas_controllers.dart';
import 'package:projeto/events/end_events.dart';
import 'package:projeto/events/numeros_events.dart';
import 'package:projeto/events/start_events.dart';
import 'package:projeto/gerador.dart';
import 'package:projeto/models/numeros.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool showStartButton = true;
  //late final ComandasControllers controller;
  late final Stream<NumerosEvent> numerosStream;

  start() {
    //controller = ComandasControllers(quantidade: [Numeros(numeros: 20)]);
    setState(() {
      showStartButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de comandas'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showStartButton
              ? ElevatedButton(
                  onPressed: () {},
                  child: const Text("Começar a criação"),
                )
              : StreamBuilder(
                  builder: (context, AsyncSnapshot<NumerosEvent> snapshot) {
                    NumerosEvent? event = snapshot.data;
                    if (snapshot.hasError) {
                      return const Text("erro");
                    } else if (event is StartEvents) {
                      return const Text("Iniciando geração");
                    } else if (event is EndEvent) {
                      return const Text("Treino finalizado");
                    } else if (event is NumerosEvent) {
                      return GeradorComandas(event: event);
                    }
                    return Container();
                  },
                )
        ],
      )),
    );
  }
}
