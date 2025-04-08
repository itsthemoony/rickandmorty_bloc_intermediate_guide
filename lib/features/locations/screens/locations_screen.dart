import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/bloc/locations_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/buttons/rm_floating_action_button.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/failed/rm_failed.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/widgets/loading/rm_loading.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/widgets/texts/rm_header.dart';
import 'package:rickandmorty_bloc_intermediate_guide/injection_container.dart'
    as di;
import '../widgets/rm_locations_card.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

final ScrollController _scrollController = ScrollController();

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di.sl.get<LocationsBloc>()..add(GetAllLocations()),
      child: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
          switch (state.status) {
            case LocationsStatus.loading:
              return const RMLoading();

            case LocationsStatus.loaded:
              return body(state);

            case LocationsStatus.failed:
              return const RmFailed();

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Scaffold body(LocationsState state) {
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
              const RMHeader(text: RMTexts.locations),
              const SizedBox(height: RMSizes.s16),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: RMSizes.s16),
                  key: const PageStorageKey<String>('locationsGridView'),
                  controller: _scrollController,
                  itemCount: state.locations.length,
                  itemBuilder: (context, index) {
                    final location =
                        context.read<LocationsBloc>().state.locations[index];
                    if (index >= state.locations.length - 1) {
                      context.read<LocationsBloc>().add(GetMoreLocations());
                    }
                    return RMLocationsCard(index: index, location: location);
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
