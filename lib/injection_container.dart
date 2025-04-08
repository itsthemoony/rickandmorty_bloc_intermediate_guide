import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/cubits/main/main_cubit.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/bloc/characters_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/data_sources/remote_data_source/characters_remote_data_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/data_sources/remote_data_source/characters_remote_data_source_imp.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/repositories/characters_repository.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/repositories/characters_repository_imp.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/data_sources/remote_data_sources/episodes_remote_data_source_imp.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/data_sources/remote_data_sources/episodes_remote_date_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/repositories/episodes_repository.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/repositories/episodes_repository_imp.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/bloc/locations_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/data_sources/remote_data_source/locations_remote_data_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/data_sources/remote_data_source/locations_remote_data_source_imp.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/locations/repositories/locations_repository_imp.dart';

import 'features/episodes/bloc/episodes_bloc.dart';
import 'features/locations/repositories/locations_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton(() => Dio());
  await initFeatures();
}

Future<void> initFeatures() async {
  // Main
  sl.registerLazySingleton(() => MainCubit());

  // Characters Feature
  sl.registerLazySingleton(() => CharactersBloc());

  sl.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImp());

  sl.registerLazySingleton<CharactersRemoteDataSource>(
      () => CharactersRemoteDataSourceImp());

  // Locations Feature
  sl.registerLazySingleton(() => LocationsBloc());

  sl.registerLazySingleton<LocationsRepository>(() => LocationsRepositoryImp());

  sl.registerLazySingleton<LocationsRemoteDataSource>(
      () => LocationsRemoteDataSourceImp());

// Episodes Feature
  sl.registerLazySingleton(() => EpisodesBloc());

  sl.registerLazySingleton<EpisodesRepository>(() => EpisodesRepositoryImp());

  sl.registerLazySingleton<EpisodesRemoteDataSource>(
      () => EpisodesRemoteDataSourceImp());
}
