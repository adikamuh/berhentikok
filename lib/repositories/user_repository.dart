import 'package:berhentikok/model/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserRepository {
  final Box<User> usersBox;

  UserRepository(this.usersBox);

  void save(User user) {
    try {
      if (usersBox.isEmpty) {
        usersBox.add(user);
      } else {
        usersBox.putAt(0, user);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  User? load() {
    final User? user = usersBox.getAt(0);
    return user?.copyWith(startDateStopSmoking: DateTime(2022, 11, 1));
  }

  bool isRegistered() {
    if (usersBox.isEmpty) return false;
    final user = usersBox.values.first;
    if (user.name.isNotEmpty &&
        user.motivation.isNotEmpty &&
        user.averagePrice > 0 &&
        user.cigarettesPerPack > 0 &&
        user.tobaccoConsumption > 0) {
      return true;
    } else {
      return false;
    }
  }
}
