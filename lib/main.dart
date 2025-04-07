import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;
  Map<String, dynamic>? _userData;
  bool _isLoading = false;

  Future<void> _fetchUser() async {
    final id = _controller.text.trim();

    setState(() {
      _errorMessage = null;
      _userData = null;
      _isLoading = true;
    });

    if (id.isEmpty ||
        int.tryParse(id) == null ||
        int.parse(id) < 1 ||
        int.parse(id) > 12) {
      setState(() {
        _errorMessage = 'Usuário não encontrado!';
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _userData = data['data'];
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Usuário não encontrado!';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erro inesperado (${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao conectar com a API.';
        _isLoading = false;
      });
    }
  }

  Widget _buildUserInfo() {
    if (_userData == null) return const SizedBox.shrink();

    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(_userData!['avatar']),
          radius: 50,
        ),
        const SizedBox(height: 10),
        Text(
          '${_userData!['first_name']} ${_userData!['last_name']}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(_userData!['email'], style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Usuário - ReqRes')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite o ID do usuário (1 a 12)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchUser,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            if (_userData != null) _buildUserInfo(),
          ],
        ),
      ),
    );
  }
}
