import 'package:flutter/material.dart';

import '../model/commander.dart';
import '../screen/commander_details.dart';

class CommanderSearchDelegate extends SearchDelegate {
  final List<Commander> cards;

  CommanderSearchDelegate(this.cards);

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

    final searchResults = cards.where((commander) =>
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