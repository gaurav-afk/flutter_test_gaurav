class PostModel {
  final String id;
  final String username;
  final String profilePhotoUrl;
  final String caption;
  final String? imageUrl;
  final int likeCount;
  final DateTime timestamp;

  PostModel({
    required this.id,
    required this.username,
    required this.profilePhotoUrl,
    required this.caption,
    this.imageUrl,
    required this.likeCount,
    required this.timestamp,
  });

  PostModel copyWith({
    String? id,
    String? username,
    String? profilePhotoUrl,
    String? caption,
    String? imageUrl,
    int? likeCount,
    DateTime? timestamp,
  }) {
    return PostModel(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      caption: caption ?? this.caption,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'profilePhotoUrl': profilePhotoUrl,
    'caption': caption,
    'imageUrl': imageUrl,
    'likeCount': likeCount,
    'timestamp': timestamp.toIso8601String(),
  };

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'],
    username: json['username'],
    profilePhotoUrl: json['profilePhotoUrl'],
    caption: json['caption'],
    imageUrl: json['imageUrl'],
    likeCount: json['likeCount'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
