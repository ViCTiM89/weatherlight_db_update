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
  static String urlBannedCommanders =
      'https://api.scryfall.com/cards/search?q=t%3Alegendary+t%3Acreature+banned%3Acommander';
  static String urlPlaneswalkers =
      'https://api.scryfall.com/cards/search?q=t%3Aplaneswalker+o%3Acommander';
  static String urlCreatures =
      'https://api.scryfall.com/cards/search?q=t%3Aplaneswalker+or+t%3Avehicle';

  static String urlAllCommanders =
      'https://api.scryfall.com/cards/search?q=(game%3Apaper)+(legal%3Acommander+or+banned%3Acommander)+((t%3Alegendary+t%3Acreature)+or+(t%3Abackground)+or+(t%3Aplaneswalker+o%3Acommander)+or+(-type%3Abattle+-type%3Aland+t%3Avehicle+t%3Alegendary))';
  static String urlAllDungeons =
      'https://api.scryfall.com/cards/search?q=t%3Adungeon';
  static String urlAllPlanes =
      'https://api.scryfall.com/cards/search?q=t%3Aplane';

  // Method to fetch commanders with headers
  static Future<List<Commander>> getCommanders(String apiUrl) async {
    String next = apiUrl;
    bool moreCards = false;
    Uri uri = Uri.parse(next);

    // Define headers for the request
    final headers = {
      'User-Agent':
          'Weatherlight/0.7', // Replace with your app name and version
      'Accept':
          'application/json;q=0.9,*/*;q=0.8', // Accept header with generic preference
    };

    Response res = await get(uri, headers: headers);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['data'];
      next = jsonDecode(res.body)['next_page'] ?? '';
      moreCards = jsonDecode(res.body)['has_more'];
      List<Commander> commanders =
          body.map((dynamic item) => Commander.fromMap(item)).toList();

      while (moreCards) {
        // Delay to avoid overwhelming the API server
        await Future.delayed(const Duration(milliseconds: 100));

        // Update URI with the new 'next' page URL
        uri = Uri.parse(next);
        res = await get(uri, headers: headers);

        if (res.statusCode != 200) {
          throw "Error fetching next page.";
        }

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
