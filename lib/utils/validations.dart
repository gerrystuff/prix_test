String? isEmptyInput(String? val) {
  if (val!.isEmpty) {
    return 'Required';
  } else {
    return null;
  }
}