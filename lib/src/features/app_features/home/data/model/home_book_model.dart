class HomeBookModel {
  final String id;
  final String title;
  final String coverImage;
  final String description;
  final int commentCount;
  final int reviewCount;
  final double ratingCount;
  final AuthorModel? author;

  HomeBookModel({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.description,
    required this.commentCount,
    required this.reviewCount,
    required this.ratingCount,
    this.author,
  });

  factory HomeBookModel.fromJson(Map<String, dynamic> json) {
    return HomeBookModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      coverImage: json['coverImage'] ?? '',
      description: json['description'] ?? '',
      commentCount: json['commentCount'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toDouble() ?? 0.0,
      author: json['userId'] != null ? AuthorModel.fromJson(json['userId']) : null,
    );
  }
}

class AuthorModel {
  final String id;
  final String fullName;

  AuthorModel({
    required this.id,
    required this.fullName,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }
}
