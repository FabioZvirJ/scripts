class LoginModel {
  String email = '';
  String password = '';

  bool get isValid => email.contains('@') && password.length >= 6;
}