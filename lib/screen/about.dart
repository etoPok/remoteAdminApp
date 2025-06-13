import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca")
      ),

      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          const Text("Puede colaborar al desarrollo de esta aplicación dando a conocer su opinión"),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _QuestionPage()
                )
              );
            },
            child: const Text("Colaborar")
          )
        ]
      )
    );
  }
}

class _QuestionPage extends StatefulWidget {
  const _QuestionPage({super.key});

  @override
  State<StatefulWidget> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<_QuestionPage> {
  final List<dynamic> _questions = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    String content = await rootBundle.loadString("assets/data/questions.json");
    setState(() {
      _questions.addAll(jsonDecode(content));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preguntas")
      ),

      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (_, val) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(_questions[val]["pregunta"]),
              subtitle: TextField(
                onSubmitted: (text) {
                  _questions[val]["respuesta"] = text;
                },
              )
            )
          );
        }
      )
    );
  }
}