import 'package:flutter/material.dart';

class HowToPlayModal extends StatelessWidget {
  const HowToPlayModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 13,
                itemBuilder: (context, index) {
                  return Image.asset('assets/image/how_to_${index + 1}.png');
                },
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('とじる'),
            ),
          ],
        ),
      ),
    );
  }
}
