import 'package:books/utils/validations.dart';
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


  final inputBirthController = TextEditingController();

  final inputAgeController = TextEditingController();


  final String fontFamily = "Poppins";

  final spaceBetweenColumns = const SizedBox(height: 15);

  final spaceBetweenRows = const SizedBox(width: 15);

  @override
  Widget build(BuildContext context) {

    final formViewModel = Provider.of<FormViewModel>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Form', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.save,
          color: Color.fromARGB(255, 82, 78, 78),
        ),
        onPressed: () {
          var valid = isEditValidForm();
        },
      ),
      body: Container(
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
                getDatePickerForm(context,formViewModel)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row getDatePickerForm(BuildContext context,FormViewModel formViewmodel) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
              readOnly: true,
              controller: inputBirthController,
              validator: (value) => isEmptyInput(value),
              decoration: customInputDecoration('Birth date'),
              onTap: () async {
                _showDatePicker(context,formViewmodel);
              }),
        ),
        spaceBetweenRows,

        Expanded(
          child: TextFormField(
              controller:inputAgeController,
              readOnly: true,
              validator: (value) => isEmptyInput(value),
              decoration: customInputDecoration('Age'),
             ),
        ),
      ],
    );
  }

  getPhoneForm() {
    return TextField(
      decoration: customInputDecoration('Phone number'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
    );
  }

  TextFormField getEmailForm() {
    return TextFormField(
      decoration: customInputDecoration('Email'),
      validator: (value) => EmailValidator.validate(value ?? '')
          ? null
          : "Please enter a valid email",
    );
  }

  Row getLastNamesForm() {
    return Row(children: [
      Expanded(
        child: TextFormField(
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
          style: TextStyle(fontFamily: fontFamily),
          decoration: customInputDecoration('Second last name'),
          validator: (val) {
            return isEmptyInput(val);
          },
        ),
      )
    ]);
  }

  Row getNamesForm() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Expanded(
        child: TextFormField(
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
          style: TextStyle(fontFamily: fontFamily),
          decoration: customInputDecoration('First name'),
          validator: (val) {
            return isEmptyInput(val);
          },
        ),
      )
    ]);
  }

  void _showDatePicker(BuildContext ctx, FormViewModel formViewModel) {

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
                           final String formatted = formatter.format(_chosenDateTime!.toLocal());


                           var age = formViewModel.calculateAge(val);

                           print(age);

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

  bool isEditValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
