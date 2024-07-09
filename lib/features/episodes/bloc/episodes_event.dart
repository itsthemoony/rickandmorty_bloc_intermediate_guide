part of 'episodes_bloc.dart';

sealed class EpisodesEvent extends Equatable {
  const EpisodesEvent();

  @override
  List<Object> get props => [];
}

class GetAllEpisodes extends EpisodesEvent {}

class GetMoreEpisodes extends EpisodesEvent {}

class GetEpisodeDetail extends EpisodesEvent {
  final int index;
  const GetEpisodeDetail({required this.index});
}
