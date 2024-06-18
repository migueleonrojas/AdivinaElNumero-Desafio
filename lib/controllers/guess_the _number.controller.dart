import 'dart:math';
import 'package:agnostiko_test/constants/difficulty_levels.dart';
import 'package:agnostiko_test/enums/result.enum.dart';
import 'package:agnostiko_test/models/difficulty_levels.model.dart';
import 'package:agnostiko_test/models/history_numbers.model.dart';
import 'package:agnostiko_test/wrappers/difficulty_levels.wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GuessTheNumberController extends GetxController {
  final GlobalKey _globalKeyMinorNumbers = GlobalKey();
  GlobalKey get globalKeyMinorNumbers => _globalKeyMinorNumbers;

  final GlobalKey _globalKeyLargerNumbers = GlobalKey();
  GlobalKey get globalKeyLargerNumbers => _globalKeyLargerNumbers;

  final GlobalKey _globalKeyHistoryNumbers = GlobalKey();
  GlobalKey get globalKeyHistoryNumbers => _globalKeyHistoryNumbers;


  final double _heightElementList = Get.size.height * 0.025;
  double get heightElementList => _heightElementList;

  final RxInt _randomNumber = 0.obs;
  RxInt get randomNumber => _randomNumber;

  final RxDouble _valueSlider = 0.0.obs;
  RxDouble get valueSlider => _valueSlider;

  final Rx<DifficultyLevelWrapper> _currentDifficultyLevel = DifficultyLevelWrapper(
    difficultyLevels: DifficultyLevelsConstant().difficultyLevelsModel[0]
  ).obs;
  Rx<DifficultyLevelWrapper> get currentDifficultyLevel => _currentDifficultyLevel;

  final FocusNode _numberFocusNode = FocusNode();
  FocusNode get numberFocusNode => _numberFocusNode;


  final TextEditingController _numberTextEditingController = TextEditingController();
  TextEditingController get numberTextEditingController => _numberTextEditingController;

  final ScrollController _minorNumbersScrollController =  ScrollController();
  ScrollController get minorNumbersScrollController => _minorNumbersScrollController;

  final ScrollController _largerNumbersScrollController = ScrollController();
  ScrollController get largerNumbersScrollController => _largerNumbersScrollController;

  final ScrollController _historyNumberssScrollController = ScrollController();
  ScrollController get historyNumberssScrollController => _historyNumberssScrollController;

  final Rx<Color> _cursorColor = Colors.blue.obs;
  Rx<Color> get cursorColor => _cursorColor;

  final Rx<Color> _focusColor = Colors.white.obs;
  Rx<Color> get focusColor => _focusColor;

  final Rx<Color> _borderSideColor = Colors.white.obs;
  Rx<Color> get borderSideColor => _borderSideColor;

  final Rx<Color> _textColor = Colors.white.obs;
  Rx<Color> get textColor => _textColor;
  
  final Rx<Color> _labelTextColor = Colors.white.obs;
  Rx<Color> get labelTextColor => _labelTextColor;

  final RxList<int> _minorNumbers = <int>[].obs;
  RxList<int> get minorNumbers => _minorNumbers;

  final RxList<int> _largerNumbers = <int>[].obs;
  RxList<int> get largerNumbers => _largerNumbers;

  final RxList<HistoryNumbersModel> _historyNumbers = <HistoryNumbersModel>[].obs;
  RxList<HistoryNumbersModel> get historyNumbers => _historyNumbers;

  initVariables() {
    if(randomNumber.value == 0) {
      _generateRandomNumber();      
    }
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
    numberTextEditingController.clear();
    valueSlider.value = value;
    currentDifficultyLevel.value.difficultyLevels = DifficultyLevelsConstant().difficultyLevelsModel[value.toInt()];
    currentDifficultyLevel.refresh();
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
    RegExp expNumbers = RegExp(r'^[0-9]+$');
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
    int minValueRange = currentDifficultyLevel.value.difficultyLevels.rangeLevelModel.min;
    int maxValueRange = currentDifficultyLevel.value.difficultyLevels.rangeLevelModel.max;
    if(
      number > maxValueRange ||
      number < minValueRange
    ){
      showAlert(
        title: 'Número fuera de rango',
        message: 'Debe colocar un número entre el rango del $minValueRange hasta el $maxValueRange.',
        duration: const Duration(seconds: 7)
      );
      return false;
    }
    return true;
  }

  _addNumber(int number) {

    numberTextEditingController.clear();

    currentDifficultyLevel.value.difficultyLevels = DifficultyLevelsModel(
      attempts: currentDifficultyLevel.value.difficultyLevels.attempts - 1,
      difficulty: currentDifficultyLevel.value.difficultyLevels.difficulty,
      nameOfDifficulty: currentDifficultyLevel.value.difficultyLevels.nameOfDifficulty,
      rangeLevelModel: currentDifficultyLevel.value.difficultyLevels.rangeLevelModel
    );
    
    if(currentDifficultyLevel.value.difficultyLevels.attempts == 0) {
      historyNumbers.add(HistoryNumbersModel(
        result: Result.losser, 
        color: Colors.red, 
        numberHistory: randomNumber.value
      ));
      historyNumbers.refresh();
      _scrollListNumber(
           keyList: globalKeyHistoryNumbers,
           listNumber: historyNumbers,
           scrollControllerList: historyNumberssScrollController
        );
      _restartGame();
      _generateRandomNumber();
    }

    else{
      if(number > randomNumber.value) {
        largerNumbers.add(number);
        largerNumbers.refresh();
        _scrollListNumber(
           keyList: globalKeyLargerNumbers,
           listNumber: largerNumbers,
           scrollControllerList: largerNumbersScrollController
        );
      }

      else if(number <  randomNumber.value) {
        minorNumbers.add(number);
        minorNumbers.refresh();
        _scrollListNumber(
           keyList: _globalKeyMinorNumbers,
           listNumber: minorNumbers,
           scrollControllerList: minorNumbersScrollController
        );
      }

      else if(number == randomNumber.value) {
        historyNumbers.add(HistoryNumbersModel(
          result: Result.winner, 
          color: Colors.green, 
          numberHistory: randomNumber.value
        ));
        historyNumbers.refresh();
        _scrollListNumber(
           keyList: globalKeyHistoryNumbers,
           listNumber: historyNumbers,
           scrollControllerList: historyNumberssScrollController
        );
        _restartGame();
        _generateRandomNumber();
      }
    }
  }

  _generateRandomNumber() {
    int minValueRange =  currentDifficultyLevel.value.difficultyLevels.rangeLevelModel.min;
    int maxValueRange =  currentDifficultyLevel.value.difficultyLevels.rangeLevelModel.max - 1;
    randomNumber.value = Random().nextInt(maxValueRange + minValueRange) + minValueRange;
  }

  _restartGame() {
    largerNumbers.value = [];
    largerNumbers.refresh();
    minorNumbers.value = [];
    minorNumbers.refresh();
    currentDifficultyLevel.value.setDifficultyLevel = DifficultyLevelsConstant().difficultyLevelsModel[valueSlider.value.toInt()];
    currentDifficultyLevel.refresh();
  }

  _scrollListNumber({
    required GlobalKey keyList, 
    required RxList<dynamic> listNumber, 
    required ScrollController scrollControllerList
  }) {
    if(((listNumber.length + 1) * heightElementList) > keyList.currentContext!.size!.height) {
      scrollControllerList.animateTo(
        keyList.currentContext!.size!.height, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.linear
      );
    }
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