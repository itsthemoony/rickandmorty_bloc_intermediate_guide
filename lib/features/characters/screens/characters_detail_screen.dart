import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/constants/constants.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/bloc/characters_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/bloc/characters_state.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/appbar/rm_appbar.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/failed/rm_failed.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/loading/rm_loading.dart';
import '../../../core/utils/widgets/boxs/rm_header_box.dart';
import '../../../injection_container.dart' as di;

class CharactersDetailScreen extends StatefulWidget {
  final int id;
  const CharactersDetailScreen({super.key, required this.id});
  @override
  State<CharactersDetailScreen> createState() => _CharactersDetailScreenState();
}

class _CharactersDetailScreenState extends State<CharactersDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di.sl<CharactersBloc>()..add(GetAllCharacters()),
      child: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          final character = state.characters[widget.id];
          switch (state.status) {
            case CharactersStatus.loading:
              return RMLoading(title: character.name);

            case CharactersStatus.loaded:
              return body(character, context);

            case CharactersStatus.failed:
              return const RmFailed();

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Scaffold body(Character character, BuildContext context) {
    return Scaffold(
      appBar: RMAppBar(title: character.name),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: RMPaddings.p16),
        children: [
          Image.network(
            character.image,
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height / 2.5,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: RMSizes.s30),

          // Status and Type Section
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: RMHeaderContainer(
                    header: RMTexts.status,
                    description: character.status,
                    color: RMColors.accent),
              ),
              const SizedBox(width: RMSizes.s10),
              Expanded(
                child: RMHeaderContainer(
                    header: RMTexts.type,
                    description: character.type,
                    color: RMColors.grey500),
              ),
            ],
          ),

          const SizedBox(height: RMSizes.s30),

          // Gender and Status Section
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: RMHeaderContainer(
                    header: RMTexts.gender,
                    description: character.gender,
                    color: RMColors.purple),
              ),
              const SizedBox(width: RMSizes.s10),
              Expanded(
                child: RMHeaderContainer(
                    header: RMTexts.status,
                    description: character.status,
                    color: character.color),
              ),
            ],
          ),
          const SizedBox(height: RMSizes.s30),
          Text(
            RMTexts.episodes,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: RMSizes.s10),

          ListView.separated(
            shrinkWrap: true,
            itemCount: character.episodeDetail!.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: RMSizes.s10);
            },
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: RMSizes.s16, vertical: RMPaddings.p20),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface),
                    borderRadius: BorderRadius.circular(RMSizes.s8)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.episodeDetail![index].episode,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: RMSizes.s5),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 1.5,
                          child: Text(
                            character.episodeDetail![index].name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(height: RMSizes.s5),
                        Text(
                          character.episodeDetail![index].air_date,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
