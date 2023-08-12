import 'package:chatclasses/pages/classes_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nicknameController = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  loadUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString("user_id");
    if (userId == null) {
      var uuid = const Uuid();
      userId = uuid.v4();
      sharedPreferences.setString("user_id", userId);
    }
  }

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
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ClassesPage(
                              nickname: nicknameController.text,
                            )));
              },
              child: const Text("Selecionar sala"))
        ]),
      ),
    ));
  }
}
