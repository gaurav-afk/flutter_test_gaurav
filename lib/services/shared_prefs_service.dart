import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';

class SharedPrefsService {
  Future<void> savePosts(List<PostModel> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final postList = posts.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('posts', postList);
  }

  Future<List<PostModel>> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postList = prefs.getStringList('posts') ?? [];
    return postList.map((p) => PostModel.fromJson(jsonDecode(p))).toList();
  }
}