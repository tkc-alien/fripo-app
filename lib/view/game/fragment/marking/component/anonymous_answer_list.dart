import 'package:flutter/material.dart';
import 'package:fripo/data/app_data.dart';
import 'package:fripo/define/app_colors.dart';
import 'package:fripo/view/app_common/profile_icon.dart';
import 'package:fripo/view_model/game_view_model.dart';

class AnonymousAnswerList extends StatelessWidget {
  const AnonymousAnswerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final answers = GameViewModel.select(
      context,
      (vm) => vm.currentTurnInfo?.answers?.entries.toList(),
    );

    if (answers == null) return const SizedBox.shrink();

    return ListView(
      children: answers.map((answer) {
        final iconUrl = answer.key == AppData.userId
            ? GameViewModel.select(
                context,
                (vm) => vm.getMember(AppData.userId)?.iconUrl,
              )
            : null;
        return _AnswerTile(
          iconUrl: iconUrl,
          answer: answer.value.answer,
        );
      }).toList(),
    );
  }
}

class _AnswerTile extends StatelessWidget {
  const _AnswerTile({
    Key? key,
    required this.iconUrl,
    required this.answer,
  }) : super(key: key);

  final String? iconUrl;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ProfileIcon(url: iconUrl ?? ""),
          const VerticalDivider(width: 12),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.secondary, width: 2),
                ),
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
                answer,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
