import 'package:flutter/material.dart';

class ProviderInitializer extends StatefulWidget {
  const ProviderInitializer({
    Key? key,
    this.initState,
    this.didChangeDependencies,
    required this.child,
  }) : super(key: key);

  final Function()? initState;
  final Function()? didChangeDependencies;
  final Widget child;

  @override
  State<ProviderInitializer> createState() => _ProviderInitializerState();
}

class _ProviderInitializerState extends State<ProviderInitializer> {
  @override
  void initState() {
    super.initState();
    widget.initState?.call();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
