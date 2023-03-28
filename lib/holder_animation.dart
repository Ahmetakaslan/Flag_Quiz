import 'package:flag_quiz_26_12_2022/QuizScreen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class HolderAnimation extends StatefulWidget {
  const HolderAnimation({super.key});

  @override
  State<HolderAnimation> createState() => _HolderAnimationState();
}

class _HolderAnimationState extends State<HolderAnimation> {
  @override
  void initState() {
    // TODO: implement initState
     Future.delayed(Duration(milliseconds: 600), () {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizScreen(),));
     });
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 89, 88, 88),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height*.70,
              width: double.infinity,
              child: FlareActor(
                "assets/animation/Quiz.flr",
                animation: "Quiz",
                alignment: Alignment.center,
              ),
              alignment: Alignment.center,
            ),
             
          ],
        ),
      ),
    );
  }
}
