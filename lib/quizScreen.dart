import 'dart:async';
import 'dart:collection';
import 'package:flag_quiz_26_12_2022/holder_animation.dart';
import 'package:flare_flutter/base/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flag_quiz_26_12_2022/databasehelper.dart';
import 'package:flag_quiz_26_12_2022/flagdao.dart';
import 'package:flag_quiz_26_12_2022/flags.dart';
import 'package:flag_quiz_26_12_2022/main.dart';
import 'package:flag_quiz_26_12_2022/result.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  StopAnimation stopAnimation = StopAnimation();
  var questions = <Flags>[];

  var wrongOptions = <Flags>[];
  late Flags correctOption;

  // Hashmap automatically shuffles the contents
  var allOptions = HashSet<Flags>();
  int questionCounter = 0;
  int trueCounter = 0;
  int wrongCounter = 0;
  String nameOfFlag = "placeholder.png";
  String buttonAText = "";
  String buttonBText = "";
  String buttonCText = "";
  String buttonDText = "";
  Color buttonA = Color(0xFF2C3E50);
  Color buttonB = Color(0xFF2C3E50);
  Color buttonC = Color(0xFF2C3E50);
  Color buttonD = Color(0xFF2C3E50);

  Future<void> getQuestion() async {
    questions = await Flagdao.randomFlag();

    try {
      loadQuestion();
    } catch (e) {
      debugPrint("loadQuestion tyr catch $e");
    }
  }

  @override
  void initState() {
    try {
      getQuestion();
    } catch (e) {
      debugPrint("loadQuestion tyr catch $e");
    }
  }

  Future<void> loadQuestion() async {
    setState(
      () {
        buttonA = Color(0xFF2C3E50);
        buttonB = Color(0xFF2C3E50);
        buttonC = Color(0xFF2C3E50);
        buttonD = Color(0xFF2C3E50);
      },
    );
    setState(() {});
    correctOption = questions[questionCounter];
    debugPrint("***** Load Question ******");
    debugPrint(correctOption.Name);
    debugPrint(correctOption.FlagPicture);

    setState(
      () {
        nameOfFlag = correctOption.FlagPicture;
      },
    );

    wrongOptions = await Flagdao.random3Flag(correctOption.Id);
    debugPrint("wrong option sayısı ${wrongOptions.length}");

    allOptions.clear();
    allOptions.add(correctOption);
    allOptions.add(wrongOptions[0]);
    allOptions.add(wrongOptions[1]);
    allOptions.add(wrongOptions[2]);

    buttonAText = allOptions.elementAt(0).Name;
    debugPrint("A nın değeri +++++++ " + buttonAText);
    buttonBText = allOptions.elementAt(1).Name;
    buttonCText = allOptions.elementAt(2).Name;
    buttonDText = allOptions.elementAt(3).Name;

    setState(() {});
    //update interface when running empty
  }

  void questionCounterController() {
    questionCounter = questionCounter + 1;
    if (questionCounter != 10) {
      loadQuestion();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(trueCounter),
        ),
      );
    }
  }

  ShowAnimation(Size size) {
    return Center(
      child: Column(
        children: [
          Container(
            height: size.height * .70,
            width: double.infinity,
            child: Center(
              child: FlareActor(
                "assets/animation/Quiz.flr",
                animation: "Quiz",
                alignment: Alignment.center,
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Future<void> trueController(String buttonText, int a) async {
    debugPrint("Geldi");

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        isAnimation = true;
        Timer(Duration(milliseconds: 500), () {
          isAnimation = false;
        });
      });
    });

    Future.delayed(Duration(milliseconds: 700), () {
      if (correctOption.Name == buttonText) {
        trueCounter++;
        setState(
          () {
            // ignore: unrelated_type_equality_checks
            if (a == 1) {
              buttonA = Colors.green;
              debugPrint("1 Çalıştı");
              // ignore: unrelated_type_equality_checks
            } else if (a == 2) {
              buttonB = Colors.green;
              debugPrint("2 Çalıştı");
              // ignore: unrelated_type_equality_checks
            } else if (a == 3) {
              buttonC = Colors.green;
              debugPrint("3 Çalıştı");
            } else {
              buttonD = Colors.green;
            }
          },
        );
      } else {
        wrongCounter++;

        setState(() {
          // ignore: unrelated_type_equality_checks
          if (a == 1) {
            buttonA = Colors.red;
            // ignore: unrelated_type_equality_checks
          } else if (a == 2) {
            buttonB = Colors.red;
            // ignore: unrelated_type_equality_checks
          } else if (a == 3) {
            buttonC = Colors.red;
          } else {
            buttonD = Colors.red;
          }
        });
      }
    });
    Future.delayed(Duration(milliseconds: 1200), () {});
/**
 * 
 *   if (correctOption.Name == buttonText) {
      trueCounter++;
      setState(
        () {
          // ignore: unrelated_type_equality_checks
          if (a == 1) {
            buttonA = Colors.green;
            debugPrint("1 Çalıştı");
            // ignore: unrelated_type_equality_checks
          } else if (a == 2) {
            buttonB = Colors.green;
            debugPrint("2 Çalıştı");
            // ignore: unrelated_type_equality_checks
          } else if (a == 3) {
            buttonC = Colors.green;
            debugPrint("3 Çalıştı");
          } else {
            buttonD = Colors.green;
          }
        },
      );
    } else {
      wrongCounter++;

      setState(() {
        // ignore: unrelated_type_equality_checks
        if (a == 1) {
          buttonA = Colors.red;
          // ignore: unrelated_type_equality_checks
        } else if (a == 2) {
          buttonB = Colors.red;
          // ignore: unrelated_type_equality_checks
        } else if (a == 3) {
          buttonC = Colors.red;
        } else {
          buttonD = Colors.red;
        }
      });
    }
 */
  }

  /**
  * 
 void ShowTrueAnimation() {

      Positioned(
        bottom: 2,
        left: 2,
        child: Center(
          child: SizedBox(
            height: 80,
            width: 80,
            child: Container(
              child: FlareActor(
                "assets/animation/SuccessCheck.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
       
                animation: "SuccessCheck.flr",
              ),
            ),
          ),
        ),
      );
    
   
  }

  */
  bool _isButtonDisabled = true;
  bool isAnimation = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 211, 211),
        appBar: AppBar(
            title: dilSecenegi == "english"
                ? Text(
                    "Quiz",
                    style: TextStyle(fontSize: 20),
                  )
                : Text("Bilgi Yarışması", style: TextStyle(fontSize: 20)),
            backgroundColor: Color(0xFF06CE1B) // Color(0xFFD35400),
            ),
        body: isAnimation == false
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        dilSecenegi == "english"
                            ? Text(
                                "Correct : ${trueCounter}",
                                style: TextStyle(fontSize: 25),
                              )
                            : Text(
                                "Doğru : ${trueCounter}",
                                style: TextStyle(fontSize: 25),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        dilSecenegi == "english"
                            ? Text(
                                "Wrong : ${wrongCounter}",
                                style: TextStyle(fontSize: 25),
                              )
                            : Text(
                                "Yanlış : ${wrongCounter}",
                                style: TextStyle(fontSize: 25),
                              ),
                      ],
                    ),
                    dilSecenegi == "english"
                        ? questionCounter != 10
                            ? Text(
                                "${questionCounter + 1}. Question",
                                style: TextStyle(fontSize: 22),
                              )
                            : Text("5.Question")
                        : questionCounter != 5
                            ? Text(
                                "${questionCounter + 1}. Soru",
                                style: TextStyle(fontSize: 22),
                              )
                            : Text("5.Soru"),
                    Image.asset("assets/images/${nameOfFlag}"),
                    SizedBox(
                      height: size.height * .08,
                      width: size.width * .6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isButtonDisabled) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                            Timer(
                              Duration(milliseconds: 1600),
                              () {
                                _isButtonDisabled = true;
                              },
                            );
                            trueController(buttonAText, 1);
                            Future.delayed(
                              Duration(milliseconds: 1600),
                              () {
                                questionCounterController();
                              },
                            );
                          } else {
                            print("Basılamaz");
                          }
                        },
                        child: Text("A) $buttonAText",
                            style: TextStyle(fontSize: 25)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonA,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .08,
                      width: size.width * .6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isButtonDisabled) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                            Timer(
                              Duration(milliseconds: 1600),
                              () {
                                _isButtonDisabled = true;
                              },
                            );
                            trueController(buttonBText, 2);
                            Future.delayed(
                              Duration(milliseconds: 1600),
                              () {
                                questionCounterController();
                              },
                            );
                          } else {
                            print("Basılamaz");
                          }
                        },
                        child: Text("B) $buttonBText",
                            style: TextStyle(fontSize: 25)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonB,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .08,
                      width: size.width * .6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isButtonDisabled) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                            Timer(
                              Duration(milliseconds: 1600),
                              () {
                                _isButtonDisabled = true;
                              },
                            );
                            trueController(buttonCText, 3);
                            Future.delayed(
                              Duration(milliseconds: 1600),
                              () {
                                questionCounterController();
                              },
                            );
                          } else {
                            print("Basılamaz");
                          }
                        },
                        child: Text("C) $buttonCText",
                            style: TextStyle(fontSize: 25)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonC,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .08,
                      width: size.width * .6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isButtonDisabled) {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                            Timer(
                              Duration(milliseconds: 1600),
                              () {
                                _isButtonDisabled = true;
                              },
                            );
                            trueController(buttonDText, 4);
                            Future.delayed(
                              Duration(milliseconds: 1600),
                              () {
                                questionCounterController();
                              },
                            );
                          } else {
                            print("Basılamaz");
                          }
                        },
                        child: Text("D) $buttonDText",
                            style: TextStyle(fontSize: 25)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonD,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ShowAnimation(size));
  }
}

class StopAnimation extends FlareController {
  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    // TODO: implement advance
    throw UnimplementedError();
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    // TODO: implement initialize
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    // TODO: implement setViewTransform
  }
  void stopAnimation() {
    isActive.value = false;
  }
}
