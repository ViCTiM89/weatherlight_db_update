import 'package:http/http.dart';

import 'api_key.dart';

class MongoService {
 static String apiUrl = apiKey;

  static Future<void> sendDataToMongoDB(String data) async {
    final response = await post(
      Uri.parse(apiUrl),
      body: {'data': data},
    );

    if (response.statusCode == 200) {
      // Data sent successfully
      print('Data sent to MongoDB: $data');
    } else {
      // Handle errors, show an error message, etc.
      print('Error sending data to MongoDB');
    }
  }
}
