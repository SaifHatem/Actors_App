// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charactersModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as int?,
      name: json['name'] as String?,
      birthYear: json['birth_year'] as int?,
      deathYear: json['death_year'] as int?,
      nationality: json['nationality'] as String?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      awards:
          (json['awards'] as List<dynamic>?)?.map((e) => e as String).toList(),
      biography: json['biography'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
      'nationality': instance.nationality,
      'known_for': instance.knownFor,
      'awards': instance.awards,
      'biography': instance.biography,
      'image': instance.image,
    };
