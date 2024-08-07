import 'card_faces.dart';
import 'image_uris.dart';
import 'legalities.dart';

class Commander {
  final String id;
  final String name;
  final String typeLine;
  final String layout;
  final List<String> colorIdentity;
  final List<CardFace>? cardFaces;
  //nullable
  final ImageUris? imageUris;
  final Legalities legalities;
  final String? power;
  final String? toughness;
  final String? loyalty;
  final String? manaCost;
  final String? oracleText;
  final List<String>? keyWords;
  //additional fields

  Commander({
    required this.id,
    required this.name,
    required this.typeLine,
    required this.layout,
    required this.colorIdentity,
    required this.legalities,
    //nullable
    this.imageUris,
    this.power,
    this.toughness,
    this.loyalty,
    this.cardFaces,
    this.manaCost,
    this.oracleText,
    this.keyWords,
    //additional
  });

  factory Commander.fromMap(Map<String, dynamic> json) {
    return Commander(
      id: json['id'],
      name: json['name'],
      typeLine: json['type_line'],
      power: json['card_faces'] == null ? json['power'] : null,
      toughness: json['card_faces'] == null ? json['toughness'] : null,
      loyalty: json['card_faces'] == null ? json['loyalty'] : null,
      manaCost: json['card_faces'] == null ? json['mana_cost'] : null,
      oracleText: json['card_faces'] == null ? json['oracle_text'] : null,
      layout: json['layout'],
      imageUris: json['image_uris'] != null
          ? ImageUris.fromMap(json['image_uris'])
          : null,
      legalities: Legalities.fromJson(json['legalities']),
      colorIdentity: List<String>.from(json['color_identity']),
      keyWords: List<String>.from(json['keywords']),
      cardFaces: json['card_faces'] != null
          ? List<CardFace>.from(
          json['card_faces'].map((face) => CardFace.fromJson(face)))
          : null,
      //additional
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type_line': typeLine,
      'layout': layout,
      'color_identity': colorIdentity,
      'legalities': legalities.toJson(),
      'image_uris': imageUris
          ?.toMap(),
      'power': power,
      'toughness': toughness,
      'loyalty': loyalty,
      'card_faces': cardFaces
          ?.map((face) => face.toJson())
          .toList(),
      'mana_cost': manaCost,
      'oracle_text': oracleText,
      'keywords': keyWords,
    };
  }
}
