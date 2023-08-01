import 'package:flutter/material.dart';
import 'package:poll/main.dart';
import 'package:http/http.dart'as http;
import 'login.dart';


class createpollpage extends StatefulWidget {
  final void Function(dynamic newPoll) onPollCreated;
  createpollpage({required this.onPollCreated});

  @override
  State<createpollpage> createState() => _createpollpageState();
}

class _createpollpageState extends State<createpollpage> {
  final TextEditingController pollTextFieldController = TextEditingController();
  List<TextEditingController> optionTextControllers = [];
  String entereddata = '';

  @override
  void dispose() {
    pollTextFieldController.dispose();
    for (var controller in optionTextControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addOption() {
    if (_validateOptions()) {
      setState(() {
        optionTextControllers.add(TextEditingController());
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all previous options'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context,entereddata);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool _validateOptions() {
    for (var controller in optionTextControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void removeOption(int index) {
    setState(() {
      optionTextControllers.removeAt(index);
    });
  }

  void createPoll() {
    if (optionTextControllers.isNotEmpty) {
      final pollQuestion = pollTextFieldController.text;
      final options = optionTextControllers.map((controller) => controller.text).toList();

      //  Perform API call to create the poll
      createPollAPI(pollQuestion, options);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please add at least 1 option'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> createPollAPI(String question, List<String> options) async {
    final url = Uri.parse('https://pollkaro.com/API_/createpoll.php');

    try {
      final response = await http.post(
        url,
        body: {
          'question': question,
          'options': options.join(','),
        },
      );

      if (response.statusCode == 200) {
        // Poll created successfully
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Poll created successfully'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to create poll. Please try again.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again later.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool canCreatePoll = optionTextControllers.isNotEmpty;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              pollkaroLogoView(),
                SizedBox(height: 20.0),
                Text(
                  'Create Poll',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Poll question',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: pollTextFieldController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: 'Eg: Create your poll',
                      contentPadding: EdgeInsets.all(16.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Options:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: optionTextControllers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextField(
                              controller: optionTextControllers[index],
                              maxLength: 20,
                              decoration: InputDecoration(
                                hintText: 'Write options here',
                                contentPadding: EdgeInsets.all(8.0),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            removeOption(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: addOption,
                  child: Text('Add Your Option'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: canCreatePoll ? createPoll : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('Create Poll'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}