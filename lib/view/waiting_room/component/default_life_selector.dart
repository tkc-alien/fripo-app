import 'package:flutter/material.dart';
import 'package:fripo/define/app_const.dart';
import 'package:fripo/view_model/waiting_room_view_model.dart';

class DefaultLifeSelector extends StatefulWidget {
  const DefaultLifeSelector({Key? key}) : super(key: key);

  @override
  State<DefaultLifeSelector> createState() => _DefaultLifeSelectorState();
}

class _DefaultLifeSelectorState extends State<DefaultLifeSelector> {
  static const _duration = Duration(milliseconds: 200);
  static const _curve = Curves.fastOutSlowIn;

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final children = AppConst.defaultLifeChoiceList.map((choice) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite,
              size: 24,
            ),
            Text(
              choice.toString(),
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      );
    }).toList();

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
            children: children,
            onPageChanged: (index) {
              WaitingRoomViewModel.read(context).setDefaultLife(
                AppConst.defaultLifeChoiceList[index],
              );
            },
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
