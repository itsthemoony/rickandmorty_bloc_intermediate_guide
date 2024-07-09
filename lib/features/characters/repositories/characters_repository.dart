import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';
import 'package:fpdart/fpdart.dart';

import '../bloc/characters_bloc.dart';

abstract class CharactersRepository {
  Future<Either<CharactersStatus, List<Character>>> getAllCharacters(
      {required int pageIndex});
  Future<Either<CharactersStatus, Character>> getCharacterDetail(
      {required Character character});
}
