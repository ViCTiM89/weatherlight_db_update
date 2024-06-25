import 'package:flutter/material.dart';

import '../model/commander.dart';
import '../model/functions.dart';

class CommanderDetail extends StatelessWidget {
  final Commander commander;
  const CommanderDetail({super.key,
    required this.commander,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the card has cardFaces
    bool hasCardFaces =
        commander.cardFaces != null && commander.cardFaces!.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(commander.name),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //CardFront
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        (commander.layout == 'normal' ||
                                commander.layout == 'meld' ||
                                commander.layout == 'saga')
                            ? commander.name
                            : commander.cardFaces![0].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "${commander.wins} Wins",
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        "${commander.games} Games",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    ListTile(
                      title: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(commander.imageUris?.artCrop ??
                            commander.cardFaces![0].imageUris.artCrop),
                      ),
                    ),
                    ListTile(
                      title: Text((commander.layout == 'normal' ||
                              commander.layout == 'meld' ||
                              commander.layout == 'saga')
                          ? commander.typeLine
                          : commander.cardFaces![0].typeLine),
                    ),
                    ListTile(
                      title: Text(
                        commander.manaCost ?? commander.cardFaces![0].manaCost!,
                        textAlign: TextAlign.right,
                      ),
                      subtitle: const Text(
                        "Cost",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(commander.oracleText ??
                          commander.cardFaces![0].oracleText!),
                      subtitle: const Text("Oracle Text"),
                    ),
                    ListTile(
                      title: Text(
                        hasCardFaces
                            ? printPowerOrLoyalty(
                                commander.cardFaces![0].typeLine,
                                commander.cardFaces![0].power,
                                commander.cardFaces![0].toughness,
                                commander.cardFaces![0].loyalty)
                            : printPowerOrLoyalty(
                                commander.typeLine,
                                commander.power,
                                commander.toughness,
                                commander.loyalty),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        (hasCardFaces &&
                                commander.cardFaces![0].typeLine
                                    .toLowerCase()
                                    .contains('creature'))
                            ? "Power/Toughness"
                            : (hasCardFaces &&
                                    commander.cardFaces![0].typeLine
                                        .toLowerCase()
                                        .contains('planeswalker'))
                                ? 'Loaylty'
                                : commander.typeLine
                                        .toLowerCase()
                                        .contains('creature')
                                    ? "Power/Toughness"
                                    : commander.typeLine
                                            .toLowerCase()
                                            .contains('creature')
                                        ? 'Loaylty'
                                        : '',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              //CardBack
              Card(
                child: hasCardFaces
                    ? Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              commander.cardFaces![1].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                  commander.cardFaces![1].imageUris.artCrop),
                            ),
                          ),
                          ListTile(
                            title: Text(commander.cardFaces![1].typeLine),
                            subtitle: const Text("Type"),
                          ),
                          ListTile(
                            title: Text(
                              commander.cardFaces![1].manaCost ?? '',
                              textAlign: TextAlign.right,
                            ),
                            subtitle: const Text(
                              "Cost",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      )
                    : null,
              ),
              Card(
                child: hasCardFaces
                    ? Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              commander.cardFaces?[1].oracleText ?? '',
                            ),
                          ),
                          ListTile(
                            title: Text(commander.cardFaces![1].typeLine),
                            subtitle: const Text("Type"),
                          )
                        ],
                      )
                    : null,
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(commander.colorIdentity.join('')),
                      subtitle: const Text("Color-Identity"),
                    ),
                    ListTile(
                      title: Text(
                          "${capitalizeFirstLetter(commander.legalities.commander)} in Commander"),
                      subtitle: const Text("Legality"),
                    ),
                    ListTile(
                      title: Text(commander.layout),
                      subtitle: const Text("Layout"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.backspace),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
