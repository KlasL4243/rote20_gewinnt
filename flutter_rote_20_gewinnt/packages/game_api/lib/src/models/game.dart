import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

final Map rules_defaults = {
  "points": { "round_win": 1, "bet_win": 10, "bet_lose": -5 },
  "max_cards": 7
};


@JsonSerializable()
class Game extends Equatable {
  Game({
    required String? game_name,
    String? game_uuid,
    DateTime? start_time,
    bool? finished,
    Map? rules,
    Map? rounds,
  }) : game_name = game_name ?? "game1",
       game_uuid = game_uuid ?? const Uuid().v4(),
       start_time = start_time ?? DateTime.now(),
       finished = finished ?? false,
       rules = rules ?? rules_defaults,
       rounds = rounds ?? {};
       // TODO: i stopped here last time


  final String game_name;
  final game_uuid;
  final DateTime start_time;
  final bool finished;
  final Map rules;
  final Map rounds;

  @override
  List<Object?> get props => [game_name]; // TODO: implement props
}