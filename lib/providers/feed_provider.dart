import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';
import '../services/ai_caption_service.dart';

class FeedProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  final AiCaptionService aiService;

  List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  FeedProvider(this.prefs, this.aiService);

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadPosts() async {
    _setLoading(true);
    try {
      final data = prefs.getStringList('posts') ?? [];
      _posts = data.map((e) => PostModel.fromJson(jsonDecode(e))).toList();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addPost({
    required String username,
    required String profilePhotoUrl,
    required String caption,
    String? imageUrl,
  }) async {
    final post = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      profilePhotoUrl: profilePhotoUrl,
      caption: caption,
      imageUrl: imageUrl,
      likeCount: 0,
      timestamp: DateTime.now(),
    );

    _posts.insert(0, post);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> likePost(String postId) async {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _posts[index] = _posts[index].copyWith(
        likeCount: _posts[index].likeCount + 1,
      );
      await _saveToPrefs();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    final data = _posts.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('posts', data);
  }

  Future<String> generateCaption() async {
    _setLoading(true);
    try {
      return await aiService.fetchAiCaption();
    } catch (e) {
      return 'Could not generate caption';
    } finally {
      _setLoading(false);
    }
  }

  // For login persistence
  Future<void> saveLoginState(String email) async {
    await prefs.setString('user_email', email);
  }

  String? getLoggedInUser() => prefs.getString('user_email');
}
