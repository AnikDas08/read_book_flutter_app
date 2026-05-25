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
  final int totalCharacterCount;
  final int readCharacterCount;

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
    this.totalCharacterCount = 0,
    this.readCharacterCount = 0,
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
    totalCharacterCount: json["totalCharacterCount"] ?? 0,
    readCharacterCount: json["readCharacterCount"] ?? 0,
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
    "totalCharacterCount": totalCharacterCount,
    "readCharacterCount": readCharacterCount,
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
    int? totalCharacterCount,
    int? readCharacterCount,
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
      totalCharacterCount: totalCharacterCount ?? this.totalCharacterCount,
      readCharacterCount: readCharacterCount ?? this.readCharacterCount,
    );
  }

  factory BookChapter.fromBackendJson(Map<String, dynamic> json, int index) {
    final rawText = json['text'] as String? ?? '';
    final plainText = _convertHtmlToPlainText(rawText);
    final pagesList = _paginateText(plainText);

    // First 2 chapters are unlocked, subsequent are locked
    final isChLocked = index >= 2;
    
    final totalChar = json['totalCharacterCount'] as int? ?? 0;
    final readChar = json['readCharacterCount'] as int? ?? 0;

    return BookChapter(
      id: json['_id'] as String?,
      title: json['title'] as String? ?? 'Chapter ${index + 1}',
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isLocked: isChLocked,
      unlockAdsRequired: isChLocked ? (index == 2 ? 2 : 3) : 0,
      watchedAds: 0,
      showSparkle: index == 2,
      pages: pagesList,
      totalCharacterCount: totalChar,
      readCharacterCount: readChar,
    );
  }

  static String _convertHtmlToPlainText(String html) {
    var text = html;
    text = text.replaceAll('</h1>', '\n\n');
    text = text.replaceAll('</h2>', '\n\n');
    text = text.replaceAll('</h3>', '\n\n');
    text = text.replaceAll('</p>', '\n\n');
    text = text.replaceAll('<br>', '\n');
    text = text.replaceAll('<br/>', '\n');
    text = text.replaceAll('<br />', '\n');

    text = text.replaceAll(RegExp(r'<[^>]*>'), '');

    text = text.replaceAll('&nbsp;', ' ');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&lt;', '<');
    text = text.replaceAll('&gt;', '>');
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll('&#39;', "'");

    return text.trim();
  }

  static List<String> _paginateText(String plainText) {
    final paragraphs = plainText
        .split('\n\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();
    if (paragraphs.isEmpty) return [];

    final pages = <String>[];
    var currentPageParagraphs = <String>[];
    var currentLinesCount = 0;
    const maxLinesPerPage = 30;
    const charsPerLine = 40;

    for (final p in paragraphs) {
      var pLines = 0;
      final subLines = p.split('\n');
      for (final line in subLines) {
        pLines += (line.length / charsPerLine).ceil();
      }

      final spacingLines = currentPageParagraphs.isEmpty ? 0 : 1;
      final addedLines = pLines + spacingLines;

      if (currentLinesCount + addedLines > maxLinesPerPage &&
          currentPageParagraphs.isNotEmpty) {
        pages.add(currentPageParagraphs.join('\n\n'));
        currentPageParagraphs = [p];
        currentLinesCount = pLines;
      } else {
        currentPageParagraphs.add(p);
        currentLinesCount += addedLines;
      }
    }

    if (currentPageParagraphs.isNotEmpty) {
      pages.add(currentPageParagraphs.join('\n\n'));
    }

    return pages;
  }
}
