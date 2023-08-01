import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poll/NextPage.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}
class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  bool _isValidEmail(String email) {
    final pattern = r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
  void _sendVerificationCode(String email) async {
    final apiUrl ='https://pollkaro.com/API_';

    try {
      final response = await http.post(Uri.parse(apiUrl +"/forgot-password.php"), body: {'email': email});

      if (response.statusCode == 200) {
        // Verification code sent successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification code sent to $email'),
          ),
        );
        // Navigate to the next page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NextPage(),),
        );
      } else {
        // Error occurred during API request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send verification code'),
          ),
        );
      }
    } catch (error) {
      // Handle API request exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Forgot Password',style: TextStyle(
          color: Colors.black,
        ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNFcIupXliRUHNFDDBcws6CGfoWdRMpOeYSPJCxSICxQ&s',
                width: 300,
                height: 200,
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Email address',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Align(
                widthFactor: 200,
                alignment: Alignment.center,
                child: Container(
                  width: 290,
                  child: ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text;
                      if (_isValidEmail(email)) {
                        _sendVerificationCode(email);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid email format'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF37C66D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
