import 'package:flag_quiz_26_12_2022/main.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  int numberOfCorrect;

  ResultScreen(
    this.numberOfCorrect,
  );

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String emojiGoster() {
    int a = (widget.numberOfCorrect * 100 / 10).toInt();
    if (84 < a && a <= 100) {
      return "😀";
    } else if (59 < a && a <= 84) {
      return "🙂";
    } else if (40 < a && a <= 59) {
      return "😐";
    } else {
      return "😰";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 255, 255, 1),
      appBar: AppBar(
        title: dilSecenegi == "english"
            ? Text(
                "Resault",
                style: TextStyle(fontSize: 20),
              )
            : Text(
                "Sonuç",
                style: TextStyle(fontSize: 20),
              ),
        backgroundColor: Color(0xFF8E44AD),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      child: Text(
                        dilSecenegi == "english"
                            ? "Number of Correct :\n${widget.numberOfCorrect}"
                            : "Doğru Sayısı :\n${widget.numberOfCorrect}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      child: Flexible(
                        child: Text(
                            dilSecenegi == "english"
                                ? "Number of Wrong :\n${10 - widget.numberOfCorrect}"
                                : "Yanlış Sayısı :\n${10 - widget.numberOfCorrect}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 79, 140, 254)),
              height: size.height * .21,
              width: size.width * .40,
              child: Text(
                emojiGoster(),
                style: TextStyle(fontSize: size.height * .09),
              ),
            ),
            Text(
              dilSecenegi == "english"
                  ? "success rate %${(widget.numberOfCorrect * 100 / 10).toInt()}"
                  : "Başarı Oranı %${(widget.numberOfCorrect * 100 / 10).toInt()}",
              style: TextStyle(fontSize: 30),
            ),
            NewButton(
              dilSecenegi == "english" ? "Try Again" : "Tekrar Dene",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
