import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/core/utils/constants/urls/rm_urls.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/bloc/characters_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/data_sources/remote_data_source/characters_remote_data_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/models/episode.dart';
import 'package:rickandmorty_bloc_intermediate_guide/injection_container.dart';

class CharactersRemoteDataSourceImp extends CharactersRemoteDataSource {
  final Dio dio = sl.get<Dio>();
  @override
  Future<Either<CharactersStatus, List<Character>>> getAllCharacters(
      int pageIndex) async {
    try {
      final response = await dio
          .get(RMUrls.constructUrl(feature: 'character', pageIndex: pageIndex));

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['results'];
        final characters =
            data.map((character) => Character.fromJson(character)).toList();

        return Right(characters);
      }
      return const Left(CharactersStatus.failed);
    } on Exception catch (_) {
      return const Left(CharactersStatus.failed);
    }
  }

  @override
  Future<Either<CharactersStatus, Character>> getCharacterDetail(
      {required Character character}) async {
    try {
      List<Episode> episodes = [];
      for (String url in character.episode) {
        final response = await dio.get(url);
        if (response.statusCode == HttpStatus.ok) {
          episodes.add(Episode.fromJson(response.data));
        }
      }
      final updatedCharacter = character.copyWith(episodeDetail: episodes);
      return Right(updatedCharacter);
    } on Exception catch (_) {
      return const Left(CharactersStatus.failed);
    }
  }
}
