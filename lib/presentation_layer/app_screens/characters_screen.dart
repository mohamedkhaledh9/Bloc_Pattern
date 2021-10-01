import 'package:apis/business_logic_layer/characters_cubit.dart';
import 'package:apis/constants/app_colors.dart';
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
  List<Character>? allCharacters;
  List<Character>? searchedResultList;
  bool isSearching = false;
  TextEditingController searchingController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      cursorColor: Colors.black,
      controller: searchingController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Enter Character You Want To Search...",
        hintStyle: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onChanged: (character) {
        searchedForCharacters(character);
      },
    );
  }

  List<Widget> appBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: stopSearching,
          icon: Icon(
            Icons.clear,
            color: MyColors.iconsColors,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: Icon(
            Icons.search,
            color: MyColors.iconsColors,
          ),
        ),
      ];
    }
  }

  Widget buildAppBarTitle() {
    return Text(
      "Characters",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

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
        itemCount: searchingController.text.isEmpty
            ? allCharacters!.length
            : searchedResultList!.length,
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return searchingController.text.isEmpty
              ? CharacterView(character: allCharacters![index])
              : CharacterView(character: searchedResultList![index]);
        });
  }

  void searchedForCharacters(String searchedCharacter) {
    searchedResultList = allCharacters!
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  void clearSearch() {
    searchingController.clear();
    setState(() {});
  }

  startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: startSearching));
    setState(() {
      isSearching = true;
    });
  }

  stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
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
        backgroundColor: MyColors.appBarColor,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: appBarActions(),
        leading: isSearching
            ? BackButton(
                color: Colors.black,
              )
            : Container(),
      ),
      body: buildBlocWidget(),
    );
  }
}
