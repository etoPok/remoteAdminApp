import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
  // const _QuestionPage({super.key});

  @override
  State<StatefulWidget> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<_QuestionPage> {
  final List<dynamic> _questions = [];
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) { controller.dispose(); }
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    String content = await rootBundle.loadString("assets/data/questions.json");
    setState(() {
      _questions.addAll(jsonDecode(content));

      // Controladores para TextField
      for (var q in _questions) {
        _controllers[q["id"]] = TextEditingController();
      }
    });
  }

  void _saveAnswers() {
    for (var question in _questions) {
      // proporcionar valor por defecto si no hay controlador
      question["respuesta"] = _controllers[question["id"]]?.text ?? "";
    }
  }

  String _getStringAnswers() {
    final buffer = StringBuffer();
    for (int i=0; i < _questions.length; i++) {
      buffer.writeln("${(i+1)}. ${_questions[i]["pregunta"]}");
      buffer.writeln(_questions[i]["respuesta"]);
      buffer.writeln();
    }

    return buffer.toString();
  }

  Future<void> _send() async {
    if (_questions.isEmpty) return;

    _saveAnswers();
    final answers = _getStringAnswers();

    final Email email = Email(
      body: answers,
      subject: "Respuestas de ${_questions[0]["respuesta"]}",
      recipients: ["declivtosira@gmail.com"],
      attachmentPaths: [],
      isHTML: false
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = "Correo enviado";
    } catch (e) {
      platformResponse = e.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preguntas")
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: _questions.length,
        itemBuilder: (_, val) {
          final id = _questions[val]["id"];
          final question = _questions[val]["pregunta"];
          final len = _questions[val]["len"];

          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(question),
              subtitle: TextField(
                controller: _controllers[id],
                maxLength: len,
              )
            )
          );
        }
      ),

      persistentFooterButtons: <Widget>[
        TextButton(
          onPressed: () {
            _send();
          },
          child: const Text("Enviar"))
      ],
    );
  }
}