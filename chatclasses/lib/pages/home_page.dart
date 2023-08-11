import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nicknameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          const Text("Digite seu nickname"),
          TextField(
            controller: nicknameController,
          ),
          TextButton(onPressed: () {}, child: const Text("Selecionar sala"))
        ]),
      ),
    ));
  }
}
