// ignore_for_file: file_names

import 'package:breakingbad/constants/strings.dart';
import 'package:breakingbad/data/models/charactersModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'characters_wbServices.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CharactersServices {
  factory CharactersServices(Dio dio, {String baseUrl}) = _CharactersServices;

  @GET('actors')
  Future<List<Character>> getAllChCharacters();
}
