import 'package:flutter/material.dart';
import 'package:genshin_impact/Src/Constants/Constants.dart';
import 'package:genshin_impact/Src/Models/CharaArgument.dart';
import 'package:genshin_impact/Src/Models/CharaModel.dart';
import 'package:genshin_impact/Src/Services/Service.dart' as services;

class HomeGenshin extends StatefulWidget {
  const HomeGenshin({Key? key}) : super(key: key);

  @override
  State<HomeGenshin> createState() => _HomeGenshinState();
}

class _HomeGenshinState extends State<HomeGenshin> {
  final _api = services.GenshinService();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
                       //image: AssetImage(
                         //'assets/bg.jpg',
                       //),
                       fit: BoxFit.fill,
              image: NetworkImage(
                'https://pbs.twimg.com/media/FWAh8FQUIAEor8E?format=jpg&name=4096x4096',
              )
                     ),
        ),
        child: FutureBuilder(
            future: _api.getAllCharacters(),
            builder: (context, AsyncSnapshot<List<String>?> snapshot) {
              if( snapshot.hasError ){
                return Center(
                    child: Text(
                        'Error',
                    ),
                );
              }else{
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.data!.isNotEmpty){
                    return _card(snapshot.data!);
                  }else{
                    return Center(
                      child: Text(
                          'Empty'
                      ),
                    );
                  }
                }else{
                  return Center(
                      child: CircularProgressIndicator(),
                  );
                }
              }
            }
        ),
      )
    );
  }

  Widget _card(List<String>characters){
    double width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((context,index){
            final character = characters[index];
            bool traveler = false;
            if(character.contains('traveler-')){
              traveler = true;
            }
            return FutureBuilder(
              future: _api.getInfoCharacter(character),
              builder: (BuildContext context,AsyncSnapshot<CharactersInfo?> snapshot){
                if(snapshot.hasError){
                  return Center(
                    child: Text(
                      'Error',
                    ),
                  );
                }else{
                  if(snapshot.connectionState == ConnectionState.done){
                    CharacterArguments _arguments = new CharacterArguments(
                        character: character,
                        info: snapshot.data!
                    );
                    return InkWell(
                        onTap: (){
                          Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: _arguments
                          );
                        },
                        child: Container(
                          height: 190,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent
                          ),
                          child: Stack(
                              children: [
                                Positioned(
                                    left: width*0.05,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 180,
                                        width: width*0.9,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                 //image: AssetImage('assets/bgCard.jpeg'),
                                                 fit: BoxFit.fitWidth,
                                                image: NetworkImage(
                                                  'https://pbs.twimg.com/media/FWAh8FQUIAEor8E?format=jpg&name=4096x4096',
                                                )
                                             ),
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: [new BoxShadow(
                                                color: Colors.black.withOpacity(1),
                                                offset: new Offset(-10, 10),
                                                blurRadius: 20,
                                                spreadRadius: 4
                                            )]
                                        ),
                                      ),

                                    )
                                ),
                                Positioned(
                                  top: 10,
                                  left: width*0.075,
                                  child: Card(
                                      color: Colors.transparent,
                                      elevation: 10,
                                      shadowColor: Colors.grey.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Container(
                                        height: 150,
                                        width: 126,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(Strings().iconBig(character, traveler))
                                            )
                                        ),
                                      )
                                  ),
                                ),
                                _info(snapshot.data!),

                              ]
                          ),
                        )
                    );
                  }else{
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CircularProgressIndicator(
                          color: Colors.amber.shade400,
                        ),
                      ),
                    );
                  }
                }
              }
            );
          },
            childCount: characters.length,
          ),
        )
      ],
    );
  }
  Widget _info(CharactersInfo character){
    double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: 20,
        left: width*0.075 + 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              character.name!,
              style: TextStyle(
                  fontFamily: 'GenshinFont',
                  fontSize: 17,
                  color: Colors.white
              ),
            ),
            _rarity(character.rarity!),
            Image.network(
              Strings().iconElement(character.vision!.toLowerCase()),
            ),
            Text(
              character.vision! + ' • ' + character.weapon!,
              style: TextStyle(
                  fontFamily: 'GenshinFont',
                  fontSize: 17,
                  color: Colors.white
              ),
            ),


          ],
        )
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
}