import 'package:chatclasses/widgets/card_label.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassesPage extends StatefulWidget {
  final String nickname;
  const ClassesPage({super.key, required this.nickname});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final db = FirebaseFirestore.instance;
  List<String> classes = [];
  var newClassController = TextEditingController();
  var userId = "";

  @override
  void initState() {
    super.initState();
    loadClasses();
    loadUser();
  }

  loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  loadClasses() async {
    await db.collection("chats").get().then((event) {
      for (var doc in event.docs) {
        classes.add(doc.id);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Salas")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: classes.length,
              itemBuilder: (_, int index) {
                var _class = classes[index];
                return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {},
                    key: Key("1"),
                    child: CardLabel(classTitle: _class));
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newClassController.text = "";
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Wrap(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Nome da nova sala"),
                          TextField(
                            controller: newClassController,
                          ),
                          TextButton(
                              onPressed: () async {
                                final Map<String, dynamic> newClass =
                                    <String, dynamic>{};
                                newClass["users"] = userId;
                                db
                                    .collection("chats")
                                    .doc(newClassController.text)
                                    .set(newClass);
                                loadClasses();
                                Navigator.pop(context);
                              },
                              child: const Text("Criar sala"))
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
