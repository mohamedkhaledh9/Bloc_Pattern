import 'package:apis/business_logic_layer/characters_cubit.dart';
import 'package:apis/data_layer/api_services/characters_api.dart';
import 'package:apis/data_layer/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? allCharacters;

  @override
  void initState() {
    allCharacters =
        BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            CharactersApi charactersApi = CharactersApi();
            await charactersApi.getAllCharacters();
          },
          child: Text("Test Api"),
        ),
      ),
    );
  }
}
