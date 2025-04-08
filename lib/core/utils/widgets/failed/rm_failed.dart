import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class RmFailed extends StatelessWidget {
  const RmFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          RMTexts.failed,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
