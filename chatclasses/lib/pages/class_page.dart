import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/text_model.dart';
import '../widgets/chat_widget.dart';

class ClassPage extends StatefulWidget {
  final String nickname;
  final String classTitle;
  const ClassPage(
      {super.key, required this.classTitle, required this.nickname});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final db = FirebaseFirestore.instance;
  final textController = TextEditingController(text: "");
  String userId = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(widget.classTitle)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("chats")
                    .doc(widget.classTitle)
                    .collection("messages")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : ListView(
                          children: snapshot.data!.docs.map((e) {
                            var textModel = TextModel.fromJson(
                                e.data() as Map<String, dynamic>);
                            return ChatWidget(
                                textModel: textModel,
                                itsMe: textModel.userId == userId);
                          }).toList(),
                        );
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      var textModel = TextModel(
                          nickname: widget.nickname,
                          text: textController.text,
                          userId: userId);
                      await db
                          .collection("chats")
                          .doc(widget.classTitle)
                          .collection("messages")
                          .add(textModel.toJson());
                      textController.text = "";
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
