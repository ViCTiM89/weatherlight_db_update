class Legalities {
  final String standard;
  final String modern;
  final String legacy;
  final String pauper;
  final String commander;
  final String oathbreaker;
  final String brawl;
  final String pauperCommander;
  final String duel;

  Legalities({
    required this.standard,
    required this.modern,
    required this.legacy,
    required this.pauper,
    required this.commander,
    required this.oathbreaker,
    required this.brawl,
    required this.pauperCommander,
    required this.duel,
  });

  factory Legalities.fromJson(Map<String, dynamic> json) {
    return Legalities(
      standard: json['standard'],
      modern: json['modern'],
      legacy: json['legacy'],
      pauper: json['pauper'],
      commander: json['commander'],
      oathbreaker: json['oathbreaker'],
      brawl: json['brawl'],
      pauperCommander: json['paupercommander'],
      duel: json['duel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'standard': standard,
      'modern': modern,
      'legacy': legacy,
      'pauper': pauper,
      'commander': commander,
      'oathbreaker': oathbreaker,
      'brawl': brawl,
      'paupercommander': pauperCommander,
      'duel': duel,
    };
  }
}
