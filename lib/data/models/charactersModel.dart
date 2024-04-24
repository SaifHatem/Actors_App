// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'charactersModel.g.dart';

@JsonSerializable()
class Character {
  int? id;
  String? name;
  @JsonKey(name: 'birth_year')
  int? birthYear;
  @JsonKey(name: 'death_year')
  int? deathYear;
  String? nationality;
  @JsonKey(name: 'known_for')
  List<String>? knownFor;
  List<String>? awards;
  String? biography;
  String? image;

  Character(
      {this.id,
      this.name,
      this.birthYear,
      this.deathYear,
      this.nationality,
      this.knownFor,
      this.awards,
      this.biography,
      this.image});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
