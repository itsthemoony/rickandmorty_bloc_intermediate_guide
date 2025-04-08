import 'package:fpdart/fpdart.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/data_sources/remote_data_source/characters_remote_data_source.dart';
import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';
import 'package:rickandmorty_bloc_intermediate_guide/injection_container.dart';
import '../bloc/characters_bloc.dart';
import 'characters_repository.dart';

class CharactersRepositoryImp extends CharactersRepository {
  final CharactersRemoteDataSource remoteDataSource = sl.get<CharactersRemoteDataSource>();

  CharactersRepositoryImp();
  @override
  Future<Either<CharactersStatus, List<Character>>> getAllCharacters(
      {required int pageIndex}) async {
    return await remoteDataSource.getAllCharacters(pageIndex);
  }

  @override
  Future<Either<CharactersStatus, Character>> getCharacterDetail(
      {required Character character}) async {
    return await remoteDataSource.getCharacterDetail(character: character);
  }
}
