import 'dart:convert';
import 'package:http/http.dart';
import '../model/commander.dart';

class CardApi {
  static String urlExactlyOneCard =
      'https://api.scryfall.com/cards/search?q=zhulodok';
  static String urlNormalDoubleFaced =
      'https://api.scryfall.com/cards/search?q=nicol+bolas+t%3Acreature';
  static String urlHasMore =
      'https://api.scryfall.com/cards/search?q=t%3Aplaneswalker';

  static Future<List<Commander>> getCommanders(String apiUrl) async {
    String next = apiUrl;
    bool moreCards = false;
    final uri = Uri.parse(next);
    Response res = await get(uri);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['data'];
      next = jsonDecode(res.body)['next_page'] ?? '';
      Uri nextUri = Uri.parse(next);
      moreCards = jsonDecode(res.body)['has_more'];
      List<Commander> commanders =
          body.map((dynamic item) => Commander.fromMap(item)).toList();

      while (moreCards) {
        Future.delayed(const Duration(milliseconds: 200));
        res = await get(nextUri);
        body = jsonDecode(res.body)['data'];
        next = jsonDecode(res.body)['next_page'] ?? '';
        moreCards = jsonDecode(res.body)['has_more'];
        commanders.addAll(
            body.map((dynamic item) => Commander.fromMap(item)).toList());
      }

      return commanders;
    } else {
      throw "Can't get Commanders.";
    }
  }
}
