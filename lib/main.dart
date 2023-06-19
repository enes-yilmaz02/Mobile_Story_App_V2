import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mantık Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<int> planet1Values = [];
  List<int> planet2Values = [];
  List<int> planet3Values = [];

  late int correctAnswer;

  bool showResult = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    generateValues();
    calculateCorrectAnswer();
  }

  void generateValues() {
    Random random = Random();

    for (int i = 0; i < 4; i++) {
      planet1Values.add(random.nextInt(10) + 1);
      planet2Values.add(random.nextInt(10) + 1);
      planet3Values.add(random.nextInt(10) + 1);
    }
  }

  void calculateCorrectAnswer() {
    int sum1 = planet1Values[0] + planet1Values[1];
    int diff1 = planet1Values[2] - planet1Values[3];

    int sum2 = planet2Values[0] + planet2Values[1];
    int diff2 = planet2Values[2] - planet2Values[3];

    correctAnswer = sum1 + sum2 + diff1 + diff2;
  }

  void checkAnswer(int answer) {
    setState(() {
      showResult = true;
      isCorrect = (answer == correctAnswer);
    });
  }

  void resetGame() {
    setState(() {
      planet1Values.clear();
      planet2Values.clear();
      planet3Values.clear();
      showResult = false;
      isCorrect = false;
      generateValues();
      calculateCorrectAnswer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mantık Oyunu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Gezegen 1: ${planet1Values[0]} + ${planet1Values[1]} - ${planet1Values[2]} + ${planet1Values[3]} = ?',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Gezegen 2: ${planet2Values[0]} + ${planet2Values[1]} - ${planet2Values[2]} + ${planet2Values[3]} = ?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            if (showResult)
              Text(
                isCorrect
                    ? 'Tebrikler, doğru bildiniz!'
                    : 'Yanlış işlem yaptınız!',
                style: TextStyle(fontSize: 20),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: showResult ? resetGame : null,
              child: Text(showResult ? 'Tekrar Oyna' : 'Cevapla'),
            ),
          ],
        ),
      ),
    );
  }
}
