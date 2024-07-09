import 'package:equatable/equatable.dart';
import '../models/character.dart';
import 'characters_bloc.dart';

class CharactersState extends Equatable {
  final CharactersStatus status;
  final List<Character> characters;

  const CharactersState({required this.status, required this.characters});

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
    );
  }

  @override
  List<Object?> get props => [status, characters];

  factory CharactersState.initial() {
    return const CharactersState(
      status: CharactersStatus.initial,
      characters: [],
    );
  }
}
