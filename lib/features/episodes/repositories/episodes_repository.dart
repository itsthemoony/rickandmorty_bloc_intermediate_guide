import 'package:fpdart/fpdart.dart';
import '../bloc/episodes_bloc.dart';
import '../models/episode.dart';

abstract class EpisodesRepository {
  Future<Either<EpisodesStatus, List<Episode>>> getAllEpisodes(
      {required int pageIndex});

  Future<Either<EpisodesStatus, Episode>> getEpisodeDetail(
      {required Episode episode});
}
