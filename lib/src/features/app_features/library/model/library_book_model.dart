import 'package:unkutdrama_kpnovel/src/features/app_features/home/data/model/home_book_model.dart';

class LibraryBookModel {
  final String sId;
  final String type;
  final String userId;
  final BookId bookId;
  final String? chapterId;
  final bool isWantToRead;
  final int totalCharacterCount;
  final int readCharacterCount;

  const LibraryBookModel({
    this.sId = '',
    this.type = '',
    this.userId = '',
    this.bookId = const BookId(),
    this.chapterId,
    this.isWantToRead = false,
    this.totalCharacterCount = 0,
    this.readCharacterCount = 0,
  });

  HomeBookModel toHomeBookModel() {
    return HomeBookModel(
      id: bookId.sId,
      title: bookId.title,
      coverImage: bookId.coverImage,
      description: '', // Not available in LibraryBookModel
      commentCount: 0,
      reviewCount: 0,
      ratingCount: bookId.ratingCount,
    );
  }

  factory LibraryBookModel.fromJson(Map<String, dynamic> json) {
    return LibraryBookModel(
      sId: json['_id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      bookId: json['bookId'] != null
          ? BookId.fromJson(json['bookId'])
          : const BookId(),
      chapterId: json['chapterId']?.toString(),
      isWantToRead: json['isWantToRead'] ?? false,
      totalCharacterCount: json['totalCharacterCount'] ?? 0,
      readCharacterCount: json['readCharacterCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'type': type,
      'userId': userId,
      'bookId': bookId.toJson(),
      'chapterId': chapterId,
      'isWantToRead': isWantToRead,
      'totalCharacterCount': totalCharacterCount,
      'readCharacterCount': readCharacterCount,
    };
  }

  LibraryBookModel copyWith({
    String? sId,
    String? type,
    String? userId,
    BookId? bookId,
    String? chapterId,
    bool? isWantToRead,
    int? totalCharacterCount,
    int? readCharacterCount,
  }) {
    return LibraryBookModel(
      sId: sId ?? this.sId,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      chapterId: chapterId ?? this.chapterId,
      isWantToRead: isWantToRead ?? this.isWantToRead,
      totalCharacterCount:
      totalCharacterCount ?? this.totalCharacterCount,
      readCharacterCount:
      readCharacterCount ?? this.readCharacterCount,
    );
  }
}

class BookId {
  final String sId;
  final String title;
  final String coverImage;
  final double ratingCount;

  const BookId({
    this.sId = '',
    this.title = '',
    this.coverImage = '',
    this.ratingCount = 0.0,
  });

  factory BookId.fromJson(Map<String, dynamic> json) {
    return BookId(
      sId: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      coverImage: json['coverImage']?.toString() ?? '',
      ratingCount: (json['ratingCount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'coverImage': coverImage,
      'ratingCount': ratingCount,
    };
  }

  BookId copyWith({
    String? sId,
    String? title,
    String? coverImage,
    double? ratingCount,
  }) {
    return BookId(
      sId: sId ?? this.sId,
      title: title ?? this.title,
      coverImage: coverImage ?? this.coverImage,
      ratingCount: ratingCount ?? this.ratingCount,
    );
  }
}