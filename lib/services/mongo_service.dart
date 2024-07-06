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
    List<Map<String, Object>> bulkOps = [];

    for (var commander in commanders) {
      bulkOps.add({
        'updateOne': {
          'filter': {'id': commander.id},
          'update': {'\$set': commander.toMap()},
          'upsert': true
        }
      });
    }

    if (bulkOps.isNotEmpty) {
      await _commanderCollection.bulkWrite(bulkOps);
    }
  }
}
