import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final UserController _userController = UserController();
  User? _user;
  String? _error;
  bool _loading = false;

  void _searchUser() async {
    setState(() {
      _loading = true;
      _error = null;
      _user = null;
    });

    final result = await _userController.getUserById(_controller.text);

    setState(() {
      _loading = false;
      if (result != null) {
        _user = result;
      } else {
        _error = 'Usuário não encontrado!';
      }
    });
  }

  Widget _buildUserInfo() {
    if (_user == null) return const SizedBox.shrink();

    return Column(
      children: [
        CircleAvatar(radius: 50, backgroundImage: NetworkImage(_user!.avatar)),
        const SizedBox(height: 10),
        Text(
          '${_user!.firstName} ${_user!.lastName}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(_user!.email, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Usuário')),
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
              onPressed: _loading ? null : _searchUser,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            _buildUserInfo(),
          ],
        ),
      ),
    );
  }
}
