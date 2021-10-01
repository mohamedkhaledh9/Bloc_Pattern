import 'package:apis/data_layer/api_services/characters_api.dart';
import 'package:apis/data_layer/models/character_model.dart';

class CharactersRepository {
  final CharactersApi charactersApi;

  CharactersRepository(this.charactersApi);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersApi.getAllCharacters();
    print(characters);
    return characters.map((char) => Character.fromJson(char)).toList();
  }
}
