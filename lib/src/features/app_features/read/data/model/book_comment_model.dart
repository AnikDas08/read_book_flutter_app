class BookComment {
  final String id;
  final String? bookId;
  final CommentUser userId;
  final String message;
  final List<String> likes;
  final String? parentId;
  final DateTime? createdAt;
  final List<BookComment> replies;

  BookComment({
    required this.id,
    this.bookId,
    required this.userId,
    required this.message,
    required this.likes,
    this.parentId,
    this.createdAt,
    required this.replies,
  });

  factory BookComment.fromJson(Map<String, dynamic> json) {
    return BookComment(
      id: json['_id'] ?? '',
      bookId: json['bookId'],
      userId: CommentUser.fromJson(json['userId'] ?? {}),
      message: json['message'] ?? '',
      likes: List<String>.from(json['likes'] ?? []),
      parentId: json['parentId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      replies: (json['replies'] as List?)
              ?.map((x) => BookComment.fromJson(x))
              .toList() ??
          [],
    );
  }
}

class CommentUser {
  final String id;
  final String profile;
  final String fullName;

  CommentUser({
    required this.id,
    required this.profile,
    required this.fullName,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['_id'],
      profile: json['profile'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }
}
