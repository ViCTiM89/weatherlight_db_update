import 'image_uris.dart';

class CardFace {
  final String name;
  final String typeLine;
  final ImageUris imageUris;

  final String? power;
  final String? toughness;
  final String? loyalty;
  final String? manaCost;
  final String? oracleText;

  CardFace({
    required this.name,
    required this.typeLine,
    required this.imageUris,

    this.power,
    this.toughness,
    this.loyalty,
    this.manaCost,
    this.oracleText,
  });


  factory CardFace.fromJson(Map<String, dynamic> json) {
    return CardFace(
      name: json['name'],
      typeLine: json['type_line'],
      power: json['power'],
      toughness: json['toughness'],
      loyalty: json['loyalty'],
      imageUris: ImageUris.fromMap(json['image_uris']),
      manaCost: json['mana_cost'],
      oracleText: json['oracle_text']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type_line': typeLine,
      'power': power,
      'toughness': toughness,
      'loyalty': loyalty,
      'image_uris': imageUris.toMap(), // Assuming toMap method is defined in your ImageUris class
      'mana_cost': manaCost,
      'oracle_text': oracleText,
    };
  }

}
