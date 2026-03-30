class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  User({this.id, required this.name, required this.email, required this.password});

  // Converte um User para Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Converte um Map para User (para ler do banco)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}