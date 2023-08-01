import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void loginUser(String email, String password) async {
    // Perform the login logic here, e.g., making API calls
    // You can use the email and password variables to access user input
    // For demonstration purposes, I'll just print the email and password

    print('Email: $email');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNFcIupXliRUHNFDDBcws6CGfoWdRMpOeYSPJCxSICxQ&s',
                fit: BoxFit.contain,
                height: 100.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Email address',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.0),
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: 'Enter email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 2.0),
              TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 1.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Perform forgot password logic here
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.0),
              ElevatedButton(
                onPressed: () {
                  String email = emailcontroller.text.trim();
                  String password = passwordcontroller.text.trim();
                  loginUser(email, password);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(
                height: 24.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF6D6C6C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Perform sign-up logic here
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(
                height: 24.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Perform skip logic here
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF5E5D5D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
