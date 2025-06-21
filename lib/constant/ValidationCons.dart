
class ValidationCons {

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name!';
    }
    if (value.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password!';
    }
    if (value.length < 6) {
      return 'Password must be longer than 6 characters.\n';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return '• Uppercase letter is missing.\n';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email id!';
    }
    final RegExp regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    if (!regex.hasMatch(value)) {
      return 'Only Gmail addresses (e.g. user@gmail.com) are allowed';
    }

    return null;
  }

  /*String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter your email id!';
    }
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }*/


  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number!';
    }
    final regex = RegExp(r'^\d{10}$');
    if (!regex.hasMatch(value)) {
      return 'Mobile number must be exactly 10 digits and should not contain special characters';
    }

    return null;
  }
  String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your address!';
    }
    if (value.length < 10) {
      return 'Address must be at least 10 characters long';
    }

    if (value.length > 100) {
      return 'Address must be under 100 characters';
    }
    final invalidChars = RegExp(r'[!@#%^*<>]');
    if (invalidChars.hasMatch(value)) {
      return 'Address contains invalid characters';
    }

    return null;
  }
  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }

    final age = int.tryParse(value);
    if (age == null || age < 1 || age > 99) {
      return 'Enter a valid age between 1 and 99';
    }

    return null;
  }
}
