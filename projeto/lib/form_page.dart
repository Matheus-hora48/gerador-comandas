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
  String comandas = '';
  int sizeNumber = 0;

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) => {comandas = text},
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantas comandas',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 15),
          RaisedButton(
            onPressed: () {
              sizeNumber = int.tryParse(comandas)!;
              Navigator.of(context).pushNamed('/home');
              print(sizeNumber);
            },
            child: Text('Confirmar'),
          ),
        ],
      )),
    );
  }
}
