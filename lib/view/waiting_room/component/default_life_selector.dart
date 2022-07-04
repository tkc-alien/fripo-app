import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
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

  final _controller = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      WaitingRoomViewModel.read(context)
          .defaultLifeController
          .stream
          .listen((value) {
        if (WaitingRoomViewModel.read(context).isUserHost) return;
        final page = AppConst.defaultLifeChoiceList.indexOf(value);
        if (page == -1) return;
        _controller.animateToPage(
          page,
          duration: _duration,
          curve: _curve,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUserHost = WaitingRoomViewModel.select(
      context,
      (vm) => vm.isUserHost,
    );

    final children = AppConst.defaultLifeChoiceList.map((choice) {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite,
              size: 28,
              color: AppColors.primary,
            ),
            const VerticalDivider(width: 8),
            Text(
              choice.toString(),
              style: const TextStyle(
                fontFamily: 'BlackHanSans',
                fontSize: 32,
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: !isUserHost
                  ? null
                  : () => _controller.previousPage(
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
                  if (!isUserHost) return;
                  WaitingRoomViewModel.read(context).updateDefaultLife(
                    AppConst.defaultLifeChoiceList[index],
                  );
                },
              ),
            ),
            IconButton(
              onPressed: !isUserHost
                  ? null
                  : () => _controller.nextPage(
                        duration: _duration,
                        curve: _curve,
                      ),
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
        if (!isUserHost)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
            ),
          ),
      ],
    );
  }
}
