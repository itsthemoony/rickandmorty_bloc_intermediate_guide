import 'package:flutter/material.dart';
import 'package:rickandmorty_bloc_intermediate_guide/constants/icons/rm_icons.dart';

class RmFloatingActionButton extends StatelessWidget {
  final ScrollController scrollController;
  const RmFloatingActionButton({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: RMIcons.arrowUp,
      onPressed: () {
        scrollController.animateTo(
          0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic,
        );
      },
    );
  }
}
