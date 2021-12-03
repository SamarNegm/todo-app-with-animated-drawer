import 'dart:convert';

class users {
  String name;
  String email;
  String phone;
  users({
    this.name,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory users.fromMap(Map<String, dynamic> map) {
    return users(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory users.fromJson(String source) => users.fromMap(json.decode(source));
}
