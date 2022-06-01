import 'package:flutter/material.dart';
import 'package:fripo/view/component/app_introduction/register_button.dart';
import 'package:fripo/view_model/app_introduction_view_model.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../component/app_introduction/name_input_field.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppIntroductionViewModel(),
      builder: (context, child) {
        return IntroductionScreen(
          isTopSafeArea: true,
          isBottomSafeArea: true,
          showDoneButton: false,
          showNextButton: false,
          showBackButton: false,
          showSkipButton: false,
          pages: [
            PageViewModel(
              title: 'App Introduction',
              body:
                  'This screen is displayed when no user information is stored in the application.',
            ),
            PageViewModel(
              title: 'User Register',
              bodyWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  NameInputField(),
                  RegisterButton(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
