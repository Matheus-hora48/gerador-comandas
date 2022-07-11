import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final myControllerNumber = TextEditingController();
  final myControllerColors = TextEditingController();
  File? arquivo;
  File? fundo;
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
        "fundo": fundo,
      });
      // File? arq = await Get.to(() => GeradorLeitor(file: file));
    }

    void _openThirdScreen() async {
      colorFinal = colorIncio + myControllerColors.value.text;
      Navigator.pushReplacementNamed(context, "/home", arguments: {
        "valor": myControllerNumber.value.text,
        "color": colorFinal,
        "arquivo": arquivo,
      });
    }

    enviarLogo() async {
      PickedFile? file = await picker.getImage(source: ImageSource.gallery);

      if (file != null) {
        setState(() => arquivo = File(file.path));
      }
    }

    enviarFundo() async {
      PickedFile? fileTwo = await picker.getImage(source: ImageSource.gallery);

      if (fileTwo != null) {
        setState(() => fundo = File(fileTwo.path));
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
            padding: const EdgeInsets.all(8.0),
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
            padding: const EdgeInsets.all(8.0),
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
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Preencha todas as informações para gerar suas comandas(Pode ser usado uma cor solida no fundo ou uma imagem da sua preferencia)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Enviar logo'),
              onTap: enviarLogo,
              trailing:
                  arquivo != null ? Image.file(File(arquivo!.path)) : null),
          const SizedBox(height: 20),
          ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Enviar imagem de fundo'),
              onTap: enviarFundo,
              trailing: fundo != null ? Image.file(File(fundo!.path)) : null),
          const SizedBox(height: 15),
          RaisedButton(
            onPressed: () =>
                fundo != null ? _openSecondScreen() : _openThirdScreen(),
            color: Colors.red,
            child: const Text('Confirmar',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      )),
    );
  }
}
