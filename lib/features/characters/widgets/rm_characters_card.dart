import 'package:flutter/material.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/constants/constants.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';

class RMCharactersCard extends StatelessWidget {
  final int index;
  final Character character;
  const RMCharactersCard({
    super.key,
    required this.index,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(RMSizes.s8),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
          borderRadius: BorderRadius.circular(RMSizes.s12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(RMSizes.s8),
                ),
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  height: RMSizes.s120,
                  width: double.infinity,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: RMSizes.s5),
                padding: const EdgeInsets.all(RMPaddings.p10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    shape: BoxShape.circle),
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: RMSizes.s10),
          Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Container(
                width: RMSizes.s10,
                height: RMSizes.s10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: character.color,
                ),
              ),
              const SizedBox(width: RMSizes.s5),
              Text(
                character.status,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: character.color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
