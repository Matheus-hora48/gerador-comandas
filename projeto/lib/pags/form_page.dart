import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto/pags/gerador_com_leitor.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final myControllerNumber = TextEditingController();
  final myControllerColors = TextEditingController();
  File? arquivo;
  final picker = ImagePicker();

  String comandas = '';
  int sizeNumber = 0;
  String colorIncio = '0xFF';
  String colorFinal = '';

  abriNovaPagina() {}

  @override
  Widget build(BuildContext context) {
    void _openSecondScreen() async {
      colorFinal = colorIncio + myControllerColors.value.text;
      Navigator.pushReplacementNamed(context, "/home", arguments: {
        "valor": myControllerNumber.value.text,
        "color": colorFinal,
        "arquivo": arquivo,
      });
      // File? arq = await Get.to(() => GeradorLeitor(file: file));
    }

    enviarLogo() async {
      PickedFile? file = await picker.getImage(source: ImageSource.gallery);

      if (file != null) {
        setState(() => arquivo = File(file.path));
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (text) => {comandas = text},
              controller: myControllerColors,
              decoration: const InputDecoration(
                labelText: 'Digite uma cor hexadecinal',
                hintText: 'ex: 7D79D0',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.attach_file),
            title: const Text('Enviar logo'),
            onTap: enviarLogo,
            // trailing: logo != null ? Image.file(File(logo!.path)) : null
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
