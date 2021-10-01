import 'package:apis/business_logic_layer/characters_cubit.dart';
import 'package:apis/data_layer/models/character_model.dart';
import 'package:apis/presentation_layer/widgets/character_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidget();
        } else {
          return loadingIndicator();
        }
      },
    );
  }

  Widget loadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        itemCount: allCharacters.length,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return CharacterView(character: allCharacters[index]);
        });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    print(allCharacters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters"),
      ),
      body: buildBlocWidget(),
    );
  }
}
