import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/view/game/fragment/marking/marking_fragment.dart';
import 'package:fripo/view_model/game_view_model.dart';
import 'package:fripo/view_model/marking_view_model.dart';

const _dotWidth = 24.0;
const _dotWidthFocused = 32.0;
const _bottomPadding = MarkingFragment.sendButtonHeight;
const _topPadding = MarkingFragment.topHeight;
double _sideLineHeight = 0;
double _topY = 0;
double _bottomY = 0;

const _answerStyle = TextStyle(fontSize: 14);
const _focusedAnswerStyle = TextStyle(fontSize: 20);

// PointMarker ----------------------------------------------------------------

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
    //final screenSize = MediaQuery.of(context).size;
    //_topPadding = screenSize.height * 0.2 - _bottomPadding;

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
    return Positioned.fill(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              SizedBox(height: _topPadding),
              Text('100'),
              Spacer(),
              Text('50'),
              Spacer(),
              Text('0'),
              SizedBox(height: _bottomPadding),
            ],
          ),
          const VerticalDivider(width: 8),
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: _topPadding),
                    Expanded(
                      child: VerticalDivider(
                        key: _sideLineKey,
                        thickness: 2,
                        width: _dotWidthFocused,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: _bottomPadding),
                  ],
                ),
                const Positioned.fill(child: _TileContainer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// TileContainer --------------------------------------------------------------

class _TileContainer extends StatefulWidget {
  const _TileContainer({Key? key}) : super(key: key);

  @override
  State<_TileContainer> createState() => _TileContainerState();
}

class _TileContainerState extends State<_TileContainer> {
  final List<_TileData> _data = [];
  String _focusedId = '';

  @override
  void didChangeDependencies() {
    final answers = GameViewModel.read(context).currentTurnInfo?.answers;
    if (answers == null) throw Exception();
    final entries = answers.entries.toList();
    final double p;
    if (entries.length > 1) {
      p = 100 / (entries.length - 1);
    } else {
      p = 0;
    }
    for (var i = 0; i < answers.length; i++) {
      final point = (p * i).round();
      _data.add(_TileData(
        userId: entries[i].key,
        answer: entries[i].value.answer,
        point: point,
      ));
      MarkingViewModel.read(context).setPoint(entries[i].key, point);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final children = <_Tile>[];
    for (var i = 0; i < _data.length; i++) {
      children.add(
        _Tile(
          key: ValueKey(_data[i].userId),
          hasFocus: _focusedId == _data[i].userId,
          userId: _data[i].userId,
          answer: _data[i].answer,
          initialPoint: _data[i].point,
          onDragStart: onDragStart,
        ),
      );
    }

    return Stack(children: children);
  }

  void onDragStart(String userId) {
    final obj = _data.singleWhere((e) => e.userId == userId);
    _data.remove(obj);
    _data.add(obj);
    setState(() {
      _focusedId = userId;
    });
  }
}

// Tile ----------------------------------------------------------------------

class _Tile extends StatefulWidget {
  const _Tile({
    Key? key,
    required this.hasFocus,
    required this.userId,
    required this.answer,
    required this.initialPoint,
    required this.onDragStart,
  }) : super(key: key);

  final bool hasFocus;
  final String userId;
  final String answer;
  final int initialPoint;
  final Function(String userId) onDragStart;

  @override
  State<_Tile> createState() => _TileState();
}

class _TileState extends State<_Tile> {
  // このウィジェットのKey　色々使える
  final _key = GlobalKey();

  // 現在のポイント
  int point = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => point = widget.initialPoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    double left = 0;
    double bottom = point * _sideLineHeight * 0.01 + _bottomPadding;
    if (widget.hasFocus) {
      // ウィジェットのRenderBoxを取得
      final box = _key.currentContext?.findRenderObject() as RenderBox?;
      bottom -= (box?.size.height ?? 0) / 2;
    } else {
      left = (_dotWidthFocused - _dotWidth) / 2;
      bottom -= _dotWidth / 2;
    }

    return Positioned(
      key: _key,
      right: 0,
      left: left,
      bottom: bottom,
      child: GestureDetector(
        onVerticalDragUpdate: onDrag,
        onVerticalDragStart: (_) => widget.onDragStart(widget.userId),
        onVerticalDragEnd: (_) {
          MarkingViewModel.read(context).setPoint(widget.userId, point);
        },
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: widget.hasFocus ? _dotWidthFocused : _dotWidth,
              height: widget.hasFocus ? _dotWidthFocused : _dotWidth,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: AppColors.onPrimary,
                    width: 2,
                  ),
                ),
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
            Flexible(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: AppColors.secondary,
                      width: 2,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.answer,
                  maxLines: widget.hasFocus ? null : 1,
                  overflow: widget.hasFocus ? null : TextOverflow.ellipsis,
                  style: widget.hasFocus ? _focusedAnswerStyle : _answerStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ドラッグ更新のコールバック
  void onDrag(DragUpdateDetails details) {
    // 選択地点の数直線範囲内での座標を取得
    final posY = (details.globalPosition.dy - _topY);
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

// class _FocusedTile extends StatelessWidget {
//   const _FocusedTile({
//     Key? key,
//     required this.answer,
//   }) : super(key: key);
//
//   final String answer;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: AppStyles.borderedContainerDecoration,
//       padding: const EdgeInsets.all(8),
//       child: Text(answer),
//     );
//   }
// }

class _TileData {
  _TileData({
    required this.userId,
    required this.answer,
    required this.point,
  });

  final String userId;
  final String answer;
  final int point;
}
