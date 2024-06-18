import 'dart:math';

import 'package:agnostiko_test/constants/difficulty_levels.dart';
import 'package:agnostiko_test/enums/difficulty.enum.dart';
import 'package:agnostiko_test/enums/result.enum.dart';
import 'package:agnostiko_test/models/difficulty_levels.model.dart';
import 'package:agnostiko_test/models/history_numbers.model.dart';
import 'package:agnostiko_test/models/range_level.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GuessTheNumberController extends GetxController {
  RxInt currentAttempts = 5.obs;
  RxInt randomNumber = 0.obs;
  RxDouble valueSlider = 0.0.obs;
  Rx<DifficultyLevelsModel> currentDifficultyLevel = DifficultyLevelsModel(
    attempts: 5,
    difficulty: Difficulty.easy,
    nameOfDifficulty: 'Fácil',
    rangeLevelModel: RangeLevelModel(max: 0, min: 10)
  ).obs;

 

  FocusNode numberFocusNode = FocusNode();

  Rx<Color> cursorColor = Colors.blue.obs;
  Rx<Color> focusColor = Colors.white.obs;
  Rx<Color> borderSideColor = Colors.white.obs;
  Rx<Color> textColor = Colors.white.obs;
  Rx<Color> labelTextColor = Colors.white.obs;

  RxList<int> minorNumbers = <int>[].obs;

  RxList<int> largerNumbers = <int>[].obs;

  RxList<HistoryNumbersModel> historyNumbers = <HistoryNumbersModel>[].obs;

  initVariables() {
    
    numberFocusNode.addListener(() { 
      if(numberFocusNode.hasFocus) {
        focusColor.value = Colors.blue;
        labelTextColor.value = Colors.blue;
        borderSideColor.value = Colors.blue;
      }
      else {
        focusColor.value = Colors.white;
        labelTextColor.value = Colors.white;
        borderSideColor.value = Colors.white;
      }
    });
    

  }

  changeDifficulty(double value) {
    valueSlider.value = value;
    currentDifficultyLevel.value = DifficultyLevelsConstant().difficultyLevelsModel[value.toInt()];
    currentAttempts.value = currentDifficultyLevel.value.attempts;
    _restartGame();
    _generateRandomNumber();

  }


  
  tryToGuessNumber (String value) {

    if(!_validateNumber(value)) {
      return false;
    }
    if(!_validateScaleNumber(int.parse(value))) {
      return false;
    }

    _addNumber(int.parse(value));

  }

  bool _validateNumber(String number) {

    RegExp expNumbers = RegExp(r'[0-9]+');

    if(!expNumbers.hasMatch(number)){
      showAlert(
        title: 'Número no válido',
        message: 'Debe ingresar un número valido.',
        duration: const Duration(seconds: 4)
      );
      return false;
    }

    return true;

  }

  bool _validateScaleNumber (int number) {

    int minValueRange = currentDifficultyLevel.value.rangeLevelModel.min;
    int maxValueRange = currentDifficultyLevel.value.rangeLevelModel.max;

    if(
      number > maxValueRange ||
      number < minValueRange
    ){

      showAlert(
        title: 'Número fuera de rango',
        message: 'Debe colocar un número entre un rango mínimo de $minValueRange hasta un rango máximo de $maxValueRange.',
        duration: const Duration(seconds: 6)
      );
      return false;
    }

    return true;
  }

  _addNumber(int number) {

    currentDifficultyLevel.value.attempts -= 1;
    

    if(currentDifficultyLevel.value.attempts == 0) {
      historyNumbers.add(HistoryNumbersModel(
        result: Result.losser, 
        color: Colors.red, 
        numberHistory: number
      ));
      _restartGame();
      _generateRandomNumber();
    }

    else{

      if(number > randomNumber.value) {
        largerNumbers.add(number);
        largerNumbers.refresh();
      }

      else if(number <  randomNumber.value) {
        minorNumbers.add(number);
        minorNumbers.refresh();
      }

      else if(number == randomNumber.value) {
        historyNumbers.add(HistoryNumbersModel(
          result: Result.winner, 
          color: Colors.green, 
          numberHistory: number
        ));
        historyNumbers.refresh();
        _restartGame();
        _generateRandomNumber();
      }

    }

  }

  _generateRandomNumber() {
    int maxValueRange =  currentDifficultyLevel.value.rangeLevelModel.max;
    int minValueRange =  currentDifficultyLevel.value.rangeLevelModel.min;
    randomNumber.value = Random().nextInt(maxValueRange + minValueRange) + minValueRange;
  }

  _restartGame() {
    largerNumbers.value = [];
    largerNumbers.refresh();
    minorNumbers.value = [];
    minorNumbers.refresh();
    currentDifficultyLevel.value = DifficultyLevelsConstant().difficultyLevelsModel[valueSlider.toInt()];
  
  }
  


   showAlert({
    required String title,
    required String message,
    required Duration duration
  })  {
     Get.snackbar(
      duration:  duration,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      title, 
      message
    );
  }

}