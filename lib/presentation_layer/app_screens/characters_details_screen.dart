import 'package:apis/constants/app_colors.dart';
import 'package:apis/data_layer/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  CharacterDetailsScreen({required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 800,
      backgroundColor: Colors.grey,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "${character.nickName}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.fill,
          ),
        ),
      ),
      pinned: true,
      stretch: true,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.appBarColor,
      height: 30,
      endIndent: endIndent,
      thickness: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                        'Job : ',
                        character.jobs.join(' / '),
                      ),
                      buildDivider(350),
                      characterInfo('Appeared in : ', character.category),
                      buildDivider(290),
                      characterInfo(
                        'Appearance In Seasons : ',
                        character.appearance.join(' / '),
                      ),
                      buildDivider(200),
                      characterInfo('Status : ', character.status),
                      buildDivider(330),
                      character.bettertCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              'Better Call Saul Seasons : ',
                              character.bettertCallSaulAppearance.join(' / '),
                            ),
                      character.bettertCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(200),
                      characterInfo('Actor / Actress  : ', character.name),
                      buildDivider(260),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
