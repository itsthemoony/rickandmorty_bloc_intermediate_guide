import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/constants/constants.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/widgets/rm_characters_card.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/bloc/locations_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/failed/rm_failed.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/boxs/rm_header_box.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/loading/rm_loading.dart';
import '../../../core/utils/widgets/appbar/rm_appbar.dart';
import 'package:rickandmorty_bloc_intermediate_guide/injection_container.dart'
    as di;

class LocationsDetailScreen extends StatefulWidget {
  final int id;
  const LocationsDetailScreen({super.key, required this.id});

  @override
  State<LocationsDetailScreen> createState() => _LocationsDetailScreenState();
}

class _LocationsDetailScreenState extends State<LocationsDetailScreen> {
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
      value: di.sl.get<LocationsBloc>(),
      child: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
          final location = state.locations[widget.id];
          switch (state.status) {
            case LocationsStatus.loading:
              return RMLoading(title: location.name);

            case LocationsStatus.loaded:
              return body(context, state);

            case LocationsStatus.failed:
              return const RmFailed();

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Scaffold body(BuildContext context, LocationsState state) {
    final location = state.locations[widget.id];
    return Scaffold(
      appBar: RMAppBar(title: location.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: RMPaddings.p16),
        child: ListView(
          children: [
            const SizedBox(height: RMSizes.s20),
            RMHeaderContainer(
                header: RMTexts.name,
                description: location.name,
                color: RMColors.purple),
            const SizedBox(height: RMSizes.s20),
            RMHeaderContainer(
                header: RMTexts.type,
                description: location.type,
                color: RMColors.green),
            const SizedBox(height: RMSizes.s20),
            RMHeaderContainer(
                header: RMTexts.dimension,
                description: location.dimension,
                color: RMColors.accent),
            const SizedBox(height: RMSizes.s20),
            location.residentsDetail!.isNotEmpty
                ? Text(RMTexts.residents,
                    style: Theme.of(context).textTheme.titleLarge)
                : Center(
                    child: Text(RMTexts.noResidents,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: RMColors.red)),
                  ),
            const SizedBox(height: RMSizes.s10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              key: const PageStorageKey<String>('charactersGridView'),
              controller: _scrollController,
              itemCount: location.residentsDetail!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: RMSizes.s12,
                crossAxisSpacing: RMSizes.s12,
                crossAxisCount: 2,
                childAspectRatio: 0.86,
              ),
              itemBuilder: (context, index) {
                return RMCharactersCard(
                    index: index, character: location.residentsDetail![index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
