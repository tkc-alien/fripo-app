import 'package:flutter/material.dart';
import 'package:fripo/view/screen/home_screen.dart';
import 'package:fripo/view_model/app_introduction_view_model.dart';

class RegisterButton extends StatefulWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      child: const Text('Register'),
    );
  }

  void onPressed(BuildContext context) async {
    final result = await AppIntroductionViewModel.read(context).register();
    if (!mounted) return;
    if (result == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }
}
