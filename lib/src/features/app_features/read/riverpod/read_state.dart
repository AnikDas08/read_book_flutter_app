import 'package:equatable/equatable.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/data/model/book_model.dart';

enum ReadingMode { slide, flip, scroll }

class ReadState extends Equatable {
  final BookModel? slectedBook;
  final bool isAudioPlaying;
  final double fontSize;
  final double lineSpacing;
  final int selectedMode;
  final ReadingMode readingMode;
  final bool isActionPanelVisible;

  const ReadState({
    this.slectedBook,
    this.isAudioPlaying = false,
    this.fontSize = 14,
    this.lineSpacing = 1,
    this.selectedMode = 0,
    this.readingMode = ReadingMode.slide,
    this.isActionPanelVisible = true,
  });

  ReadState copyWith({
    BookModel? slectedBook,
    bool? isAudioPlaying,
    double? fontSize,
    double? lineSpacing,
    int? selectedMode,
    ReadingMode? readingMode,
    bool? isActionPanelVisible,
  }) {
    return ReadState(
      slectedBook: slectedBook ?? this.slectedBook,
      isAudioPlaying: isAudioPlaying ?? this.isAudioPlaying,
      fontSize: fontSize ?? this.fontSize,
      lineSpacing: lineSpacing ?? this.lineSpacing,
      selectedMode: selectedMode ?? this.selectedMode,
      readingMode: readingMode ?? this.readingMode,
      isActionPanelVisible: isActionPanelVisible ?? this.isActionPanelVisible,
    );
  }

  @override
  List<Object?> get props => [
    slectedBook,
    isAudioPlaying,
    fontSize,
    lineSpacing,
    selectedMode,
    readingMode,
    isActionPanelVisible,
  ];
}
