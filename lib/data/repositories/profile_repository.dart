import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gamified_habits/data/models/user_profile.dart';

class ProfileRepository {
  static const _profileBox = 'profile';
  static const _profileKey = 'user_profile';

  late Box<String> _box;

  Future<void> init() async {
    _box = await Hive.openBox<String>(_profileBox);
  }

  UserProfile getProfile() {
    final json = _box.get(_profileKey);
    if (json == null) return const UserProfile();
    return UserProfile.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _box.put(_profileKey, jsonEncode(profile.toJson()));
  }
}
