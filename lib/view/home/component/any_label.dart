import 'package:flutter/material.dart';

class AnyLabel extends StatelessWidget {
  const AnyLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        'どんなゲーム？\nああああああああああああああああああああああああああああああああ',
      ),
    );
  }
}
