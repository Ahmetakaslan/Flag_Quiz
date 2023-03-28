import 'package:flag_quiz_26_12_2022/QuizScreen.dart';
import 'package:flag_quiz_26_12_2022/databasehelper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

String dilSecenegi = "english";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF06CE1B),
        title:
            dilSecenegi == "english" ? Text("Flag quiz") : Text("Bayrak quiz"),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: size.height * .2,
                width: size.width,
                decoration: BoxDecoration(
                    color: Color(0xFF06CE1B),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: dilSecenegi == "english"
                          ? Text(
                              "Welcome the Flag Quiz Game",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 25),
                            )
                          : Text(
                              "Bayrak Yarışmasına Hoşgeldiniz",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 25),
                            ),
                    ),
                    dilSecenegi == "english"
                        ? NewButton("Start the Game", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(),
                                ));
                          })
                        : NewButton("Oyuna Başla", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizScreen(),
                                ));
                          }),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      dilSecenegi = "english";
                      setState(() {});
                    },
                    child: SizedBox(
                      width: size.width * .7,
                      height: size.height * .3,
                      child: Image.asset("assets/images/abd.png"),
                    ),
                  ),
                  Text(
                   dilSecenegi=="english"? "you can choose language 😅":"Dil Seçebilirsiniz 😅",
                    style: TextStyle(fontSize: 20,fontFamily: "Asn"),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      dilSecenegi = "turkce";
                      setState(() {});
                    },
                    child: SizedBox(
                      width: size.width * .7,
                      height: size.height * .3,
                      child: Image.asset("assets/images/turkiye.png"),
                    ),
                  ),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewButton extends StatelessWidget {
  String text;
  Function tab;
  NewButton(this.text, this.tab);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(40, 60), backgroundColor: Color(0xFF2C3E50)),
        onPressed: () {
          tab();
        },
        child: Text(text, style: TextStyle(fontSize: 25)));
  }
}
