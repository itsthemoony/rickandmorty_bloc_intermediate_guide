import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/bloc/episodes_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/utils/widgets/buttons/rm_floating_action_button.dart';
import 'package:rickandmorty_bloc_intermediate_guide/utils/widgets/failed/rm_failed.dart';
import 'package:rickandmorty_bloc_intermediate_guide/utils/widgets/loading/rm_loading.dart';
import '../../../constants/constants.dart';
import '../../../utils/widgets/texts/rm_header.dart';
import '../widgets/episodes_card.dart';
import 'package:rickandmorty_bloc_intermediate_guide/injection_container.dart'
    as di;

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
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
      value: di.sl.get<EpisodesBloc>()..add(GetAllEpisodes()),
      child: BlocBuilder<EpisodesBloc, EpisodesState>(
        builder: (context, state) {
          switch (state.status) {
            case EpisodesStatus.loading:
              return const RMLoading();

            case EpisodesStatus.loaded:
              return body(state);

            case EpisodesStatus.failed:
              return const RmFailed();

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Scaffold body(EpisodesState state) {
    return Scaffold(
      floatingActionButton:
          RmFloatingActionButton(scrollController: _scrollController),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: RMPaddings.p16, vertical: RMPaddings.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RMHeader(text: RMTexts.episodes),
              const SizedBox(height: RMSizes.s16),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  key: const PageStorageKey<String>('episodesListView'),
                  itemCount: state.episodes.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: RMSizes.s16);
                  },
                  itemBuilder: (context, index) {
                    if (index >= state.episodes.length - 1) {
                      context.read<EpisodesBloc>().add(GetMoreEpisodes());
                    }
                    return EpisodesCard(index: index);
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
