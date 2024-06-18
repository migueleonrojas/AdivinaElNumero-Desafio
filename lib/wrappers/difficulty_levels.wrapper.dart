import 'package:agnostiko_test/models/difficulty_levels.model.dart';

class DifficultyLevelWrapper {

  DifficultyLevelsModel difficultyLevels;

  DifficultyLevelWrapper({required this.difficultyLevels});

  set setDifficultyLevel(DifficultyLevelsModel newDifficultyLevels) {
    difficultyLevels = newDifficultyLevels;
  }

  get () => difficultyLevels;

}