import 'dart:convert'; // For utf8 encoding
import 'package:crypto/crypto.dart'; // For hashing

class User {
  final int? id;
  final String username;
  final String email;
  final String password; // Store the hashed password


  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  // Factory constructor to create a User with a hashed password
  factory User.create({
    int? id,
    required String username,
    required String email,
    required String password,
  }) {
    return User(
      id: id,
      username: username,
      email: email,
      password: _hashPassword(password), // Hash the password here
    );
  }

  // Convert a User object to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password, // Store the already hashed password
    };
  }

  // Factory constructor to create a User object from a Map (e.g., from the database)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'], // Use the stored hashed password
    );
  }


  // Utility method to hash a password using SHA-256
  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }


  // Utility method to verify if an input password matches the stored hashed password
  static bool verifyPassword(String inputPassword, String storedHashedPassword) {
    String hashedInput = _hashPassword(inputPassword);
    return hashedInput == storedHashedPassword;
  }
}
