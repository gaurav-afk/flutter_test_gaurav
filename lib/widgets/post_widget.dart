import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../providers/feed_provider.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(post: post),
          if (post.imageUrl != null) PostImage(imageUrl: post.imageUrl!),
          PostCaption(caption: post.caption),
          PostActions(post: post),
        ],
      ),
    );
  }
}


// =================== Sub Widgets ===================

class PostHeader extends StatelessWidget {
  final PostModel post;
  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(post.profilePhotoUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 2),
                Text(
                  DateFormat('dd MMM yyyy, hh:mm a')
                      .format(post.timestamp.toLocal()),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  final String imageUrl;
  const PostImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    bool isLocalFile = File(imageUrl).existsSync();

    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: isLocalFile
          ? Image.file(File(imageUrl),
          width: double.infinity, height: 220, fit: BoxFit.cover)
          : Image.network(imageUrl,
          width: double.infinity, height: 220, fit: BoxFit.cover),
    );
  }
}

class PostCaption extends StatelessWidget {
  final String caption;
  const PostCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        caption,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

class PostActions extends StatelessWidget {
  final PostModel post;
  const PostActions({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // like button
          IconButton(
            icon: Icon(
              post.likeCount > 0 ? Icons.favorite : Icons.favorite_border,
              color: post.likeCount > 0 ? Colors.red : Colors.grey[700],
              size: 28,
            ),
            onPressed: () {
              Provider.of<FeedProvider>(context, listen: false)
                  .likePost(post.id);
            },
          ),
          Text(
            '${post.likeCount} likes',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),

          // Comment button
          IconButton(
            icon: const Icon(Icons.comment_outlined, size: 24, color: Colors.grey),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Comment feature coming soon!')),
              );
            },
          )
        ],
      ),
    );
  }
}
