import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'createpoll.dart';
import 'dart:convert';
import 'NextPage.dart';
void main() {
  runApp(MyApp(isLoggedIn: false));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(isLoggedIn: isLoggedIn),
      routes: {
        '/next': (context) => NextPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isLoggedIn;
  HomePage({required this.isLoggedIn});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> pollList = [];

  void initState() {
    super.initState();
    fetchPollsFromDatabase();
  }

  void fetchPollsFromDatabase() async {
    try {
      final List<dynamic> fetchedPolls = await fetchPolls();
      setState(() {
        pollList = fetchedPolls;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, '/next');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: pollList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return pollkaroLogoView();
          } else {
            final pollIndex = index - 1;
          }
          return Builder(
            builder: (BuildContext context) {
              final question = pollList[index]['question'];
              final createdDate = pollList[index]['createdDate'] as DateTime?;
              return homeView(question, createdDate ?? DateTime.now());
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[200],
        elevation: 8.0,
        selectedItemColor: Color(0xFF37C66D),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
        onPressed: () {
          if (widget.isLoggedIn) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => createpollpage(
              onPollCreated: (newPoll) {
                setState(() {
                  pollList.add(newPoll);
                });
              },
            ),
            ),
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Login Required'),
                  content: Text('Please login to create a poll.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          }
        },
        backgroundColor: Colors.green,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

   Widget pollkaroLogoView() {
    return Card(
      child: Row(
        children: [
          Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNFcIupXliRUHNFDDBcws6CGfoWdRMpOeYSPJCxSICxQ&s',
            alignment: Alignment.topLeft,
            width: 190.0,
            height: 40.0,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return Container(
                    width: 200.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/next');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF37C66D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),

                        ),
                      ),
                      child: Text(
                        'Create Poll',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget homeView(String question, DateTime createdDate) {
  final formattedDate = DateFormat('yyyy-MM-dd').format(createdDate);
  return Card(
    margin: EdgeInsets.all(8.0),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              question,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Created: $formattedDate',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              onPressed: () {
                final textToShare = 'Check out this poll: $question';

                Share.share(textToShare);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              icon: Container(
                width: 10.0,
                child: Icon(
                  Icons.share_rounded,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
              label: Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<List<dynamic>> fetchPolls() async {
  var url = 'https://pollkaro.com/API_';
  var uri = Uri.parse(url + "/api.php");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to fetch polls');
  }
}
