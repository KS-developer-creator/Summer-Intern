/*
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(());
}

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              // Handle navigation to Dashboard page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.poll),
            title: Text('Active Poll'),
            onTap: () {
              // Handle navigation to Active Poll page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ActivePollPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
              // Handle navigation to Edit Profile page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              // Handle navigation to Change Password page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Account'),
            onTap: () {
              // Handle navigation to Delete Account page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteAccountPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('My Account'),
            onTap: () {
              // Handle navigation to My Account page
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Handle logout logic here
              // Perform necessary operations such as clearing user session, etc.
              // Example: AuthService.logout();
            },
          ),
        ],
      ),
    );
  }
}
*/
