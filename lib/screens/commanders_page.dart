import 'package:flutter/material.dart';
import 'package:weatherlight_db_update/services/commander_api.dart';
import '../model/commander.dart';
import '../services/mongo_service.dart';
import '../utils/commander_search_delegate.dart';
import '../utils/mognodb_uploader.dart';
import 'commander_details.dart';

class CommanderScreen extends StatefulWidget {
  const CommanderScreen({super.key});

  @override
  State<CommanderScreen> createState() => _CommanderScreenState();
}

class _CommanderScreenState extends State<CommanderScreen> {
  List<Commander> commanders = [];
  List<Commander> filteredCommanders = [];
  bool isLoading = true; // Indicator for page loading
  bool isUploading = false; // Indicator for uploading to DB

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCards();
    MongoService.init("Commanders");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commanders found: ${commanders.length}'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CommanderSearchDelegate(commanders),
              );
            },
          ),
        ],
      ),
      body: isLoading // Show loading indicator when fetching data
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filteredCommanders.length,
        itemBuilder: (context, index) {
          final card = filteredCommanders[index];
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
          await MongodbUploader.sendDataToMongoDB(context, commanders);
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
    final response = await CardApi.getCommanders(CardApi.urlAllCommanders);
    setState(() {
      commanders = response;
      filteredCommanders = commanders;
      isLoading = false; // Stop loading indicator
    });
  }
}
