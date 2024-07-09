import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/constants/constants.dart';
import 'package:rickandmorty_bloc_intermediate_guide/cubits/main/main_cubit.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/screens/characters_screen.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/screens/episodes_screen.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/screens/locations_screen.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/settings/screens/settings_screen.dart';

class MainScreen extends StatelessWidget {
  static const List<Widget> _screens = [
    CharactersScreen(),
    LocationsScreen(),
    EpisodesScreen(),
    SettingsScreen(),
  ];
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[context.read<MainCubit>().state.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<MainCubit>().state.currentIndex,
        onTap: (index) => context.read<MainCubit>().onTap(index: index),
        items: const [
          BottomNavigationBarItem(
            icon: RMIcons.charactersNavigation,
            label: RMTexts.characters,
          ),
          BottomNavigationBarItem(
            icon: RMIcons.locationsNavigation,
            label: RMTexts.locations,
          ),
          BottomNavigationBarItem(
            icon: RMIcons.episodesNavigation,
            label: RMTexts.episodes,
          ),
          BottomNavigationBarItem(
            icon: RMIcons.settingsNavigation,
            label: RMTexts.settings,
          ),
        ],
      ),
    );
  }
}
