import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/define/app_styles.dart';

const _dotWidth = 24.0;
//const _dotWidthFocused = 32.0;
const _answerHeight = 32.0;
double _totalHeight = 0;
double _sideLineHeight = 0;
double _topY = 0;
double _bottomY = 0;

class PointMarker extends StatefulWidget {
  const PointMarker({Key? key}) : super(key: key);

  @override
  State<PointMarker> createState() => _PointMarkerState();
}

class _PointMarkerState extends State<PointMarker> {
  // レンダリング後にサイズを取得するためのKey
  final _sideLineKey = GlobalKey();

  @override
  void didChangeDependencies() {
    // ウィジェットサイズは画面サイズから計算して決定
    final screenSize = MediaQuery.of(context).size;
    _totalHeight = screenSize.height * 0.5;

    // スライダーに必要な値は一度レンダリングしてから取得する
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // RenderBoxを取得
      final box = _sideLineKey.currentContext?.findRenderObject() as RenderBox;

      // 数直線の上端・下端の座標を取得
      _topY = box.localToGlobal(Offset.zero).dy;
      _bottomY = _topY + box.size.height;
      _sideLineHeight = box.size.height;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _totalHeight,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    SizedBox(height: _answerHeight / 2),
                    Text('100'),
                    Spacer(),
                    Text('50'),
                    Spacer(),
                    Text('0'),
                    SizedBox(height: _answerHeight / 2),
                  ],
                ),
                const VerticalDivider(width: 8),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: _answerHeight / 2),
                          Expanded(
                            child: VerticalDivider(
                              key: _sideLineKey,
                              thickness: 2,
                              width: _dotWidth,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: _answerHeight / 2),
                        ],
                      ),
                      const _Tile(answer: 'テスト'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatefulWidget {
  const _Tile({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final String answer;

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  // このウィジェットのKey　色々使える
  final _key = GlobalKey();

  // 現在のポイント
  int point = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      key: _key,
      left: 0,
      bottom: point * _sideLineHeight * 0.01,
      child: GestureDetector(
        onVerticalDragUpdate: onDrag,
        child: Row(
          children: [
            Container(
              width: _dotWidth,
              height: _dotWidth,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: FittedBox(
                child: Text(
                  '$point',
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
            Container(
              height: _answerHeight,
              decoration: AppStyles.borderedContainerDecoration,
              child: const Text('アンサー'),
            ),
          ],
        ),
      ),
    );
  }

  void onDrag(DragUpdateDetails details) {
    // ウィジェットのRenderBoxを取得
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    // 選択地点の数直線範囲内での座標を取得
    final posY = (details.globalPosition.dy - _topY - box.size.height / 2);
    // 最大地点の数直線範囲内での座標を取得
    final maxY = _bottomY - _topY;
    // 最大地点に対する選択地点の割合を百分率整数で取得
    int per = 100 - (posY / maxY * 100).round();
    // 最大値・最小値を超過している場合は是正
    if (per < 0) {
      per = 0;
    } else if (per > 100) {
      per = 100;
    }
    // 更新
    if (per != point) {
      setState(() {
        // print('point update: $point to $per');
        point = per;
      });
    }
  }
}
