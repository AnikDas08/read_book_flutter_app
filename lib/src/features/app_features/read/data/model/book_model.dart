class BookModel {
  final String? id;
  final String? title;
  final String? description;
  final String? coverImage;
  final String? author;
  final String? genre;
  final String? language;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final List<BookChapter> chapters;
  final int selectedChapter;

  BookModel({
    this.id,
    this.title,
    this.description,
    this.coverImage,
    this.author,
    this.genre,
    this.language,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.chapters = const [],
    this.selectedChapter = 0,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    coverImage: json["cover_image"],
    author: json["author"],
    genre: json["genre"],
    language: json["language"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    chapters: json["chapters"] == null
        ? []
        : List<BookChapter>.from(
            json["chapters"]!.map((x) => BookChapter.fromJson(x)),
          ),
    selectedChapter: json["selected_chapter"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "cover_image": coverImage,
    "author": author,
    "genre": genre,
    "language": language,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
    "selected_chapter": selectedChapter,
  };

  BookModel copyWith({
    String? id,
    String? title,
    String? description,
    String? coverImage,
    String? author,
    String? genre,
    String? language,
    String? status,
    String? createdAt,
    String? updatedAt,
    List<BookChapter>? chapters,
    int? selectedChapter,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      language: language ?? this.language,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      chapters: chapters ?? this.chapters,
      selectedChapter: selectedChapter ?? this.selectedChapter,
    );
  }
}

class BookChapter {
  final String? id;
  final String? title;
  final String? createdAt;
  final String? updatedAt;
  final bool isLocked;
  final int unlockAdsRequired;
  final int watchedAds;
  final bool showSparkle;
  final List<String> pages;

  const BookChapter({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.isLocked = false,
    this.unlockAdsRequired = 0,
    this.watchedAds = 0,
    this.showSparkle = false,
    this.pages = const [],
  });

  factory BookChapter.fromJson(Map<String, dynamic> json) => BookChapter(
    id: json["id"],
    title: json["title"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    pages: json["pages"] == null
        ? []
        : List<String>.from(json["pages"]!.map((x) => x)),
    isLocked: json["is_locked"] ?? false,
    unlockAdsRequired: json["unlock_ads_required"] ?? 0,
    watchedAds: json["watched_ads"] ?? 0,
    showSparkle: json["show_sparkle"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "is_locked": isLocked,
    "unlock_ads_required": unlockAdsRequired,
    "watched_ads": watchedAds,
    "show_sparkle": showSparkle,
    "pages": List<dynamic>.from(pages.map((x) => x)),
  };

  BookChapter copyWith({
    String? id,
    String? title,
    String? createdAt,
    String? updatedAt,
    bool? isLocked,
    int? unlockAdsRequired,
    int? watchedAds,
    List<String>? pages,
    bool? showSparkle,
  }) {
    return BookChapter(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pages: pages ?? this.pages,
      isLocked: isLocked ?? this.isLocked,
      unlockAdsRequired: unlockAdsRequired ?? this.unlockAdsRequired,
      watchedAds: watchedAds ?? this.watchedAds,
      showSparkle: showSparkle ?? this.showSparkle,
    );
  }
}
