import 'package:flutter/material.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/domain/entity/answer_info.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view_model/game_view_model.dart';

class ResultList extends StatelessWidget {
  const ResultList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final answers =
        GameViewModel.select(context, (vm) => vm.currentTurnInfo?.answers);

    if (answers == null) return const SizedBox.shrink();

    return ListView(
      children: answers.entries
          .map((entry) => _ResultTile(entry.key, entry.value))
          .toList(),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile(
    this.userId,
    this.answer, {
    Key? key,
  }) : super(key: key);

  final String userId;
  final AnswerInfo answer;

  @override
  Widget build(BuildContext context) {
    final member = GameViewModel.select(
      context,
      (vm) => vm.roomInfo?.members[userId],
    );

    if (member == null || answer.point == null || answer.difference == null) {
      return const SizedBox.shrink();
    }

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(height: 8),
                ProfileIcon(url: member.iconUrl),
                Text(
                  member.life?.toString() ?? '??',
                  style: const TextStyle(
                    fontFamily: 'BlackHanSans',
                    fontSize: 20,
                    color: AppColors.primary,
                  ),
                ),
                const Divider(height: 8),
              ],
            ),
            const VerticalDivider(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          member.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 52,
                            child: Image.asset('assets/image/bubble.png'),
                          ),
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                answer.point.toString(),
                                style: const TextStyle(
                                  fontFamily: 'BlackHanSans',
                                  fontSize: 32,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 8),
                  Text(answer.answer),
                  const Divider(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
