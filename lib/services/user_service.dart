import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserService {
  Future<User?> fetchUser(int id) async {
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users/$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data['data']);
    } else {
      return null;
    }
  }
}
