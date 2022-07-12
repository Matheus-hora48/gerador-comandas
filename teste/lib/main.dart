import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Teste",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste flutter"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              child: Container(
                width: 220,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple,
                ),
              ),
              onPanUpdate: (details) {
                setState(() {
                  offset = Offset(offset.dx + details.delta.dx,
                      offset.dy + details.delta.dy);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
