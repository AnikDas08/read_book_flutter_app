import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/data/model/book_model.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_state.dart';

part 'read_notifier.g.dart';

@Riverpod()
class ReadNotifier extends _$ReadNotifier {
  @override
  ReadState build() {
    return const ReadState();
  }

  void toggleAudioPlaying() {
    state = state.copyWith(isAudioPlaying: !state.isAudioPlaying);
  }

  void selectBook() {
    state = state.copyWith(
      slectedBook: BookModel(
        title: 'Shadow of the Violet Moon',
        chapters: [
          BookChapter(
            title: 'Chapter 1: The Beginning',
            content:
                'In the quiet town of Oakhaven, where shadows danced with secrets and the air hummed with unspoken magic, lived Elara, a young woman bound by duty and haunted by a past she barely remembered. Her days were spent tending to the town\'s ancient library, a sanctuary of forgotten lore and whispered histories. But beneath the veneer of normalcy, a darkness stirred, threatening to unravel the fragile peace of her world.',
          ),
          BookChapter(
            title: 'Chapter 2: The Journey',
            content:
                'One fateful evening, as a crimson moon painted the sky in hues of fire and blood, Elara stumbled upon a hidden passage within the library\'s depths. It led her to a realm beyond imagination, where mythical creatures roamed free and ancient prophecies awaited their fulfillment. With a reluctant heart, she embarked on a perilous journey, guided by cryptic clues and the whispers of the wind.',
          ),
          BookChapter(
            title: 'Chapter 3: The Discovery',
            content:
                'Along her path, Elara encountered a cast of extraordinary characters: a wise old mage with eyes that held the wisdom of ages, a mischievous sprite with a penchant for riddles, and a stoic warrior sworn to protect the balance of realms. Together, they navigated treacherous landscapes, deciphered ancient texts, and confronted formidable foes who sought to plunge the world into eternal darkness.',
          ),
          BookChapter(
            title: 'Chapter 4: The Conflict',
            content:
                'The climax arrived at the heart of the Shadowfell, a realm where light dared not tread. Elara, armed with newfound courage and the power of her ancestors, faced the Shadow Lord, a being of pure malevolence who craved dominion over all realms. The battle raged, shaking the very foundations of existence, as destinies hung in the balance.',
          ),
          BookChapter(
            title: 'Chapter 5: The Resolution',
            content:
                'In the end, it was not brute force but the power of unity and sacrifice that triumphed. Elara, embracing her true potential, restored balance to the realms, banishing the shadows and ushering in an era of peace. Yet, the echoes of her journey lingered, a testament to the courage that resided within even the most ordinary of souls.',
          ),
        ],
        selectedChapter: 0,
      ),
    );
  }

  void selectChapter(int index) {
    state = state.copyWith(slectedBook: state.slectedBook?.copyWith(selectedChapter: index));
  }

  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size);
  }

  void updateLineSpacing(double spacing) {
    state = state.copyWith(lineSpacing: spacing);
  }

  void updateBackgroundMode(int mode) {
    state = state.copyWith(selectedMode: mode);
  }
}
