import 'package:flutter/material.dart';

import '../model/commander.dart';
import '../services/mongo_service.dart';

class MongodbUploader {
   static Future<void> sendDataToMongoDB(BuildContext context, List<Commander> cards) async {
    try {
      if (cards.isNotEmpty) {
        await MongoService.sendDataToMongoDB(cards);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data sent to MongoDB'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending data to MongoDB')),
      );
    }
  }
}
