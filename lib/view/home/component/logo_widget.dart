import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Fripo',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 80,
          color: Colors.grey,
        ),
      ),
    );
  }
}
