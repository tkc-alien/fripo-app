import 'package:flutter/material.dart';

class ProviderInitializer extends StatefulWidget {
  const ProviderInitializer({
    Key? key,
    required this.initialize,
    required this.child,
  }) : super(key: key);

  final Function() initialize;
  final Widget child;

  @override
  State<ProviderInitializer> createState() => _ProviderInitializerState();
}

class _ProviderInitializerState extends State<ProviderInitializer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.initialize.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
