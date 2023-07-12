// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User(
    this.id,
    this.name,
    this.username,
    this.email,
  );

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
  }) {
    return User(
      id ?? this.id,
      name ?? this.name,
      username ?? this.username,
      email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['id'] as int,
      map['name'] as String,
      map['username'] as String,
      map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, username: $username, email: $email)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ username.hashCode ^ email.hashCode;
  }
}

class UserStateNotifier extends StateNotifier<User> {
  // here we see that we can use this constructor to
  // UserNotifier(super.state);
  UserStateNotifier() : super(User(0, '', '', ''));

  updateName(String n) {
    state = state.copyWith(name: n);
  }

  updateId(int id) {
    state = state.copyWith(id: id);
  }

  updateUsername(String username) {
    state = state.copyWith(username: username);
  }

  updateEmail(String e) {
    state = state.copyWith(email: e);
  }
}

//ChangeNotifier
class UserChangeNotifier extends ChangeNotifier {
  // here we see that we can use this constructor to
  // UserNotifier(super.state);
  User user = User(0, '', '', '');

  updateName(String n) {
    user = user.copyWith(name: n);
    notifyListeners();
  }

  updateId(int id) {
    user = user.copyWith(id: id);
    notifyListeners();
  }

  updateUsername(String username) {
    user = user.copyWith(username: username);
    notifyListeners();
  }

  updateEmail(String e) {
    user = user.copyWith(email: e);
    notifyListeners();
  }
}
