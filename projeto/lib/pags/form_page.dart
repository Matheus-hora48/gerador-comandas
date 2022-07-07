import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  XFile? logo;
  final myControllerNumber = TextEditingController();
  String comandas = '';
  int sizeNumber = 0;

  abriNovaPagina() {}

  @override
  Widget build(BuildContext context) {
    void _openSecondScreen() {
      Navigator.pushReplacementNamed(context, "/home",
          arguments: {"valor": myControllerNumber.value.text});
    }

    enviarLogo() async {
      final ImagePicker picker = ImagePicker();

      try {
        XFile? file = await picker.pickImage(source: ImageSource.gallery);
        if (file != null) setState(() => logo = file);
      } catch (e) {
        print(e);
      }
    }

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
              controller: myControllerNumber,
              decoration: const InputDecoration(
                labelText: 'Quantas comandas',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.attach_file),
            title: const Text('Enviar logo'),
            onTap: enviarLogo,
            trailing: logo != null ? Image.file(File(logo!.path)) : null,
          ),
          const SizedBox(height: 15),
          RaisedButton(
            onPressed: () => _openSecondScreen(),
            color: Colors.red,
            child: const Text('Confirmar',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      )),
    );
  }
}
