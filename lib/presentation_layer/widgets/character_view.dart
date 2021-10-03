import 'package:apis/constants/strings.dart';
import 'package:apis/data_layer/models/character_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterView extends StatelessWidget {
  final Character character;

  const CharacterView({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, charactersDetailsScreen,
              arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.id,
            child: Container(
              color: Colors.grey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image)
                  : Image.asset('assets/images/error.gif'),
            ),
          ),
          footer: Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  spreadRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              '${character.name}',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
