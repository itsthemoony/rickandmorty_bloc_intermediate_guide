import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/data_sources/remote_data_sources/episodes_remote_date_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/models/episode.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/repositories/episodes_repository.dart';
import '../bloc/episodes_bloc.dart';

class EpisodesRepositoryImp extends EpisodesRepository {
  final EpisodesRemoteDataSource remoteDataSource;

  EpisodesRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<EpisodesStatus, List<Episode>>> getAllEpisodes(
      {required int pageIndex}) async {
    return await remoteDataSource.getAllEpisodes(pageIndex);
  }

  @override
  Future<Either<EpisodesStatus, Episode>> getEpisodeDetail(
      {required Episode episode}) async {
    return await remoteDataSource.getEpisodeDetail(episode: episode);
  }
}
