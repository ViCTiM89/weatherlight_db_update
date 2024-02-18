import 'package:http/http.dart';

import '../model/commander.dart';

class MongoService {
  //static const String apiUrl = 'your_mongo_api_url'; // Replace with your MongoDB API URL
  static const apiUrl = "mongodb+srv://dbUser:\$v+vnhMjBp6&gE9@commander.ylxb6fw.mongodb.net/?retryWrites=true&w=majority";

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

