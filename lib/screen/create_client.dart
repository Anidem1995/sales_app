import 'package:flutter/material.dart';
import 'package:sales/model/client.dart';
import 'package:sales/net/httphandler.dart';

import 'clients.dart';

class CreateClient extends StatefulWidget {
  @override
  _CreateClientState createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create client'),
        actions: <Widget>[
          MaterialButton(
            child: Text('SAVE', style: TextStyle(fontSize: 15, color: Colors.white),),
            onPressed: () {
              _saveClient();
            },
          )
        ],),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                  hintText: 'First name'
              ),
            ),
          ),
          ListTile(
            leading: SizedBox(height: 40, width: 40,),
            title: TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                  hintText: 'Last name'
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: TextField(
              controller: addressController,
              decoration: InputDecoration(
                  hintText: 'Address'
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: TextField(
              keyboardType: TextInputType.number,
              controller: phoneController,
              decoration: InputDecoration(
                  hintText: 'Phone'
              ),
            ),
          ),
        ],
      ),
    );
  }

  _saveClient() async {
    final client = Client(name: firstNameController.text + ' ' + lastNameController.text, address: emailController.text, email: emailController.text, phone: phoneController.text);
    var saveStatus = await HttpHandler().saveClient(client);
    Navigator.pushReplacementNamed(context, 'clients');
  }

}