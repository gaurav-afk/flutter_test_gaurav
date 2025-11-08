import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/feed_provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final captionController = TextEditingController();
  File? _imageFile;
  bool _loading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _imageFile = File(image.path));
  }

  @override
  Widget build(BuildContext context) {
    final feed = Provider.of<FeedProvider>(context);
    final username = feed.getLoggedInUser() ?? 'User';

    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CaptionInput(controller: captionController),
            const SizedBox(height: 10),
            PostImagePreview(imageFile: _imageFile),
            const SizedBox(height: 10),
            ActionButtons(
              pickImage: _pickImage,
              generateCaption: () async {
                setState(() => _loading = true);
                final caption = await feed.generateCaption();
                captionController.text = caption;
                setState(() => _loading = false);
              },
            ),
            const SizedBox(height: 20),
            PostButton(
              loading: _loading,
              onPressed: () async {
                final caption = captionController.text.trim();
                if (caption.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Caption cannot be empty!'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  return;
                }
                await feed.addPost(
                  username: username,
                  profilePhotoUrl: 'https://i.pravatar.cc/150?img=3',
                  caption: caption,
                  imageUrl: _imageFile?.path,
                );

                if (mounted) Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================== Sub Widgets ==================

class CaptionInput extends StatelessWidget {
  final TextEditingController controller;
  const CaptionInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Caption',
        border: OutlineInputBorder(),
      ),
      maxLines: 2,
    );
  }
}

class PostImagePreview extends StatelessWidget {
  final File? imageFile;
  const PostImagePreview({super.key, this.imageFile});

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(imageFile!, height: 200, fit: BoxFit.cover),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback pickImage;
  final VoidCallback generateCaption;

  const ActionButtons({
    super.key,
    required this.pickImage,
    required this.generateCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Pick Image'),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: generateCaption,
          icon: const Icon(Icons.auto_awesome),
          label: const Text('Generate Caption'),
        ),
      ],
    );
  }
}

class PostButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;
  const PostButton({super.key, required this.loading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
      ),
      child: loading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Post'),
    );
  }
}
