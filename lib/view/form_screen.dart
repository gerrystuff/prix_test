import 'package:books/utils/validations.dart';
import 'package:books/view/home_screen.dart';
import 'package:books/view/user_screen.dart';
import 'package:books/view_model/form_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../utils/decorations.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> formkey = GlobalKey();

  DateTime? _chosenDateTime;

  String? gender = "male";

  late String select;

  final inputBirthController = TextEditingController();

  final inputAgeController = TextEditingController();

  final String fontFamily = "Poppins";

  final spaceBetweenColumns = const SizedBox(height: 15);

  final spaceBetweenRows = const SizedBox(width: 15);

  @override
  Widget build(BuildContext context) {
    final formViewModel = Provider.of<FormViewModel>(context);

    void _showDatePicker(BuildContext ctx) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      showCupertinoModalPopup(
          context: ctx,
          builder: (_) => Container(
                height: 500,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    // Close the modal
                    SizedBox(
                      height: 400,
                      child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (val) {
                            setState(() {
                              _chosenDateTime = val;
                              final String formatted =
                                  formatter.format(_chosenDateTime!.toLocal());

                              var age = formViewModel.calculateAge(val);

                              formViewModel.user.birthday = formatted;
                              formViewModel.user.yearsOld = '$age';

                              inputBirthController.text = formatted;
                              inputAgeController.text = '$age years old';
                            });
                          }),
                    ),

                    CupertinoButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    )
                  ],
                ),
              ));
    }

    Row getNamesForm() {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter(RegExp("^[a-zA-Z]+|s"), allow: true),
            ],
            onChanged: (value) => formViewModel.user.firstName = value,
            style: TextStyle(fontFamily: fontFamily),
            decoration: customInputDecoration('First name'),
            validator: (val) {
              return isEmptyInput(val);
            },
          ),
        ),
        spaceBetweenRows,
        Expanded(
          child: TextFormField(
            onChanged: (value) => formViewModel.user.secondName = value,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp("^[a-zA-Z]+|s"), allow: true)
            ],
            style: TextStyle(fontFamily: fontFamily),
            decoration: customInputDecoration('Second name'),
            validator: (val) {
              return isEmptyInput(val);
            },
          ),
        )
      ]);
    }

    Row getLastNamesForm() {
      return Row(children: [
        Expanded(
          child: TextFormField(
            onChanged: (value) => formViewModel.user.firstLastName = value,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp("^[a-zA-Z]+|\s"), allow: true)
            ],
            style: TextStyle(fontFamily: fontFamily),
            decoration: customInputDecoration('First last name'),
            validator: (val) {
              return isEmptyInput(val);
            },
          ),
        ),
        spaceBetweenRows,
        Expanded(
          child: TextFormField(
            onChanged: (value) => formViewModel.user.secondLastName = value,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp("^[a-zA-Z]+|\s"), allow: true)
            ],
            style: TextStyle(fontFamily: fontFamily),
            decoration: customInputDecoration('Second last name'),
            validator: (val) {
              return isEmptyInput(val);
            },
          ),
        )
      ]);
    }

    getPhoneForm() {
      return TextFormField(
        onChanged: (value) => formViewModel.user.phoneNumber = value,
        validator: (value) => isEmptyInput(value),
        decoration: customInputDecoration('Phone number'),
        keyboardType: TextInputType.number,
        maxLength: 10,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
      );
    }

    TextFormField getEmailForm() {
      return TextFormField(
        onChanged: (value) => formViewModel.user.email = value,
        decoration: customInputDecoration('Email'),
        validator: (value) => EmailValidator.validate(value ?? '')
            ? null
            : "Please enter a valid email",
      );
    }

    addRadioButton() {
      return Transform.translate(
        offset: const Offset(-5, 0),
        child: Row(children: [
          Expanded(
            child: ListTile(
              trailing: const Text("Male"),
              leading: Radio(
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      formViewModel.user.sex = gender.toString();
                    });
                  }),
            ),
          ),
          Expanded(
            child: ListTile(
              trailing: Transform.translate(
                  offset: const Offset(10, 0), child: const Text("Female")),
              leading: Radio(
                  value: "female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      formViewModel.user.sex = gender.toString();
                    });
                  }),
            ),
          ),
          Expanded(
            child: ListTile(
              trailing: const Text("Other"),
              leading: Radio(
                  value: "other",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                      formViewModel.user.sex = gender.toString();
                    });
                  }),
            ),
          )
        ]),
      );
    }

    Row getDatePickerForm(BuildContext context) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
                onChanged: (value) => formViewModel.user.birthday = value,
                readOnly: true,
                controller: inputBirthController,
                validator: (value) => isEmptyInput(value),
                decoration: customInputDecoration('Birth date'),
                onTap: () async {
                  _showDatePicker(context);
                }),
          ),
          spaceBetweenRows,
          Expanded(
            child: TextFormField(
              onChanged: (value) => formViewModel.user.yearsOld = value,
              controller: inputAgeController,
              readOnly: true,
              validator: (value) => isEmptyInput(value),
              decoration: customInputDecoration('Age'),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text('Form',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.save,
          color: Color.fromARGB(255, 82, 78, 78),
        ),
        onPressed: () async {
          var valid = isEditValidForm();

          if (valid) {
            bool saveUser = await formViewModel.saveUser();
            if (saveUser) {
              final snackBar = SnackBar(
                content: const Text('User saved successfully'),
                action: SnackBarAction(
                  label: 'Go to details',
                  onPressed: () {
               
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  const UserScreen()));
                  },
                ),
              );
               ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                getNamesForm(),
                spaceBetweenColumns,
                getLastNamesForm(),
                spaceBetweenColumns,
                getPhoneForm(),
                spaceBetweenColumns,
                getEmailForm(),
                spaceBetweenColumns,
                getDatePickerForm(context),
                spaceBetweenColumns,
                addRadioButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isEditValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
