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
  final Map<String, dynamic> _questions = {};
  final List<String> _questionEntries = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    String content = await rootBundle.loadString("assets/data/questions.json");
    Map<String, dynamic> data = jsonDecode(content);

    setState(() {
      _questions.addAll(data);
      for (var entry in _questions.entries) { _questionEntries.add(entry.key); }
    });
  }

  String _getStringAnswers() {
    StringBuffer buffer = StringBuffer();
    int i = 1;
    for (var entry in _questionEntries) {
      buffer.writeln(entry);
      for (var q in _questions[entry]) {
        buffer.writeln("$i. ${q["titulo"]}");
        buffer.writeln(q["valor"]);
        i++;
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  Future<void> _send() async {
    if (_questions.isEmpty) return;

    final answers = _getStringAnswers();

    final Email email = Email(
      body: answers,
      subject: "Retroalimentación",
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

  TextButton _circleButtonWithAction(String child, bool selected, void Function() action) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: selected ? Colors.blueGrey.shade900 : Colors.transparent
      ),
      onPressed: () { action(); },
      child: Text(child)
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
        itemCount: _questionEntries.length,
        itemBuilder: (_, val) {
          final List<Widget> widgetsForCard = [];

          for (var q in _questions[_questionEntries[val]]) {
            widgetsForCard.add(
              ListTile(
                title: Text(q["titulo"]),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _circleButtonWithAction("1", q["valor"] == 1, () {
                      q["valor"] = 1;
                      setState(() {});
                    }),
                    _circleButtonWithAction("2", q["valor"] == 2, () {
                      q["valor"] = 2;
                      setState(() {});
                    }),
                    _circleButtonWithAction("3", q["valor"] == 3, () {
                      q["valor"] = 3;
                      setState(() {});
                    }),
                    _circleButtonWithAction("4", q["valor"] == 4, () {
                      q["valor"] = 4;
                      setState(() {});
                    }),
                    _circleButtonWithAction("5", q["valor"] == 5, () {
                      q["valor"] = 5;
                      setState(() {});
                    })
                  ]
                )
              )
            );
            widgetsForCard.add(Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(q["max"])
              )
            ));
            widgetsForCard.add(Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(q["min"])
              )
            ));
            widgetsForCard.add(
              _questions[_questionEntries[val]].last["id"] == q["id"] ?
                SizedBox(height: 8) : Divider()
            );
          }

          return Column(
            children: <Widget>[
              ListTile(title: Text(_questionEntries[val])),
              Card(
                child: Column(children: widgetsForCard)
              )
            ]
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