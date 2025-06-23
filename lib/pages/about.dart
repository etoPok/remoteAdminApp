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
        title: const Text("Acerca de"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Sección de Información de la Aplicación
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.info_outline,
                          size: 50,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          "RemoteAdmin",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          "Versión: 1.0.0",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Esta aplicación está diseñada para gestionar solicitudes de tareas que necesiten escalar privilegios en un sistema remoto.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Sección del Creador
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.person_outline,
                          size: 50,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          "Desarrollado por etoPok",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: const Text(
                          "¡Gracias por usar RemoteAdmin!",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Sección de Colaboración/Opinión
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.feedback_outlined,
                          size: 50,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: const Text(
                          "¡Tu opinión es importante!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Puede colaborar al desarrollo de esta aplicación dando a conocer su opinión, sugerencias o reportando cualquier problema que encuentre. Su feedback ayuda a mejorar.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _QuestionPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.send),
                          label: const Text(
                            "Enviar mi opinión",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
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
            widgetsForCard.add(Padding(
              padding: EdgeInsets.all(8),
              child: Text(q["titulo"], style: TextStyle(fontSize: 16))
            ));
            widgetsForCard.add(Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                width: 330,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _circleButtonWithAction("1", q["valor"] == 1, () {
                        q["valor"] = 1;
                        setState(() {});
                      }
                    )),
                    Expanded(
                      child: _circleButtonWithAction("2", q["valor"] == 2, () {
                        q["valor"] = 2;
                        setState(() {});
                      }
                    )),
                    Expanded(
                      child: _circleButtonWithAction("3", q["valor"] == 3, () {
                        q["valor"] = 3;
                        setState(() {});
                      }
                    )),
                    Expanded(
                      child: _circleButtonWithAction("4", q["valor"] == 4, () {
                        q["valor"] = 4;
                        setState(() {});
                      }
                    )),
                    Expanded(
                      child: _circleButtonWithAction("5", q["valor"] == 5, () {
                        q["valor"] = 5;
                        setState(() {});
                      }
                    )),
                  ]
                )
              )
            ));
            widgetsForCard.add(Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(q["min"])
              )
            ));
            widgetsForCard.add(Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(q["max"])
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