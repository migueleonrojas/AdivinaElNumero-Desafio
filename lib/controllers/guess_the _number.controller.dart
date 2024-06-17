import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GuessTheNumberController extends GetxController {

  FocusNode numberFocusNode = FocusNode();

  Rx<Color> cursorColor = Colors.blue.obs;
  Rx<Color> focusColor = Colors.white.obs;
  Rx<Color> borderSideColor = Colors.white.obs;
  Rx<Color> textColor = Colors.white.obs;
  Rx<Color> labelTextColor = Colors.white.obs;

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


  
  tryToGuessNumber (String value) {

    if(!_validateNumber(value)) {
      return false;
    }

    
    
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

  _validateScaleNumber (int number) {

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