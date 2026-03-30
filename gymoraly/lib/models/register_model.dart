class RegisterModel {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool get isValid => 
    name.isNotEmpty && 
    email.contains('@') && 
    password.length >= 6 && 
    password == confirmPassword;
}