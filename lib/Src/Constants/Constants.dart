class Strings{
  static String charactersUrl = 'https://api.genshin.dev/characters';
  String iconBig(String character,bool traveler){
    if(traveler){
      return 'https://api.genshin.dev/characters/$character/icon-big-lumine.png';
    }else{
      return 'https://api.genshin.dev/characters/$character/icon-big.png';
    }
  }
  Uri infoCharacter(String character){
    return Uri.parse('$charactersUrl/$character');
  }
  String iconElement(String vision){
    return 'https://api.genshin.dev/elements/$vision/icon.png';
  }
  String portrait(String character){
    return 'https://api.genshin.dev/characters/$character/portrait.png';
  }
}