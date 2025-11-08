import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/feed_provider.dart';
import '../widgets/post_widget.dart';
import 'create_post_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FeedProvider>(context, listen: false).loadPosts();

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FeedProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(

            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreatePostScreen()),
              );
              Provider.of<FeedProvider>(context, listen: false).loadPosts();
            },
          ),
        ],
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.posts.isEmpty
          ? const Center(child: Text('No posts yet ✍️'))
          : ListView.builder(
        itemCount: provider.posts.length,
        itemBuilder: (context, i) {
          final post = provider.posts[i];
          return PostWidget(post: post);
        },
      ),
    );
  }
}
