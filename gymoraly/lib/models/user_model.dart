class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final int? age;         // Opcional no cadastro
  final String? gender;   // Opcional no cadastro
  final double? height;   // Opcional no cadastro
  final double? weight;   // Opcional no cadastro

  User({
    this.id, 
    required this.name, 
    required this.email, 
    required this.password,
    this.age,
    this.gender,
    this.height,
    this.weight,
  });

  // Converte um User para Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    };
  }

  // Converte um Map para User (para ler do banco)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      age: map['age'],
      gender: map['gender'],
      height: map['height'],
      weight: map['weight'],
    );
  }
}