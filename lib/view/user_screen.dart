import 'dart:convert';

import 'package:books/model/domain/user.dart';
import 'package:books/view/form_screen.dart';
import 'package:books/view_model/form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formViewModel = Provider.of<FormViewModel>(context);

    void toggleFloatingButton(bool userExists) async {
      if (userExists) {
        final userRestored = await formViewModel.restoreUser();

        if (userRestored) {
          final snackBar = SnackBar(
            content: const Text('User resotred successfully'),
            action: SnackBarAction(
              label: 'Go to user form',
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormScreen()));
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
           Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FormScreen()));
      }
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text('User info',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        ),
        floatingActionButton: FloatingActionButton(
          child: !formViewModel.userExists
              ? const Icon(Icons.format_align_center, color: Colors.black)
              : Icon(Icons.restore, color: Colors.black),
          onPressed: () async {
            toggleFloatingButton(formViewModel.userExists);
          },
          backgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _userInfo(formViewModel));
  }

  Padding _userInfo(FormViewModel formViewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: formViewModel.getStoreUser(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 0) {
              return _showNoUserInfo();
            } else {
              return _showUserInfo(snapshot.data);
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 4,
            ));
          }
        },
      ),
    );
  }

  _showNoUserInfo() {
    return const Center(
      child: Text('No user info, please fill the request form.'),
    );
  }

  _showUserInfo(String userString) {
    User user = User.fromJson(json.decode(userString));
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                  '${user.firstName} ${user.secondName} ${user.firstLastName} ${user.secondLastName}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
          
            ]),
            const SizedBox(height: 10),
                Text('sex - ${user.sex}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Birthday - ${user.birthday}',
                    style: const TextStyle(fontSize: 14)),
                Text('Age - ${user.yearsOld} years old ',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const Divider(color: Colors.black),
            const Text('Contact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Email - ${user.email}'),
            const SizedBox(height: 8),
            Text('Phone number - ${user.phoneNumber}'),
          ]),
    );
  }
}
