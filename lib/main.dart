import 'package:flutter/material.dart';

class Question {
  String questionText;
  bool answer;

  Question({required this.questionText, required this.answer});
}

List<Question> questionBank = [
  Question(questionText: 'Is Flutter a framework?', answer: true),
  Question(
      questionText: 'Is Flutter used for mobile development?', answer: true),
  Question(questionText: 'Is Dart a programming language?', answer: true),
];

void main() {
  runApp(const QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  List<Icon> _scoreKeeper = [];

  // Check if the answer is correct
  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questionBank[_index].answer;

    setState(() {
      if (userAnswer == correctAnswer) {
        _scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      } else {
        _scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }

      // Move to next question or show dialog if quiz is finished
      if (_index < questionBank.length - 1) {
        _index++;
      } else {
        _showFinishedDialog();
      }
    });
  }

  // Show dialog when quiz is finished
  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Finished!'),
          content: Text('You have completed the quiz.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _index = 0;
                  _scoreKeeper.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Quizzler"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Question text
            Text(
              questionBank[_index].questionText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0),
            ),
            Column(
              children: [
                // True button
                ElevatedButton(
                  onPressed: () {
                    checkAnswer(true);
                  },
                  child: Text('True'),
                ),
                // False button
                ElevatedButton(
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text('False'),
                ),
              ],
            ),
            // Display scorekeeper icons
            Row(
              children: _scoreKeeper,
            ),
          ],
        ),
      ),
    );
  }
}
