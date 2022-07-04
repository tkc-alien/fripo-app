import 'package:flutter/material.dart';

class HowToPlayModal extends StatelessWidget {
  const HowToPlayModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '遊び方',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    _head,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    _body,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}

const _head = '''
Fripo（フリポ）は親が出すお題に対して、子が与えられたマッチ度になるような回答を考える、対戦ゲームです。採点は親が行い、狙っていたマッチ度から離れた点数分、ライフが減っていきます。一番最初にライフが０になってしまった人が敗北。あまりにも友達の感性を知らなすぎました。
''';

const _body = '''
▼ゲームの流れ

「お題」「回答」「点数付け」

この順にゲームは進みます

①「お題」

・ランダムで親が割り当てられます。

・親がお題を考えます。

②「回答」

・子にだけ狙うべきマッチ度が表示されています。

・子はお題に対して、表示されているマッチ度が得られるような回答を考えます。

③「点数付け」

・親は集まった回答ひとつひとつに点数をつけます。

・その結果、狙っていたマッチ度と親がつけた点数の差の分だけ、ライフが減ります。

①〜③を繰り返し、一人でもライフが０になったらゲーム終了です。
''';
