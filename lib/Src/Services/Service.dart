import 'package:genshin_impact/Src/Constants/Constants.dart';
import 'package:genshin_impact/Src/Models/AllCharaModel.dart';
import 'package:genshin_impact/Src/Models/CharaModel.dart';
import 'package:http/http.dart' as http;

class GenshinService{
  Future<List<String>?>getAllCharacters()async{
    var client = http.Client();
    var response = await client.get(Uri.parse(Strings.charactersUrl));
    if(response.statusCode == 200){
      var jsonString = response.body;
      return charactersFromJson(jsonString);
    }
    return null;
  }

  Future<CharactersInfo?> getInfoCharacter(String character) async{
    var client = http.Client();
    var response = await client.get(Strings().infoCharacter(character));
    if(response.statusCode == 200){
      var jsonString = response.body;
      return charactersInfoFromJson(jsonString);
    }
    return null;
  }

}