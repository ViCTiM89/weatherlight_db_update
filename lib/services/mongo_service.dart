import 'package:mongo_dart/mongo_dart.dart';
import 'package:weatherlight_db_update/services/api_key.dart';
import '../model/commander.dart';

class MongoService {
  static late Db _db;
  static late DbCollection _commanderCollection;

  static Future<void> init() async {
    _db = await Db.create(apiKey);
    await _db.open();
    _commanderCollection = _db.collection('commanders');
  }

  static Future<void> sendDataToMongoDB(List<Commander> commanders) async {
    for (var commander in commanders) {
      await _commanderCollection.update(
        where.eq('id', commander.id),
        commander.toMap(),
        upsert: true,
      );
    }
  }
}
