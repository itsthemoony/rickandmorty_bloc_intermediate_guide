part of 'episodes_bloc.dart';

class EpisodesState extends Equatable {
  final EpisodesStatus status;
  final List<Episode> episodes;

  const EpisodesState({required this.status, required this.episodes});

  @override
  List<Object> get props => [status, episodes];

  EpisodesState copyWith({
    EpisodesStatus? status,
    List<Episode>? episodes,
  }) {
    return EpisodesState(
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
    );
  }

  factory EpisodesState.initial() {
    return const EpisodesState(
      status: EpisodesStatus.initial,
      episodes: [],
    );
  }
}
