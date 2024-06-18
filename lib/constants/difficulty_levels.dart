import 'package:agnostiko_test/enums/difficulty.enum.dart';
import 'package:agnostiko_test/models/difficulty_levels.model.dart';
import 'package:agnostiko_test/models/range_level.model.dart';

class DifficultyLevelsConstant {


  get difficultyLevelsModel => _difficultyLevelsModel;


  final List<DifficultyLevelsModel> _difficultyLevelsModel = [
    DifficultyLevelsModel(
      difficulty: Difficulty.easy,
      nameOfDifficulty: 'Fácil',
      rangeLevelModel: RangeLevelModel(min: 1, max: 10),
      attempts: 5,
    ),
    DifficultyLevelsModel(
      difficulty: Difficulty.medium,
      nameOfDifficulty: 'Medio',
      rangeLevelModel: RangeLevelModel(min: 1, max: 20),
      attempts: 8,
    ),
    DifficultyLevelsModel(
      difficulty: Difficulty.advanced,
      nameOfDifficulty: 'Avanzado',
      rangeLevelModel: RangeLevelModel(min: 1, max: 100),
      attempts: 15,
    ),
    DifficultyLevelsModel(
      difficulty: Difficulty.extreme,
      nameOfDifficulty: 'Extremo',
      rangeLevelModel: RangeLevelModel(min: 1, max: 1000),
      attempts: 25,
    ),
  ];
  
}