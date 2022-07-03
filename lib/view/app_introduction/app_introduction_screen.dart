import 'package:flutter/material.dart';
import 'package:fripo/view/app_introduction/component/name_input_field.dart';
import 'package:fripo/view/app_introduction/component/register_button.dart';
import 'package:fripo/view_model/app_introduction_view_model.dart';
import 'package:provider/provider.dart';

import 'component/go_to_privacy_policy_button.dart';
import 'component/go_to_terms_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppIntroductionViewModel(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Align(
                      child: Text(
                        'ニックネームを入力してください',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(height: 8),
                    Align(
                      child: Text(
                        'ニックネームは後から変更することができます。',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Divider(height: 24),
                    NameInputField(),
                    Divider(height: 24),
                    Align(child: RegisterButton()),
                    Spacer(),
                    GoToTermsButton(),
                    Divider(height: 8),
                    GoToPrivacyPolicyButton(),
                    Divider(height: 8),
                    Text(
                      'ユーザー登録をもって利用規約とプライバシーポリシーに同意したものとみなします。',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
