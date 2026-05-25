class BookReviewResponse {
  final double bookRating;
  final Map<String, int> reviewProgress;
  final List<ReviewResult> result;
  final int totalReviews;

  BookReviewResponse({
    required this.bookRating,
    required this.reviewProgress,
    required this.result,
    required this.totalReviews,
  });

  factory BookReviewResponse.fromJson(Map<String, dynamic> json) {
    final reviewProgress = Map<String, int>.from(json['reviewProgress']);
    final total = reviewProgress.values.fold(0, (sum, value) => sum + value);
    return BookReviewResponse(
      bookRating: (json['bookRating'] as num).toDouble(),
      reviewProgress: reviewProgress,
      result: (json['result'] as List).map((x) => ReviewResult.fromJson(x)).toList(),
      totalReviews: total,
    );
  }
}

class ReviewResult {
  final String id;
  final String bookId;
  final ReviewUser userId;
  final double rating;
  final String review;
  final DateTime createdAt;

  ReviewResult({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory ReviewResult.fromJson(Map<String, dynamic> json) {
    return ReviewResult(
      id: json['_id'],
      bookId: json['bookId'],
      userId: ReviewUser.fromJson(json['userId']),
      rating: (json['rating'] as num).toDouble(),
      review: json['review'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ReviewUser {
  final String id;
  final String profile;
  final String fullName;

  ReviewUser({
    required this.id,
    required this.profile,
    required this.fullName,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['_id'],
      profile: json['profile'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }
}
