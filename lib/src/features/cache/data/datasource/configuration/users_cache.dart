

import '../../models/users.dart';
import 'get_user.dart';

class UsersCache {
  static final UsersCache instance = UsersCache._internal();

  UsersCache._internal();
  final Map<int, UserModel?> _cache = {};
  UserModel? getUser(int? id) {
    if (id==null||id < 0) return null;
    if (_cache.containsKey(id)) return _cache[id]!;
    var result= getUserById(id);
    _cache[id] =result==null?null: UserModel.fromJson(result);
    return _cache[id]!;
  }
}