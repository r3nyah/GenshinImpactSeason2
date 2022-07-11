import 'dart:ui';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:genshin_impact/Src/Models/CharaArgument.dart';
import 'package:genshin_impact/Src/Models/CharaModel.dart';
import 'package:genshin_impact/Src/Constants/Constants.dart';
class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Color _colorBg;
  late Color _colorInfo;
  late Color _colorText;
  late Color _colorCard;

  @override
  Widget build(BuildContext context) {
    final CharacterArguments _arguments = ModalRoute.of(context)!.settings.arguments as CharacterArguments;
    double width = MediaQuery.of(context).size.width;
    final CharactersInfo _character = _arguments.info;
    final String _name = _arguments.character;
    _paletteColor(_character.vision!);
    return Scaffold(
      backgroundColor: _colorBg,
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: _colorBg
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                    padding: EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 288,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -30,
                                left: -250,
                                right: 30,
                                child:  Opacity(
                                  opacity: 0.5,
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image:Strings().portrait(_name),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                              Positioned(
                                  child: Opacity(
                                      opacity:1,
                                      child: FadeInImage.memoryNetwork(
                                        width: width/2,
                                        placeholder: kTransparentImage,
                                        image:Strings().portrait(_name),

                                      )
                                  )
                              ),
                              Positioned(
                                  left: -width / 2 + 40,
                                  top: 200,
                                  right: 0,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _character.name!,
                                          style: TextStyle(
                                            color: _colorText,
                                            fontFamily: 'GenshinFont',
                                            fontSize: 30,

                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        _rarity(_character.rarity!)
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      decoration: BoxDecoration(
                          color: _colorInfo,
                          image: DecorationImage(
                              image: AssetImage('assets/stars.png'),
                              fit: BoxFit.contain,
                              repeat: ImageRepeat.repeat

                          ),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30),
                          )),
                      child: Column(
                        children: <Widget>[
                          _descriptionCard(color: _colorCard, character: _character),
                          _skillsCard(color: _colorCard, character: _character),
                          _constellationCard(color: _colorCard, character: _character)


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionCard({required Color color, required CharactersInfo character}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 8),
          child: Text(
            'Description',
            style: TextStyle(
                fontFamily: 'GenshinFont',
                fontSize: 20,
                color: _colorText
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                character.description!,
                style: TextStyle(
                    color: _colorText,
                    fontFamily: 'GenshinFont',
                    fontSize: 16
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _skillsCard({required Color color, required CharactersInfo character}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 8),
          child: Text(
            'Skills',
            style: TextStyle(
                fontFamily: 'GenshinFont',
                fontSize: 20,
                color: _colorText
            ),
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:character.skillTalents!.length,
            itemBuilder: (context,index){
              return  Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.skillTalents![index].name!,
                          style: TextStyle(
                              color: _colorText,
                              fontFamily: 'GenshinFont',
                              fontSize: 18
                          ),
                        ),
                        Text(
                          character.skillTalents![index].description!,
                          style: TextStyle(
                              color: _colorText,
                              fontFamily: 'GenshinFont',
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),

      ],
    );
  }

  Widget _constellationCard({required Color color, required CharactersInfo character}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 8),
          child: Text(
            'Constellations',
            style: TextStyle(
                fontFamily: 'GenshinFont',
                fontSize: 20,
                color: _colorText
            ),
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:character.constellations!.length,
            itemBuilder: (context,index){
              return  Card(
                margin: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.constellations![index].name!,
                          style: TextStyle(
                              color: _colorText,
                              fontFamily: 'GenshinFont',
                              fontSize: 18
                          ),
                        ),
                        Text(
                          character.constellations![index].description!,
                          style: TextStyle(
                              color: _colorText,
                              fontFamily: 'GenshinFont',
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),

      ],
    );
  }

  Widget _rarity(int rarity){
    List<Widget> stars = [];
    for (var i = 0; i < rarity; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber.shade400,));
    }
    return Row(
      children: stars,
    );
  }

  void _paletteColor(String vision){
    switch (vision) {
      case 'Anemo':
        _colorBg = Color.fromRGBO(84, 220, 180, 86);
        _colorInfo = Color.fromRGBO(35, 92, 75, 33);
        _colorCard = Color.fromRGBO(58, 153, 125, 60);
        _colorText = Colors.white;
        break;
      case 'Geo':
        _colorBg = Color.fromRGBO(255, 206, 0, 100);
        _colorInfo = Color.fromRGBO(128, 102, 0, 50);
        _colorCard = Color.fromRGBO(204, 163, 0, 80);
        _colorText = Colors.black87;
        break;
      case 'Cryo':
        _colorBg = Color.fromRGBO(153, 214, 247, 97);
        _colorInfo = Color.fromRGBO(17, 86, 122, 48);
        _colorCard = Color.fromRGBO(121, 168, 194, 20);
        _colorText = Colors.black87;
        break;
      case 'Pyro':
        _colorBg = Color.fromRGBO(184, 28, 33, 72);
        _colorInfo = Color.fromRGBO(82, 12, 15, 32);
        _colorCard = Color.fromRGBO(145, 22, 26, 57);
        _colorText = Colors.grey.shade100;
        break;
      case 'Hydro':
        _colorBg = Color.fromRGBO(8, 174, 255, 100);
        _colorInfo = Color.fromRGBO(4, 86, 128, 50);
        _colorCard = Color.fromRGBO(6, 138, 204, 80);
        _colorText = Colors.grey.shade100;
        break;
      default:
        _colorBg = Color.fromRGBO(158, 105, 220, 86);
        _colorInfo = Color.fromRGBO(66, 44, 92, 26);
        _colorCard = Color.fromRGBO(122, 81, 168, 66);
        _colorText = Colors.grey.shade100;
    }
  }
}

