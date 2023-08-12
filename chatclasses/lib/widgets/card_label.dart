import 'package:flutter/material.dart';

class CardLabel extends StatefulWidget {
  final String classTitle;
  const CardLabel({
    super.key,
    required this.classTitle,
  });

  @override
  State<CardLabel> createState() => _CardLabelState();
}

class _CardLabelState extends State<CardLabel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.classTitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
