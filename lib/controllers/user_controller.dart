import '../models/user_model.dart';
import '../services/user_service.dart';

class UserController {
  final UserService _service = UserService();

  Future<User?> getUserById(String idText) async {
    final id = int.tryParse(idText);
    if (id == null || id < 1 || id > 12) return null;
    return await _service.fetchUser(id);
  }
}
