import 'package:agnostiko_test/controllers/guess_the%20_number.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GuessTheNumberController customQuizController = Get.put(GuessTheNumberController());

    customQuizController.initVariables();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2C2A),
        title: const Text(
          'Adivina el número',
          style: TextStyle(
            color: Colors.white
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
                        onSubmitted: (value) => customQuizController.tryToGuessNumber(value),
                        cursorColor: customQuizController.cursorColor.value,
                        focusNode: customQuizController.numberFocusNode,
                        style: TextStyle(color: customQuizController.textColor.value),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: customQuizController.borderSideColor.value,
                            ),
                          ),
                          labelText: 'Número',
                        
                          labelStyle: TextStyle(
                            color: customQuizController.labelTextColor.value
                          ), 
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: customQuizController.borderSideColor.value,
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
                Expanded(child: SizedBox(),),

                Column(
                  children: const [
                    Text(
                      'Intentos',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Text(
                      '8',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    
                  
                  ],
                ),
                Expanded(child: SizedBox(),),

              ],
            )
          ],
        ),
      ),
    );
  }
}