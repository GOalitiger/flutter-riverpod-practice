import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../user.dart';

//futureProvider
final userFutureProvider = FutureProvider((ref) {
  final String userURl = 'https://jsonplaceholder.typicode.com/users/1';
  return http
      .get(Uri.parse(userURl))
      .then((value) => User.fromJson(value.body));
});

class UserDetails extends ConsumerWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userFutureProvider).when(
      data: (data) {
        return Center(
            child: Column(
          children: [
            for (final user in data.toMap().entries)
              rowViewForUser(user.key, user.value)
          ],
        ));
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const CircularProgressIndicator(
          color: Colors.amberAccent,
        );
      },
    );
  }

  Row rowViewForUser(dynamic key, dynamic value) {
    return Row(
      children: [
        Text(key.toString().toUpperCase()),
        const SizedBox(
          width: 5.0,
        ),
        Text(value is int ? '' : value),
      ],
    );
  }
}
