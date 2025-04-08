import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/episodes/repositories/episodes_repository.dart';

import '../models/episode.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

enum EpisodesStatus {
  initial,
  loading,
  detailLoading,
  loaded,
  failed,
}

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final EpisodesRepository repository;
  int currentPage = 1;
  EpisodesBloc({required this.repository}) : super(EpisodesState.initial()) {
    on<GetAllEpisodes>(_getAllEpisodes);
    on<GetMoreEpisodes>(_getMoreEpisodes);
    on<GetEpisodeDetail>(_getEpisodeDetail);
  }

  FutureOr<void> _getAllEpisodes(
      GetAllEpisodes event, Emitter<EpisodesState> emit) async {
    if (state.episodes.isEmpty) {
      emit(state.copyWith(status: EpisodesStatus.loading));
      final result = await repository.getAllEpisodes(pageIndex: currentPage);
      result.fold((failed) {
        emit(state.copyWith(status: EpisodesStatus.failed));
      }, (episodes) {
        emit(state.copyWith(status: EpisodesStatus.loaded, episodes: episodes));
      });
    }
  }

  FutureOr<void> _getMoreEpisodes(
      GetMoreEpisodes event, Emitter<EpisodesState> emit) async {
    currentPage++;
    if (currentPage <= 3) {
      final result = await repository.getAllEpisodes(pageIndex: currentPage);
      result.fold((failed) {
        emit(state.copyWith(status: EpisodesStatus.failed));
      }, (newEpisodes) {
        emit(state.copyWith(
            status: EpisodesStatus.loaded,
            episodes: state.episodes + newEpisodes));
      });
    }
  }

  FutureOr<void> _getEpisodeDetail(
      GetEpisodeDetail event, Emitter<EpisodesState> emit) async {
    if (state.episodes[event.index].characterDetail == null) {
      emit(state.copyWith(status: EpisodesStatus.detailLoading));
      final result = await repository.getEpisodeDetail(
          episode: state.episodes[event.index]);
      result.fold((failed) {
        emit(state.copyWith(status: EpisodesStatus.failed));
      }, (episode) {
        emit(state.copyWith(
            status: EpisodesStatus.loaded,
            episodes: state.episodes..[event.index] = episode));
      });
    }
  }
}
