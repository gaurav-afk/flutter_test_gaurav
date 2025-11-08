import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/feed_provider.dart';
import 'services/ai_caption_service.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final aiService = AiCaptionService();


  runApp(MyApp(prefs: prefs, aiService: aiService));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final AiCaptionService aiService;

  const MyApp({super.key, required this.prefs, required this.aiService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FeedProvider(prefs, aiService)..loadPosts(),
        ),
      ],
      child: MaterialApp(
        title: 'Mini Social Feed',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const LoginScreen()
      ),
    );
  }
}
