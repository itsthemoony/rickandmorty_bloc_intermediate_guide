import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/data_sources/remote_data_sources/episodes_remote_date_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/models/episode.dart';

import '../../../../core/utils/constants/urls/rm_urls.dart';
import '../../bloc/episodes_bloc.dart';

class EpisodesRemoteDataSourceImp extends EpisodesRemoteDataSource {
  final Dio dio;
  EpisodesRemoteDataSourceImp({required this.dio});
  @override
  Future<Either<EpisodesStatus, List<Episode>>> getAllEpisodes(
      int pageIndex) async {
    try {
      final response = await dio
          .get(RMUrls.constructUrl(feature: 'episode', pageIndex: pageIndex));

      if (response.statusCode == HttpStatus.ok) {
        final List data = response.data['results'];
        final characters =
            data.map((character) => Episode.fromJson(character)).toList();

        return Right(characters);
      }
      return const Left(EpisodesStatus.failed);
    } on Exception catch (_) {
      return const Left(EpisodesStatus.failed);
    }
  }

  @override
  Future<Either<EpisodesStatus, Episode>> getEpisodeDetail(
      {required Episode episode}) async {
    try {
      List<Character> characters = [];
      for (String url in episode.characters) {
        final response = await dio.get(url);
        if (response.statusCode == HttpStatus.ok) {
          characters.add(Character.fromJson(response.data));
        }
      }
      final updatedEpisode = episode.copyWith(characterDetail: characters);
      return Right(updatedEpisode);
    } on Exception catch (_) {
      return const Left(EpisodesStatus.failed);
    }
  }
}
