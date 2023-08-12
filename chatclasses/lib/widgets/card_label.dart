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
      height: 90,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.classTitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
