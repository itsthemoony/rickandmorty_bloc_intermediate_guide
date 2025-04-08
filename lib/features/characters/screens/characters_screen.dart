import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/constants/constants.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/bloc/characters_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/bloc/characters_state.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/screens/characters_detail_screen.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/widgets/rm_characters_card.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/failed/rm_failed.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/texts/rm_header.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/loading/rm_loading.dart';
import '../../../core/utils/widgets/buttons/rm_floating_action_button.dart';
import '../../../injection_container.dart' as di;

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di.sl<CharactersBloc>()..add(GetAllCharacters()),
      child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
        switch (state.status) {
          case CharactersStatus.loading:
            return const RMLoading();

          case CharactersStatus.loaded:
            return body(state);

          case CharactersStatus.failed:
            return const RmFailed();

          default:
            return const SizedBox();
        }
      }),
    );
  }

  Scaffold body(CharactersState state) {
    return Scaffold(
      floatingActionButton:
          RmFloatingActionButton(scrollController: _scrollController),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: RMPaddings.p24, horizontal: RMPaddings.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RMHeader(text: RMTexts.characters),
              const SizedBox(height: RMSizes.s16),
              Expanded(
                child: GridView.builder(
                  key: const PageStorageKey<String>('charactersGridView'),
                  controller: _scrollController,
                  itemCount: state.characters.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: RMSizes.s12,
                    crossAxisSpacing: RMSizes.s12,
                    crossAxisCount: 2,
                    childAspectRatio: 0.86,
                  ),
                  itemBuilder: (context, index) {
                    if (index >= state.characters.length - 1) {
                      context.read<CharactersBloc>().add(GetMoreCharacter());
                    }
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<CharactersBloc>()
                            .add(GetCharacterDetail(index: index));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CharactersDetailScreen(id: index);
                          }),
                        );
                      },
                      child: RMCharactersCard(
                        index: index,
                        character: state.characters[index],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
