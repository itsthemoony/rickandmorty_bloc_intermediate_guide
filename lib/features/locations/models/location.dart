import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../characters/models/character.dart';
part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final String url;
  // List of residents urls
  final List<String> residents;
  // List of residents objects
  @JsonKey(includeFromJson: false)
  final List<Character>? residentsDetail;

  const Location(
      {required this.id,
      required this.name,
      required this.type,
      required this.dimension,
      required this.url,
      required this.residents,
      this.residentsDetail});

  Location copyWith({
    int? id,
    String? name,
    String? type,
    String? dimension,
    String? url,
    List<String>? residents,
    List<Character>? residentsDetail,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dimension: dimension ?? this.dimension,
      url: url ?? this.url,
      residents: residents ?? this.residents,
      residentsDetail: residentsDetail ?? this.residentsDetail,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object?> get props =>
      [id, name, type, dimension, url, residents, residentsDetail];
}
