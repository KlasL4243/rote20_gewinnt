import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rote20_gewinnt/data/manager/manager.dart';
import 'package:rote20_gewinnt/presentation/home/nothing_here.dart';

const textScaler = TextScaler.linear(2);

class Names extends StatefulWidget {
  const Names({super.key});

  static int playerCount = 12;
  static int playerMinCount = 4;

  @override
  State<Names> createState() => _NamesState();
}

class _NamesState extends State<Names> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void goToSettings() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const NothingHere();
          },
        ),
      );
    }

    void validateAndSaveForm() {
      Manager.game.players = [for (int i = 0; i < Names.playerCount; i++) "-"];
      final FormState state = _formKey.currentState!;
      state.save();

      if (!state.validate()) return;

      Manager.game.players.removeWhere((element) => element == "-");
      goToSettings();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Namen"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: validateAndSaveForm,
        child: const Icon(Icons.check),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          semanticChildCount: Names.playerCount,
          children: [
            for (int i = 0; i < Names.playerCount; i++) ...[
              nameFormField(i),
              const SizedBox(height: 5),
            ],
          ],
        ),
      ),
    );
  }
}

TextFormField nameFormField(int index) {
  return TextFormField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.lightBlue[100],
      border: const OutlineInputBorder(),
      hintText: "Spieler ${index + 1}",
    ),
    initialValue: Manager.game.players.elementAtOrNull(index),
    textInputAction: index == (Names.playerCount - 1)
        ? TextInputAction.done
        : TextInputAction.next,
    onSaved: (String? value) {
      if (value!.isEmpty) return;
      Manager.game.players[index] = value;
      log("name$index saved!");
    },
    validator: (String? name) => (name == null || name.isEmpty)
        ? null
        : (Manager.game.players.take(index).contains(name))
            ? "Der Name ist bereits vergeben!"
            : null,
  );
}
