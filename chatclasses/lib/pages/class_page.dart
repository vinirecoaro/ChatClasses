import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  final String classTitle;
  const ClassPage({super.key, required this.classTitle});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(widget.classTitle)),
    ));
  }
}
