import 'package:flutter/material.dart';

class RMHeader extends StatelessWidget {
  final String text;
  const RMHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}
