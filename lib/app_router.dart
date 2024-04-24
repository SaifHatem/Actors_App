import 'package:breakingbad/business_logic/cubit/characters_cubit.dart';
import 'package:breakingbad/constants/strings.dart';
import 'package:breakingbad/data/models/charactersModel.dart';
import 'package:breakingbad/data/repository/characters_reopsitory.dart';
import 'package:breakingbad/data/web_services/characters_wbServices.dart';
import 'package:breakingbad/presentation/screens/characters_details_screen.dart';
import 'package:breakingbad/presentation/screens/characters_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersServices(Dio()));
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => charactersCubit,
                  child: const CharactersScreen(),
                ));

      case characterDetailesScreen:
        final actor = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(actor: actor));
    }
    return null;
  }
}
