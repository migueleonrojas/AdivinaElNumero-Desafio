import 'dart:convert';
import 'package:agnostiko_test/enums/difficulty.enum.dart';
import 'package:agnostiko_test/models/range_level.model.dart';

DifficultyLevelsModel difficultyLevelsModelFromJson(String str) => DifficultyLevelsModel.fromJson(json.decode(str));

String difficultyLevelsModelToJson(DifficultyLevelsModel data) => json.encode(data.toJson());

class DifficultyLevelsModel {
    Difficulty difficulty;
    String nameOfDifficulty;
    RangeLevelModel rangeLevelModel;
    int attempts;

    DifficultyLevelsModel({
        required this.difficulty,
        required this.nameOfDifficulty,
        required this.rangeLevelModel,
        required this.attempts
    });

    factory DifficultyLevelsModel.fromJson(Map<String, dynamic> json) => DifficultyLevelsModel(
        difficulty: json["difficulty"],
        nameOfDifficulty: json["nameOfDifficulty"],
        rangeLevelModel: json["rangeLevelModel"],
        attempts: json["attempts"]
    );

    Map<String, dynamic> toJson() => {
        "difficulty": difficulty,
        "nameOfDifficulty": nameOfDifficulty,
        "rangeLevelModel": rangeLevelModel,
        "attempts": attempts
    };
}