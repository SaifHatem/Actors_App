// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:breakingbad/data/models/charactersModel.dart';
import 'package:breakingbad/data/repository/characters_reopsitory.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllUsersFromReop() {
    charactersRepository.getAllChCharacters().then((characters) {
      // كأني بقوله ابدا شغل الستيت دي
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
