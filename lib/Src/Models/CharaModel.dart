import 'dart:convert';

CharactersInfo charactersInfoFromJson(String str){
  return CharactersInfo.fromJson(json.decode(str));
}

String charactersInfoToJson(CharactersInfo data){
  return json.encode(data.toJson());
}

class CharactersInfo {
  CharactersInfo({
    this.name,
    this.vision,
    this.weapon,
    this.nation,
    this.affiliation,
    this.rarity,
    this.constellation,
    this.birthday,
    this.description,
    this.skillTalents,
    this.passiveTalents,
    this.constellations,
    this.visionKey,
    this.weaponType,
  });

  String? name;
  String? vision;
  String? weapon;
  String? nation;
  String? affiliation;
  int? rarity;
  String? constellation;
  DateTime? birthday;
  String? description;
  List<SkillTalent>? skillTalents;
  List<Constellation>? passiveTalents;
  List<Constellation>? constellations;
  String? visionKey;
  String? weaponType;

  factory CharactersInfo.fromJson(Map<String, dynamic> json) => CharactersInfo(
    name: json["name"] == null ? null : json["name"],
    vision: json["vision"] == null ? null : json["vision"],
    weapon: json["weapon"] == null ? null : json["weapon"],
    nation: json["nation"] == null ? null : json["nation"],
    affiliation: json["affiliation"] == null ? null : json["affiliation"],
    rarity: json["rarity"] == null ? null : json["rarity"],
    constellation: json["constellation"] == null ? null : json["constellation"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    description: json["description"] == null ? null : json["description"],
    skillTalents: json["skillTalents"] == null ? null : List<SkillTalent>.from(json["skillTalents"].map((x) => SkillTalent.fromJson(x))),
    passiveTalents: json["passiveTalents"] == null ? null : List<Constellation>.from(json["passiveTalents"].map((x) => Constellation.fromJson(x))),
    constellations: json["constellations"] == null ? null : List<Constellation>.from(json["constellations"].map((x) => Constellation.fromJson(x))),
    visionKey: json["vision_key"] == null ? null : json["vision_key"],
    weaponType: json["weapon_type"] == null ? null : json["weapon_type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "vision": vision == null ? null : vision,
    "weapon": weapon == null ? null : weapon,
    "nation": nation == null ? null : nation,
    "affiliation": affiliation == null ? null : affiliation,
    "rarity": rarity == null ? null : rarity,
    "constellation": constellation == null ? null : constellation,
    "birthday": birthday == null ? null : "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
    "description": description == null ? null : description,
    "skillTalents": skillTalents == null ? null : List<dynamic>.from(skillTalents!.map((x) => x.toJson())),
    "passiveTalents": passiveTalents == null ? null : List<dynamic>.from(passiveTalents!.map((x) => x.toJson())),
    "constellations": constellations == null ? null : List<dynamic>.from(constellations!.map((x) => x.toJson())),
    "vision_key": visionKey == null ? null : visionKey,
    "weapon_type": weaponType == null ? null : weaponType,
  };
}

class Constellation {
  Constellation({
    this.name,
    this.unlock,
    this.description,
    this.level,
  });

  String? name;
  String? unlock;
  String? description;
  int? level;

  factory Constellation.fromJson(Map<String, dynamic> json) => Constellation(
    name: json["name"] == null ? null : json["name"],
    unlock: json["unlock"] == null ? null : json["unlock"],
    description: json["description"] == null ? null : json["description"],
    level: json["level"] == null ? null : json["level"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "unlock": unlock == null ? null : unlock,
    "description": description == null ? null : description,
    "level": level == null ? null : level,
  };
}

class SkillTalent {
  SkillTalent({
    this.name,
    this.unlock,
    this.description,
    this.upgrades,
    this.type,
  });

  String? name;
  String? unlock;
  String? description;
  List<Upgrade>? upgrades;
  String? type;

  factory SkillTalent.fromJson(Map<String, dynamic> json) => SkillTalent(
    name: json["name"] == null ? null : json["name"],
    unlock: json["unlock"] == null ? null : json["unlock"],
    description: json["description"] == null ? null : json["description"],
    upgrades: json["upgrades"] == null ? null : List<Upgrade>.from(json["upgrades"].map((x) => Upgrade.fromJson(x))),
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "unlock": unlock == null ? null : unlock,
    "description": description == null ? null : description,
    "upgrades": upgrades == null ? null : List<dynamic>.from(upgrades!.map((x) => x.toJson())),
    "type": type == null ? null : type,
  };
}

class Upgrade {
  Upgrade({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory Upgrade.fromJson(Map<String, dynamic> json) => Upgrade(
    name: json["name"] == null ? null : json["name"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "value": value == null ? null : value,
  };
}