import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/models/episode.dart';
import '../../bloc/episodes_bloc.dart';

abstract class EpisodesRemoteDataSource {
  Future<Either<EpisodesStatus, List<Episode>>> getAllEpisodes(int pageIndex);

  Future<Either<EpisodesStatus, Episode>> getEpisodeDetail(
      {required Episode episode});
}
