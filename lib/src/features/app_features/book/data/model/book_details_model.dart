class BookDetailsModel {
  final String? id;
  final String? userId;
  final String? title;
  final String? coverImage;
  final String? description;
  final String? type;
  final String? genre;
  final String? age;
  final String? status;
  final List<String>? tags;
  final int? commentCount;
  final int? likeCount;
  final int? readCount;
  final int? reviewCount;
  final double? ratingCount;
  final int? chapterCount;
  final int? voteCount;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final int? pageCount;
  final bool? isFavorite;
  final bool? isWantToRead;

  BookDetailsModel({
    this.id,
    this.userId,
    this.title,
    this.coverImage,
    this.description,
    this.type,
    this.genre,
    this.age,
    this.status,
    this.tags,
    this.commentCount,
    this.likeCount,
    this.readCount,
    this.reviewCount,
    this.ratingCount,
    this.chapterCount,
    this.voteCount,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.pageCount,
    this.isFavorite,
    this.isWantToRead,
  });

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      coverImage: json['coverImage'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      genre: json['genre'] as String?,
      age: json['age'] as String?,
      status: json['status'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      commentCount: json['commentCount'] as int?,
      likeCount: json['likeCount'] as int?,
      readCount: json['readCount'] as int?,
      reviewCount: json['reviewCount'] as int?,
      ratingCount: (json['ratingCount'] as num?)?.toDouble(),
      chapterCount: json['chapterCount'] as int?,
      voteCount: json['voteCount'] as int?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      pageCount: json['pageCount'] as int?,
      isFavorite: json['isFavorite'] as bool?,
      isWantToRead: json['isWantToRead'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'title': title,
      'coverImage': coverImage,
      'description': description,
      'type': type,
      'genre': genre,
      'age': age,
      'status': status,
      'tags': tags,
      'commentCount': commentCount,
      'likeCount': likeCount,
      'readCount': readCount,
      'reviewCount': reviewCount,
      'ratingCount': ratingCount,
      'chapterCount': chapterCount,
      'voteCount': voteCount,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'pageCount': pageCount,
      'isFavorite': isFavorite,
      'isWantToRead': isWantToRead,
    };
  }
}
