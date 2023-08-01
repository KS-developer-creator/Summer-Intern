import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:poll/login.dart';
import 'main.dart';

class NextPage extends StatefulWidget {
  @override
  State<NextPage> createState() => _NextPageState();
}
class _NextPageState extends State<NextPage> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            rectangle2View(),
            alreadyHaveAnAccountLoginView(context),
          ],
        ),
      ),
    );
  }

  Widget rectangle2View() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.fromLTRB(40, 42, 44, 46),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNFcIupXliRUHNFDDBcws6CGfoWdRMpOeYSPJCxSICxQ&s',
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              width: 200.0,
              height: 60.0,
            ),
          ),
          buildTextField(
            'Full name',
            'Enter Full name',
            controller: fullnamecontroller,
          ),
          SizedBox(height: 0.0),
          buildTextField(
            'Email address',
            'Enter email address',
            controller: emailcontroller,
          ),
          SizedBox(height: 1.0),
          buildTextField(
            'Password',
            'Enter password',
            obscureText: true,
            controller: passwordcontroller,
          ),
          SizedBox(height: 1.0),
          buildTextField(
            'Confirm Password',
            'Confirm your password',
            obscureText: true,
            controller: confirmpasswordcontroller,
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              SizedBox(
                height: 10.0,
                child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }
                ),
              ),
              Text('I agree to the ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
              Text('terms and conditions',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
            ],
          ),
          SizedBox(height: 30.0),
          Container(
            width: 290.0,
            height: 50.0,
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    if (!isChecked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please agree to the terms and conditions'),
                        ),
                      );
                      return;
                    }
                    registerUser(
                      fullnamecontroller.text.toString(),
                      emailcontroller.text.toString(),
                      passwordcontroller.text.toString(),
                      confirmpasswordcontroller.text.toString(),
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText,
      String hintText, {
        bool obscureText = false,
        required TextEditingController controller,
      }) {
    IconData? prefixIcon;
    IconData? suffixIcon;

    if (labelText == 'Email address') {
      prefixIcon = Icons.email;
    } else if (labelText == 'Password') {
      prefixIcon = Icons.lock;
      suffixIcon = obscureText ? Icons.visibility : Icons.visibility_off;
    } else if (labelText == 'Full name') {
      prefixIcon = Icons.account_box_rounded;
    }
    else if (labelText == 'Confirm Password') {
      prefixIcon = Icons.lock;
      suffixIcon = obscureText ? Icons.visibility : Icons.visibility_off;
    }
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              labelText,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          SizedBox(height: 1.0),
          TextField(
            controller: controller,
            decoration: InputDecoration(

              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: EdgeInsets.all(10.0),
              hintStyle: TextStyle(
                color: Color(0xFF787878),
                fontSize: 14.0,
              ),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              suffix: suffixIcon != null ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(suffixIcon),
              )
                  : null,
            ),
            obscureText: obscureText,
            obscuringCharacter: '*',
          ),
        ],
      ),
    );
  }

  Widget alreadyHaveAnAccountLoginView(BuildContext context) {
    return GestureDetector(onTap: () {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context)=>Login()),);
    },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Inter-Medium',
            fontSize: 16.0,
            color: Colors.grey,
          ),
          children: [
            TextSpan(
              text: 'Already have an account?',
            ),
            TextSpan(
              text: 'login',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registerUser(String fullname,
      email,
      password,
      confirmpassword,
      BuildContext context,) async {
    if (fullname.isEmpty || email.isEmpty || password.isEmpty ||
        confirmpassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fields Must not  be empty'),
        ),
      );
      return;
    }
    if (password != confirmpassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Confirm Password should be same'),
        ),
      );
      return;
    }
    var url = 'https://pollkaro.com/API_';
    var data = {
      "name": fullname,
      "email": email,
      "password": password,

    };
    var body = json.encode(data);
    var uri = Uri.parse(url + "/register.php");
    Response response = await http.post(
      uri,
      body: body,
      headers: {
        "Content-Type": "application/json"
      },
    );

    var datacheck = jsonDecode(response.body);
   // print(datacheck);

    if (response.statusCode == 200) {
      if (datacheck['status'] == 'error' &&
          datacheck['message'] == 'Email already registered') {
        // Email is already registered
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email is already registered'),
          ),
        );
      } else {
        // Registration successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful!'),
          ),
        );
        // Redirect to login page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    } else {
      // Registration failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed'),
        ),
      );
    }
  }
}

