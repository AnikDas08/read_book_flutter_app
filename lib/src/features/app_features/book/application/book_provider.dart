import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/model/book_details_model.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/repository/book_repository.dart';

final bookDetailsProvider = FutureProvider.autoDispose
    .family<BookDetailsModel, String>((ref, bookId) async {
      final repository = ref.watch(bookRepositoryProvider);
      final response = await repository.getBookDetails(bookId);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw response.message ?? 'Failed to fetch book details';
      }
    });

class BookVoteState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final int? earnedAmount;
  final int? totalAmount;

  const BookVoteState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.earnedAmount,
    this.totalAmount,
  });

  BookVoteState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    int? earnedAmount,
    int? totalAmount,
  }) {
    return BookVoteState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      earnedAmount: earnedAmount ?? this.earnedAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

class BookVoteNotifier extends StateNotifier<BookVoteState> {
  final BookRepository _repository;
  final Ref _ref;

  BookVoteNotifier(this._repository, this._ref) : super(const BookVoteState());

  Future<void> vote(String bookId) async {
    state = const BookVoteState(isLoading: true);
    try {
      final response = await _repository.voteBook(bookId);
      if (response.isSuccess) {
        state = const BookVoteState(isLoading: false, isSuccess: true);
        _ref.invalidate(bookDetailsProvider(bookId));
      } else {
        state = const BookVoteState(isLoading: false);
      }
    } catch (e) {
      state = BookVoteState(isLoading: false, errorMessage: e.toString());
    }
  }
}

final bookVoteProvider =
    StateNotifierProvider.autoDispose<BookVoteNotifier, BookVoteState>((ref) {
      final repository = ref.watch(bookRepositoryProvider);
      return BookVoteNotifier(repository, ref);
    });
