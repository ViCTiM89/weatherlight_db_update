class Legalities {
  final String standard;
  final String future;
  final String historic;
  final String gladiator;
  final String pioneer;
  final String explorer;
  final String modern;
  final String legacy;
  final String pauper;
  final String vintage;
  final String penny;
  final String commander;
  final String oathbreaker;
  final String brawl;
  final String standardBrawl;
  final String alchemy;
  final String pauperCommander;
  final String duel;
  final String oldSchool;
  final String preModern;
  final String preDH;

  Legalities({
    required this.standard,
    required this.future,
    required this.historic,
    required this.gladiator,
    required this.pioneer,
    required this.explorer,
    required this.modern,
    required this.legacy,
    required this.pauper,
    required this.vintage,
    required this.penny,
    required this.commander,
    required this.oathbreaker,
    required this.brawl,
    required this.standardBrawl,
    required this.alchemy,
    required this.pauperCommander,
    required this.duel,
    required this.oldSchool,
    required this.preModern,
    required this.preDH,
  });

  factory Legalities.fromJson(Map<String, dynamic> json) {
    return Legalities(
      standard: json['standard'],
      future: json['future'],
      historic: json['historic'],
      gladiator: json['gladiator'],
      pioneer: json['pioneer'],
      explorer: json['explorer'],
      modern: json['modern'],
      legacy: json['legacy'],
      pauper: json['pauper'],
      vintage: json['vintage'],
      penny: json['penny'],
      commander: json['commander'],
      oathbreaker: json['oathbreaker'],
      brawl: json['brawl'],
      standardBrawl: json['standardbrawl'],
      alchemy: json['alchemy'],
      pauperCommander: json['paupercommander'],
      duel: json['duel'],
      oldSchool: json['oldschool'],
      preModern: json['premodern'],
      preDH: json['predh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'standard': standard,
      'future': future,
      'historic': historic,
      'gladiator': gladiator,
      'pioneer': pioneer,
      'explorer': explorer,
      'modern': modern,
      'legacy': legacy,
      'pauper': pauper,
      'vintage': vintage,
      'penny': penny,
      'commander': commander,
      'oathbreaker': oathbreaker,
      'brawl': brawl,
      'historicBrawl': standardBrawl,
      'alchemy': alchemy,
      'pauperCommander': pauperCommander,
      'duel': duel,
      'oldSchool': oldSchool,
      'preModern': preModern,
      'preDH': preDH,
    };
  }
}
