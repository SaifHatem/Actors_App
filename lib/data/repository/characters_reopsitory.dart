import 'package:breakingbad/data/models/charactersModel.dart';
import 'package:breakingbad/data/web_services/characters_wbServices.dart';

class CharactersRepository {
  final CharactersServices charactersServices;

  CharactersRepository(this.charactersServices);

  Future<List<Character>> getAllChCharacters() async {
    var response = await charactersServices.getAllChCharacters();
    return response
        .map((singleCharacter) => Character.fromJson(singleCharacter.toJson()))
        .toList();
  }
}
