import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:weatherlight_db_update/model/card_faces.dart';

import '../model/commander.dart';
import '../model/image_uris.dart';

class CardApi {
  //static String url = 'https://api.scryfall.com/cards/search?q=zhulodok'; //exactly 1
  static String url = 'https://api.scryfall.com/cards/search?q=nicol+bolas+t%3Acreature'; //exactly 1 normal, 1 doublefaced
  //static String url = 'https://api.scryfall.com/cards/search?q=t%3Aplaneswalker'; //has_more = true
  //static String url = 'https://api.scryfall.com/cards/search?q=type%3Aurza';

  static Future<List<Commander>> getCommanders() async {
    String next = url;
    bool moreCards = false;
    final uri = Uri.parse(next);
    Response res = await get(uri);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['data'];
      next = jsonDecode(res.body)['next_page']?? '';
      Uri nextUri = Uri.parse(next);
      moreCards = jsonDecode(res.body)['has_more'];
      List<Commander> commanders =
      body.map((dynamic item) => Commander.fromMap(item)).toList();

      while (moreCards) {
        Future.delayed(const Duration(milliseconds: 200));
        res = await get(nextUri);
        body = jsonDecode(res.body)['data'];
        next = jsonDecode(res.body)['next_page']??'';
        moreCards = jsonDecode(res.body)['has_more'];
        commanders.addAll(
            body.map((dynamic item) => Commander.fromMap(item)).toList());
      }

      print(commanders.length);
      return commanders;
    } else {
      throw "Can't get Commanders.";
    }
  }

}
