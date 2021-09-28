import 'package:apis/business_logic_layer/characters_cubit.dart';
import 'package:apis/constants/strings.dart';
import 'package:apis/data_layer/api_services/characters_api.dart';
import 'package:apis/data_layer/repositries/character_repositry.dart';
import 'package:apis/presentation_layer/app_screens/characters_details_screen.dart';
import 'package:apis/presentation_layer/app_screens/characters_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersApi());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: CharactersScreen(),
          ),
        );
      case charactersDetailsScreen:
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen());
    }
  }
}
