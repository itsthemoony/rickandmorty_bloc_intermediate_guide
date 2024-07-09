part of 'characters_bloc.dart';

sealed class CharactersEvent {}

class GetAllCharacters extends CharactersEvent {}

class GetMoreCharacter extends CharactersEvent {}

class GetCharacterDetail extends CharactersEvent {
  final int index;
  GetCharacterDetail({required this.index});
}
