import 'package:flutter/material.dart';

class GuideLabel extends StatelessWidget {
  const GuideLabel(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white70,
            spreadRadius: 4,
            blurRadius: 8,
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
