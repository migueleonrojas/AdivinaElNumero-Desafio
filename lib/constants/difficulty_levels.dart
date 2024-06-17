import 'package:agnostiko_test/enums/difficulty.enum.dart';
import 'package:agnostiko_test/models/difficulty_levels.model.dart';
import 'package:agnostiko_test/models/range_level.model.dart';

class DifficultyLevelsConstant {

  static final List<DifficultyLevelsModel> difficultyLevelsModel = [
    DifficultyLevelsModel(
      difficulty: Difficulty.easy,
      nameOfDifficulty: 'Fácil',
      rangeLevelModel: RangeLevelModel(max: 1, min: 10),
      attempts: 5,
    ),
    DifficultyLevelsModel(
      difficulty: Difficulty.medium,
      nameOfDifficulty: 'Medio',
      rangeLevelModel: RangeLevelModel(max: 1, min: 20),
      attempts: 8,
    ),
    DifficultyLevelsModel(
      difficulty: Difficulty.avanced,
      nameOfDifficulty: 'Avanzado',
      rangeLevelModel: RangeLevelModel(max: 1, min: 100),
      attempts: 15,
    ),
    DifficultyLevelsModel(
      difficulty: Difficulty.extreme,
      nameOfDifficulty: 'Extremo',
      rangeLevelModel: RangeLevelModel(max: 1, min: 1000),
      attempts: 25,
    ),
  ];
  
}