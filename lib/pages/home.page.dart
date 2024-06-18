import 'package:agnostiko_test/controllers/guess_the%20_number.controller.dart';
import 'package:agnostiko_test/models/history_numbers.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GuessTheNumberController guessTheNumberController = Get.put(GuessTheNumberController());

    guessTheNumberController.initVariables();
    
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2C2A),
        title:  Obx(
          () => Text(
            'Adivina el número ${guessTheNumberController.randomNumber.value.toString()}',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromARGB(255, 34, 34, 33),
        width: size.width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.025,),
            Row(
              children: [
                const Expanded(child: SizedBox(),),
                SizedBox(
                  width: size.width * 0.30,
                  child: Obx( () =>
                    TextField(
                        onSubmitted: (value) => guessTheNumberController.tryToGuessNumber(value),
                        cursorColor: guessTheNumberController.cursorColor.value,
                        focusNode: guessTheNumberController.numberFocusNode,
                        style: TextStyle(color: guessTheNumberController.textColor.value),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: guessTheNumberController.borderSideColor.value,
                            ),
                          ),
                          labelText: 'Número',
                        
                          labelStyle: TextStyle(
                            color: guessTheNumberController.labelTextColor.value
                          ), 
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: guessTheNumberController.borderSideColor.value,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                      
                          )
                        )
                      ),
                    )
                ),
                const Expanded(child: SizedBox(),),
                 Column(
                  children:  [
                      const Text(
                      'Intentos',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Obx(
                      () => Text(
                        guessTheNumberController.currentAttempts.value.toString(),
                        style: const TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    
                  
                  ],
                ),
                const Expanded(child: SizedBox(),),

              ],
            ),
            SizedBox(height: size.height * 0.025 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                Container(
                  height: size.height * 0.30,
                  width: size.width * 0.30,
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 15,
                    right: 15
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white
                    )
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Mayor que',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: size.height * 0.01,),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: guessTheNumberController.largerNumbers.length,
                            itemBuilder: (context, index) {
                              return Text(
                                guessTheNumberController.largerNumbers[index].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01,)                  
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.30,
                  width: size.width * 0.30,
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 15,
                    right: 15
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white
                    )
                  ),
                  child: Column(
                    
                    children: [
                      const Text(
                        'Menor que',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: size.height * 0.01,),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(            
                            shrinkWrap: true,
                            itemCount: guessTheNumberController.minorNumbers.length,
                            itemBuilder: (context, index) {
                              return Text(
                                guessTheNumberController.minorNumbers[index].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01,)                  

                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.30,
                  width: size.width * 0.30,
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 15,
                    right: 15
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white
                    )
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Historial',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: size.height * 0.01,),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(            
                            shrinkWrap: true,
                            itemCount: guessTheNumberController.historyNumbers.length,
                            itemBuilder: (context, index) {
                        
                              HistoryNumbersModel historyNumbersModel = HistoryNumbersModel.fromJson(guessTheNumberController.historyNumbers[index].toJson());
                        
                              return Text(
                                historyNumbersModel.numberHistory.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: historyNumbersModel.color
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01,) 
                  
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: size.width * 0.80,
                child: Column(
                  children: [
                    Obx(
                      () => Text(
                        guessTheNumberController.currentDifficultyLevel.value.nameOfDifficulty,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Obx(
                      () =>  Slider(
                        value: guessTheNumberController.valueSlider.value,
                        max: 3,
                        min: 0,
                        divisions: 3,
                        activeColor: const Color.fromARGB(255, 33, 124, 243),
                        inactiveColor: Colors.blue[900],
                        onChanged: (value) => guessTheNumberController.changeDifficulty(value)
                      ),
                    )
                  ],
                ),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}