import 'package:flutter/material.dart';
import 'views/user_search_page.dart';

void main() {
  runApp(const UserSearchApp());
}

class UserSearchApp extends StatelessWidget {
  const UserSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscar Usuário - ReqRes',
      theme: ThemeData.dark(),
      home: const UserSearchPage(),
    );
  }
}
