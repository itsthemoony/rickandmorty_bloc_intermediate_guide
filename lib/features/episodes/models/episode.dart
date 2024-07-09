import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rickandmorty_bloc_intermediate_guide/features/characters/models/character.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode extends Equatable {
  final int id;
  final String name;
  final String air_date;
  final String episode;
  final String url;
  final List<String> characters;
  @JsonKey(includeFromJson: false)
  final List<Character>? characterDetail;

  const Episode({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.url,
    required this.characters,
    this.characterDetail,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        air_date,
        episode,
        url,
        characters,
        characterDetail,
      ];

  Episode copyWith({
    int? id,
    String? name,
    String? air_date,
    String? episode,
    String? url,
    List<String>? characters,
    List<Character>? characterDetail,
  }) {
    return Episode(
      id: id ?? this.id,
      name: name ?? this.name,
      air_date: air_date ?? this.air_date,
      episode: episode ?? this.episode,
      url: url ?? this.url,
      characters: characters ?? this.characters,
      characterDetail: characterDetail ?? this.characterDetail,
    );
  }
}
