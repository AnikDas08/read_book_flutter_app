import 'package:core_kit/core_kit_internal.dart';
import 'package:core_kit/network/dio_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unkutdrama_kpnovel/config/constance/app_string.dart';
import 'package:unkutdrama_kpnovel/config/theme/app_theme_data.dart';
import 'package:unkutdrama_kpnovel/src/constants/app_font_sizes.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/application/book_review_provider.dart';
import 'package:unkutdrama_kpnovel/src/features/app_features/book/data/repository/book_repository.dart';

class WriteReviewModalWidget extends ConsumerStatefulWidget {
  const WriteReviewModalWidget({super.key, required this.bookId});
  final String bookId;

  @override
  ConsumerState<WriteReviewModalWidget> createState() => _WriteReviewModalWidgetState();
}

class _WriteReviewModalWidgetState extends ConsumerState<WriteReviewModalWidget> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_rating == 0) {
      DioUtils.showMessage('Please select a rating', isError: true);
      return;
    }
    if (_reviewController.text.isEmpty) {
      DioUtils.showMessage('Please write a review', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final repository = ref.read(bookRepositoryProvider);
    final response = await repository.createReview(
      bookId: widget.bookId,
      rating: _rating.toDouble(),
      review: _reviewController.text,
    );

    setState(() => _isLoading = false);

    if (response.isSuccess) {
      ref.invalidate(bookReviewProvider(widget.bookId));
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: context.color.ctaGradientBackgroundAccent,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'Write Your Review',
                              fontSize: AppFontSizes.extraLarge,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.white,
                            ),
                            SizedBox(height: 12),
                            CommonText(
                              text: 'Share your thoughts',
                              fontSize: AppFontSizes.medium,
                              fontWeight: FontWeight.w400,
                              textColor: Color(0xFFE7D6FF),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.w, 22.h, 22.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: 'Your Rating',
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w400,
                    textColor: Color(0xFF758195),
                  ),
                  14.height,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 18.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F7FB),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        5,
                        (index) => GestureDetector(
                          onTap: () => setState(() => _rating = index + 1),
                          child: Icon(
                            index < _rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 48,
                            color: index < _rating
                                ? const Color(0xFFFFC700)
                                : const Color(0xFFD0D5DD),
                          ),
                        ),
                      ),
                    ),
                  ),
                  20.height,
                  const CommonText(
                    text: 'Your Review',
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w400,
                    textColor: Color(0xFF758195),
                  ),
                  14.height,
                  CommonMultilineTextField(
                    controller: _reviewController,
                    height: 148.h,
                    hintText: AppString.share_your_thoughts_about_this_book,
                    hintStyle: const TextStyle(
                      color: Color(0xFFB1B8C7),
                      fontSize: AppFontSizes.medium,
                    ),
                    validationType: ValidationType.validateRequired,
                  ),
                  24.height,
                  GestureDetector(
                    onTap: _isLoading ? null : _submitReview,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8C86FF), Color(0xFFA98EF7)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      child: _isLoading 
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Icon(
                                Icons.send_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              CommonText(
                                text: 'Submit Review',
                                fontSize: AppFontSizes.extraLarge,
                                fontWeight: FontWeight.w700,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
