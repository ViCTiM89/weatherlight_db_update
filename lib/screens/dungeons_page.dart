import 'package:flutter/material.dart';
import 'package:weatherlight_db_update/services/commander_api.dart';
import '../model/commander.dart';
import '../services/mongo_service.dart';
import '../utils/commander_search_delegate.dart';
import '../utils/mognodb_uploader.dart';
import 'commander_details.dart';

class DungeonsScreen extends StatefulWidget {
  const DungeonsScreen({super.key});

  @override
  State<DungeonsScreen> createState() => _DungeonsScreenState();
}

class _DungeonsScreenState extends State<DungeonsScreen> {
  List<Commander> dungeons = [];
  List<Commander> filteredDungeons = [];
  bool isLoading = true; // Indicator for page loading
  bool isUploading = false; // Indicator for uploading to DB

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCards();
    MongoService.init("Dungeons");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dungeons found: ${dungeons.length}'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CommanderSearchDelegate(dungeons),
              );
            },
          ),
        ],
      ),
      body: isLoading // Show loading indicator when fetching data
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filteredDungeons.length,
        itemBuilder: (context, index) {
          final card = filteredDungeons[index];
          final name = card.name;
          final typeLine = card.typeLine;
          final imageUrl = card.imageUris?.artCrop ??
              (card.cardFaces?.isNotEmpty == true
                  ? card.cardFaces![0].imageUris?.artCrop
                  : null);

          return ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(imageUrl!)),
            title: Text(name),
            subtitle: Text(typeLine),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CommanderDetail(
                commander: card,
              ),
            )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isUploading
            ? null // Disable button when uploading
            : () async {
          setState(() {
            isUploading = true;
          });
          await MongodbUploader.sendDataToMongoDB(context, dungeons);
          setState(() {
            isUploading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data uploaded successfully!')),
          );
        },
        child: isUploading
            ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : const Icon(Icons.send),
      ),
    );
  }

  Future<void> fetchCards() async {
    setState(() {
      isLoading = true; // Start loading indicator
    });
    final response = await CardApi.getCommanders(CardApi.urlAlldungeons);
    setState(() {
      dungeons = response;
      filteredDungeons = dungeons;
      isLoading = false; // Stop loading indicator
    });
  }
}
