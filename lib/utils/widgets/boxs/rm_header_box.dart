import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class RMHeaderContainer extends StatelessWidget {
  final String header;
  final String description;
  final Color color;
  const RMHeaderContainer(
      {super.key,
      required this.header,
      required this.description,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(RMPaddings.p5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RMSizes.s8),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Text(
            header,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: color,
              fontSize: RMSizes.s24,
            ),
          ),
        ),
        const SizedBox(height: RMSizes.s10),
        Text(
          description.isEmpty ? RMTexts.unknown : description,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
