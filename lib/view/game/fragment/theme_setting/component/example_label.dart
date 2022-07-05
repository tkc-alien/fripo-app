import 'package:flutter/material.dart';

class ExampleLabel extends StatelessWidget {
  const ExampleLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade300.withOpacity(0.96),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text('例えば...'),
          Text('・○○なものといえば'),
          Text('・○○っぽい名前'),
          Text('・こんな○○はいやだ'),
        ],
      ),
    );
  }
}
