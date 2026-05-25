import 'package:equatable/equatable.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/read/data/model/book_model.dart';

enum ReadingMode { slide, flip, scroll }

class ReadState extends Equatable {
  final BookModel? slectedBook;
  final bool isAudioPlaying;
  final double fontSize;
  final double lineSpacing;
  final int selectedMode;
  final ReadingMode readingMode;
  final bool isActionPanelVisible;
  final bool isLoading;
  final String? errorMessage;

  const ReadState({
    this.slectedBook,
    this.isAudioPlaying = false,
    this.fontSize = 14,
    this.lineSpacing = 1,
    this.selectedMode = 0,
    this.readingMode = ReadingMode.slide,
    this.isActionPanelVisible = false,
    this.isLoading = false,
    this.errorMessage,
  });

  ReadState copyWith({
    BookModel? slectedBook,
    bool? isAudioPlaying,
    double? fontSize,
    double? lineSpacing,
    int? selectedMode,
    ReadingMode? readingMode,
    bool? isActionPanelVisible,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ReadState(
      slectedBook: slectedBook ?? this.slectedBook,
      isAudioPlaying: isAudioPlaying ?? this.isAudioPlaying,
      fontSize: fontSize ?? this.fontSize,
      lineSpacing: lineSpacing ?? this.lineSpacing,
      selectedMode: selectedMode ?? this.selectedMode,
      readingMode: readingMode ?? this.readingMode,
      isActionPanelVisible: isActionPanelVisible ?? this.isActionPanelVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // Notice we don't do ?? here because we want to be able to set it to null
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
    isLoading,
    errorMessage,
  ];
}
