import 'package:flutter/material.dart';
import 'package:weatherlight_db_update/services/commander_api.dart';

import '../model/commander.dart';
import '../services/mongo_service.dart';
import 'commander_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Commander> commanders = [];
  List<Commander> filteredCommanders = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCards();
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
      body: ListView.builder(
        itemCount: filteredCommanders.length,
        itemBuilder: (context, index) {
          final card = filteredCommanders[index];
          final name = card.name;
          final typeLine = card.typeLine;
          final imageUrl = card.imageUris?.artCrop ??
              (card.cardFaces?.isNotEmpty == true
                  ? card.cardFaces![0].imageUris.artCrop
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
        onPressed: () {
          _sendDataToMongoDB();
        },
        child: const Icon(Icons.send),
      ),
    );
  }

  Future<void> fetchCards() async {
    //final response = await CardApi.fetchCards();
    final response = await CardApi.getCommanders();
    setState(() {
      commanders = response;
      filteredCommanders = commanders;
    });
  }

  Future<void> _sendDataToMongoDB() async {
    try {
      if (commanders.isNotEmpty) {
        final firstCommanderName = commanders.first.name;
        await MongoService.sendDataToMongoDB(firstCommanderName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data sent to MongoDB: $firstCommanderName')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending data to MongoDB')),
      );
    }
  }
}

class CommanderSearchDelegate extends SearchDelegate {
  final List<Commander> commanders;

  CommanderSearchDelegate(this.commanders);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(query);
  }

  Widget _buildSearchResults(String query) {
    final lowercaseQuery = query.toLowerCase();

    final searchResults = commanders.where((commander) =>
        commander.name.toLowerCase().contains(lowercaseQuery) ||
        commander.typeLine.toLowerCase().contains(lowercaseQuery));

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final card = searchResults.elementAt(index);
        final name = card.name;
        final typeLine = card.typeLine;
        final imageUrl = card.imageUris?.artCrop ??
            (card.cardFaces?.isNotEmpty == true
                ? card.cardFaces![0].imageUris.artCrop
                : null);
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(imageUrl!),
          ),
          title: Text(name),
          subtitle: Text(typeLine),
          onTap: () {
            close(context, null);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CommanderDetail(
                  commander: card,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
