import 'package:flutter/material.dart';

class TurnCountSelector extends StatefulWidget {
  const TurnCountSelector({Key? key}) : super(key: key);

  @override
  State<TurnCountSelector> createState() => _TurnCountSelectorState();
}

class _TurnCountSelectorState extends State<TurnCountSelector> {
  static const _duration = Duration(milliseconds: 200);
  static const _curve = Curves.fastOutSlowIn;

  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // change vm field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => _controller.previousPage(
            duration: _duration,
            curve: _curve,
          ),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        SizedBox(
          height: 50,
          width: 140,
          child: PageView(
            controller: _controller,
            children: [3, 5, 7, 10]
                .map(
                  (e) => Center(
                    child: Text(
                      '$eターン',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        IconButton(
          onPressed: () => _controller.nextPage(
            duration: _duration,
            curve: _curve,
          ),
          icon: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
