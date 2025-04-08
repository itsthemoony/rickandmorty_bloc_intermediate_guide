import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/repositories/characters_repository.dart';

import 'characters_state.dart';

part 'characters_event.dart';

enum CharactersStatus {
  initial,
  loading,
  detailLoading,
  loaded,
  failed,
}

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository repository;
  int currentPage = 1;
  CharactersBloc({required this.repository})
      : super(CharactersState.initial()) {
    on<GetAllCharacters>(_getAllCharacter);
    on<GetMoreCharacter>(_getMoreCharacter);
    on<GetCharacterDetail>(_getCharacterDetail);
  }

  FutureOr<void> _getAllCharacter(
      GetAllCharacters event, Emitter<CharactersState> emit) async {
    if (state.characters.isEmpty) {
      emit(state.copyWith(status: CharactersStatus.loading));
      final result = await repository.getAllCharacters(pageIndex: currentPage);
      result.fold((failed) {
        emit(state.copyWith(status: CharactersStatus.failed));
      }, (characters) {
        emit(state.copyWith(
            status: CharactersStatus.loaded, characters: characters));
      });
    }
  }

  FutureOr<void> _getMoreCharacter(event, Emitter<CharactersState> emit) async {
    currentPage++;
    if (currentPage <= 42) {
      final result = await repository.getAllCharacters(pageIndex: currentPage);
      result.fold((failed) {
        emit(state.copyWith(status: CharactersStatus.failed));
      }, (newCharacters) {
        emit(state.copyWith(
            status: CharactersStatus.loaded,
            characters: state.characters + newCharacters));
      });
    }
  }

  FutureOr<void> _getCharacterDetail(
      GetCharacterDetail event, Emitter<CharactersState> emit) async {
    if (state.characters[event.index].episodeDetail == null) {
      emit(state.copyWith(status: CharactersStatus.detailLoading));
      final result = await repository.getCharacterDetail(
          character: state.characters[event.index]);
      result.fold((failed) {
        emit(state.copyWith(status: CharactersStatus.failed));
      }, (character) {
        emit(state.copyWith(
            status: CharactersStatus.loaded,
            characters: state.characters..[event.index] = character));
      });
    }
  }
}
