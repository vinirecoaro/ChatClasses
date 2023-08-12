import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  final String nickname;
  const ClassesPage({super.key, required this.nickname});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Salas")),
    ));
  }
}
