import 'package:flutter/material.dart';

class TextDefine extends StatelessWidget {
  final String text1;
  final String text2;
  const TextDefine({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      child: Row(
        children: [Text(text1), const Spacer(), Text(text2)],
      ),
    );
  }
}
