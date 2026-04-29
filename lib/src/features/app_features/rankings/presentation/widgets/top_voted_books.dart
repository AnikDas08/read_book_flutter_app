import 'package:core_kit/core_kit_internal.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/gen/assets.gen.dart';
import 'package:riverpod_tamplates/src/constants/app_font_sizes.dart';

class TopVotedBooks extends StatelessWidget {
  const TopVotedBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Top Voted Books',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),

          // 1. CHAMPION CARD (Horizontal Layout)
          BookRankCard(
            rank: 1,
            title: 'Echoes of Tomorrow',
            author: 'Dr. Sarah Chen',
            votes: '5.9K',
            rankLabel: 'CHAMPION',
            baseColor: Color(0xFFE5A524),
            isHorizontal: true,
          ),

          SizedBox(height: 16),

          // 2. SILVER & BRONZE ROW (Vertical Layout)
          Row(
            children: [
              Expanded(
                child: BookRankCard(
                  rank: 2,
                  title: "Billionaire's Secret",
                  author: 'Amanda Rose',
                  votes: '4.7K',
                  rankLabel: 'SILVER',
                  baseColor: Color(0xFF7E8A9C),
                  isHorizontal: false,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: BookRankCard(
                  rank: 3,
                  title: 'Love in the',
                  author: 'Victoria Sterling',
                  votes: '4.6K',
                  rankLabel: 'BRONZE',
                  baseColor: Color(0xFF8D5B3A),
                  isHorizontal: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookRankCard extends StatelessWidget {
  final int rank;
  final String title;
  final String author;
  final String votes;
  final String rankLabel;
  final Color baseColor;
  final bool isHorizontal;

  const BookRankCard({
    super.key,
    required this.rank,
    required this.title,
    required this.author,
    required this.votes,
    required this.rankLabel,
    required this.baseColor,
    required this.isHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: isHorizontal ? _buildHorizontal() : _buildVertical(),
    );
  }

  Widget _buildHorizontal() {
    return Row(
      children: [
        _buildImageWithBadge(80, 110),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRankBadge(),
              CommonText(
                text: title,
                style: _titleStyle(18),
                textAlign: .start,
              ),
              CommonText(style: _authorStyle(), text: author),
              6.height,
              _buildVoteChip(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVertical() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageWithBadge(double.infinity, 140),
        4.height,
        _buildRankBadge(),
        CommonText(
          text: title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          autoResize: false,
          style: _titleStyle(16),
        ),
        CommonText(text: author, style: _authorStyle()),
        4.height,
        _buildVoteChip(width: double.infinity),
      ],
    );
  }

  Widget _buildImageWithBadge(double width, double height) {
    var rankImage = '';
    if (rank == 1) {
      rankImage = Assets.images.rank1;
    } else if (rank == 2) {
      rankImage = Assets.images.rank2;
    } else if (rank == 3) {
      rankImage = Assets.images.rank3;
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CommonImage(
          src: Constants.sampleImage,
          width: width,
          height: height,
          borderRadius: 16,
          borderWidth: 3,
          borderColor: Colors.white,
        ),
        Positioned(
          top: -4,
          right: -4,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: CommonImage(src: rankImage, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildRankBadge() {
    return Row(
      children: [
        Text(
          '$rank',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        4.width,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            rankLabel,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppFontSizes.small.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVoteChip({double? width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt, color: Colors.white, size: 16),
          Text(
            ' $votes votes',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _titleStyle(double size) => TextStyle(
    color: Colors.white,
    fontSize: size,
    fontWeight: FontWeight.bold,
  );
  TextStyle _authorStyle() =>
      TextStyle(color: Colors.white.withValues(alpha: .9), fontSize: 14);
}
