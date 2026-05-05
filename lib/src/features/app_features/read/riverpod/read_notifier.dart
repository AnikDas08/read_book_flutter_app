import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_tamplates/config/constance/constants.dart';
import 'package:riverpod_tamplates/config/storage/storage_service.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/data/model/book_model.dart';
import 'package:riverpod_tamplates/src/features/app_features/read/riverpod/read_state.dart';

part 'read_notifier.g.dart';

// Storage keys for reading preferences
const _kFontSize = 'reading_font_size';
const _kLineSpacing = 'reading_line_spacing';
const _kBackgroundMode = 'reading_background_mode';
const _kReadingMode = 'reading_mode';

@Riverpod(keepAlive: true)
class ReadNotifier extends _$ReadNotifier {
  final _storage = StorageService.instance;

  @override
  ReadState build() {
    ref.keepAlive();
    _loadSettings();
    return const ReadState();
  }

  /// Loads persisted reading settings from storage.
  Future<void> _loadSettings() async {
    final fontSize = await _storage.get(_kFontSize);
    final lineSpacing = await _storage.get(_kLineSpacing);
    final backgroundMode = await _storage.get(_kBackgroundMode);
    final readingMode = await _storage.get(_kReadingMode);

    state = state.copyWith(
      fontSize: fontSize != null ? double.tryParse(fontSize) ?? 14 : 14,
      lineSpacing: lineSpacing != null
          ? double.tryParse(lineSpacing) ?? 1.0
          : 1.0,
      selectedMode: backgroundMode != null
          ? int.tryParse(backgroundMode) ?? 0
          : 0,
      readingMode: readingMode != null
          ? ReadingMode.values.firstWhere(
              (e) => e.name == readingMode,
              orElse: () => ReadingMode.slide,
            )
          : ReadingMode.slide,
    );
  }

  /// Saves current reading settings to storage.
  Future<void> _saveSettings() async {
    await _storage.set(_kFontSize, state.fontSize.toString());
    await _storage.set(_kLineSpacing, state.lineSpacing.toString());
    await _storage.set(_kBackgroundMode, state.selectedMode.toString());
    await _storage.set(_kReadingMode, state.readingMode.name);
  }

  void toggleAudioPlaying() {
    final nextValue = !state.isAudioPlaying;
    state = state.copyWith(
      isAudioPlaying: nextValue,
      isActionPanelVisible: nextValue ? false : state.isActionPanelVisible,
    );
  }

  void selectBook() {
    state = state.copyWith(
      slectedBook: BookModel(
        title: 'Shadow of the Violet Moon',
        author: 'M. M. KAYE',
        coverImage: Constants.sampleImage,
        chapters: [
          const BookChapter(
            title: 'Chapter 1: The Beginning',
            pages: [
              'The night was darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.\n\nThe city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.\n\n"You\'re late," a voice said from the shadows.\n\nViolet froze. She knew that voice. It had haunted her dreams for years.\n\n"I didn\'t think you\'d come," she replied, her voice steadier than she felt.\n\nA figure emerged from the darkness. Tall, imposing, with eyes that seemed to glow in the dim light. This was the man who had changed everything. The man who had awakened powers within her that she never knew existed.\n\n"We need to talk," he said simply. "About what you are. About what you\'re meant to become."\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\n"I\'m listening," she said.\n\nAnd with those two words, her destiny began to unfold.',
              'The night was 2 darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.\n\nThe city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.\n\n"You\'re late," a voice said from the shadows.\n\nViolet froze. She knew that voice. It had haunted her dreams for years.\n\n"I didn\'t think you\'d come," she replied, her voice steadier than she felt.\n\nA figure emerged from the darkness. Tall, imposing, with eyes that seemed to glow in the dim light. This was the man who had changed everything. The man who had awakened powers within her that she never knew existed.\n\n"We need to talk," he said simply. "About what you are. About what you\'re meant to become."\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\n"I\'m listening," she said.\n\nAnd with those two words, her destiny began to unfold.',
              'The night was 3 darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.\n\nThe city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.\n\n"You\'re late," a voice said from the shadows.\n\nViolet froze. She knew that voice. It had haunted her dreams for years.\n\n"I didn\'t think you\'d come," she replied, her voice steadier than she felt.\n\nA figure emerged from the darkness. Tall, imposing, with eyes that seemed to glow in the dim light. This was the man who had changed everything. The man who had awakened powers within her that she never knew existed.\n\n"We need to talk," he said simply. "About what you are. About what you\'re meant to become."\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\n"I\'m listening," she said.\n\nAnd with those two words, her destiny began to unfold.',
            ],
          ),
          const BookChapter(
            title: 'Chapter 2: Awakening Powers',
            pages: [
              'The dawn brought no relief. Violet had spent the entire night staring at the ceiling, the man\'s words echoing in her mind. What did he mean by "what you are"? She had always felt different, sure, but she assumed it was just the isolation of her upbringing.\n\nBut then there were the incidents. The time she had accidentally shattered a glass without touching it. The moments when she could swear she heard people\'s thoughts before they spoke. She had dismissed them as coincidences, or perhaps she was just losing her mind.\n\nNow, she wasn\'t so sure. She looked at her hands, half-expecting them to start glowing. They looked normal enough. Pale, slender, a bit shaky.\n\nShe needed answers. And there was only one person who could give them to her.\n\nShe found him exactly where he said he would be. At the old library on the edge of town, a place that had been closed for decades but somehow seemed perfectly maintained.\n\nHe was waiting for her in the back, surrounded by ancient tomes and the smell of dust and parchment. He didn\'t look up when she entered.\n\n"You came," he said, his voice a low rumble.\n\n"I have questions," Violet replied, her voice firm.\n\nHe finally looked up, a faint smile playing on his lips. "I would be disappointed if you didn\'t."\n\nHe stood and gestured to a chair. "Sit. Let us begin your education."',
              'The lesson began with a simple exercise. "Focus on the candle," he commanded. Violet looked at the small flame flickering on the table between them. "Now, I want you to feel the heat. Not with your skin, but with your mind."\n\nShe tried to do as he said, but it felt ridiculous. How do you feel heat with your mind? She closed her eyes, trying to concentrate. She could hear her own heartbeat, the soft rustle of his robes, the distant sound of traffic.\n\n"Don\'t think," he said. "Just feel."\n\nShe took a deep breath and tried to clear her mind. Gradually, the ambient noise faded. She focused all her attention on the candle. At first, there was nothing. But then, she felt a tiny spark. It wasn\'t hot, exactly, but it was... vibrant.\n\nShe reached out to it with her thoughts. The spark grew, spreading like a warm wave through her consciousness. It was exhilarating.\n\n"Open your eyes," he whispered.\n\nViolet opened them. The candle flame was no longer flickering. It was standing perfectly still, and it had turned a brilliant, pulsing violet.\n\nShe gasped, and the flame immediately returned to its normal orange hue, flickering wildly.\n\n"You see?" he said, his eyes shining with something like pride. "That is the beginning. That is your power."',
            ],
          ),
          const BookChapter(
            title: 'Chapter 3: First Lesson',
            pages: [
              'Days turned into weeks as Violet returned to the library every night. Her "education" was unlike anything she had ever experienced. It wasn\'t just about controlling her powers; it was about understanding the history of those who came before her.\n\n"We are the Keepers of the Shroud," he explained one evening. "We have existed as long as humanity itself, hidden in the shadows, protecting the world from the things that crawl in the dark."\n\nViolet listened, enthralled. She learned about the war between the light and the dark, a conflict that had been raging for millennia. She learned about the different types of powers—telekinesis, telepathy, elemental control.\n\nAnd she learned about her own unique gift. "You are a Weaver," he told her. "You can manipulate the very fabric of reality. It is a rare and dangerous talent."\n\nShe felt a weight settle in her chest. Dangerous. She had always feared she was a monster. Now, she had proof that she was at least a weapon.\n\n"Can I stop?" she asked, her voice small.\n\nHe looked at her with a mixture of pity and resolve. "No, Violet. Once the power is awakened, it cannot be put back to sleep. You must learn to control it, or it will eventually control you."\n\nShe nodded, understanding the grim reality of her situation. There was no going back. Only forward, into a world she barely understood.\n\n"Good," he said. "Because tonight, your real training begins."',
              'The physical training was even more grueling than the mental exercises. He pushed her to her limits, forcing her to react with instinct rather than thought. They spent hours in the basement of the library, which turned out to be a vast, hidden training hall.\n\n"Again!" he barked as she fell for the third time. She was bruised, exhausted, and covered in sweat. Her muscles ached with every movement.\n\n"I can\'t," she gasped, struggling to get to her feet.\n\n"You must," he replied, his voice cold. "In the real world, your enemies won\'t wait for you to catch your breath."\n\nShe gritted her teeth and stood up. She channeled her frustration into her power. As he moved to strike again, she didn\'t try to block him. Instead, she reached out and "tugged" at the air around him.\n\nHe stumbled, caught off guard by the sudden distortion in reality. Violet didn\'t waste the opportunity. She threw a burst of energy at him, knocking him back several feet.\n\nHe landed gracefully, but there was a look of genuine surprise on his face. He slowly stood up and brushed himself off.\n\n"Well done," he said, and for the first time, she saw a hint of a smile. "You\'re starting to think like a Weaver."\n\nViolet felt a surge of triumph. It was the first time she had ever bested him. It was a small victory, but it meant everything.',
              'The night was 1 darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.\n\nThe city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.\n\n"You\'re late," a voice said from the shadows.\n\nViolet froze. She knew that voice. It had haunted her dreams for years.\n\n"I didn\'t think you\'d come," she replied, her voice steadier than she felt.\n\nA figure emerged from the darkness. Tall, imposing, with eyes that seemed to glow in the dim light. This was the man who had changed everything. The man who had awakened powers within her that she never knew existed.\n\n"We need to talk," he said simply. "About what you are. About what you\'re meant to become."\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\n"I\'m listening," she said.\n\nAnd with those two words, her destiny began to unfold.',
              'The night was 2 darker than usual. Violet stepped out of her apartment, unaware that her life was about to change forever.\n\nThe city lights flickered in the distance, casting long shadows across the empty streets. She pulled her coat tighter around her shoulders, feeling a chill that had nothing to do with the weather.\n\n"You\'re late," a voice said from the shadows.\n\nViolet froze. She knew that voice. It had haunted her dreams for years.\n\n"I didn\'t think you\'d come," she replied, her voice steadier than she felt.\n\nA figure emerged from the darkness. Tall, imposing, with eyes that seemed to glow in the dim light. This was the man who had changed everything. The man who had awakened powers within her that she never knew existed.\n\n"We need to talk," he said simply. "About what you are. About what you\'re meant to become."\n\nViolet\'s hands trembled. She had spent her entire life running from the truth. But tonight, there would be no more running.\n\n"I\'m listening," she said.\n\nAnd with those two words, her destiny began to unfold.',
            ],
            isLocked: true,
            unlockAdsRequired: 2,
            watchedAds: 0,
            showSparkle: true,
          ),
          const BookChapter(
            title: 'Chapter 4: Shadows Stirring',
            pages: [
              'But the peace was not to last. As Violet grew stronger, so did the shadows that hunted her. She began to notice them everywhere—pale figures with hollow eyes, watching her from the corners of her vision. They never approached, but she could feel their malice.\n\n"They are the Wraiths," her mentor told her when she mentioned them. "They are attracted to your power like moths to a flame. They are scouts for the Dark Lord, sent to find you and bring you to him."\n\nViolet felt a cold dread settle in her stomach. "The Dark Lord?"\n\n"He is the one who leads the darkness," he explained. "He has been searching for a Weaver for centuries. With your power, he could finally tear down the Shroud and plunge the world into eternal night."\n\nShe looked at her hands, which were now steady and strong. She didn\'t feel like a weapon of mass destruction. She just felt like a girl who wanted to live her life.\n\n"We have to stop him," she said, her voice filled with a new-found determination.\n\n"Yes," he agreed. "But first, we must find the other Keepers. We cannot do this alone."\n\nAnd so, their journey began. A journey that would take them across the world, into hidden realms and ancient ruins, as they raced against the clock to prevent the end of the world.',
            ],
            isLocked: true,
            unlockAdsRequired: 3,
            watchedAds: 0,
          ),
        ],
        selectedChapter: 0,
      ),
      isAudioPlaying: false,
      isActionPanelVisible: false,
    );
  }

  void selectChapter(int index) {
    state = state.copyWith(
      slectedBook: state.slectedBook?.copyWith(selectedChapter: index),
    );
  }

  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size);
    _saveSettings();
  }

  void updateLineSpacing(double spacing) {
    state = state.copyWith(lineSpacing: spacing);
    _saveSettings();
  }

  void updateBackgroundMode(int mode) {
    state = state.copyWith(selectedMode: mode);
    _saveSettings();
  }

  void updateReadingMode(ReadingMode mode) {
    state = state.copyWith(readingMode: mode);
    _saveSettings();
  }

  void toggleActionPanel() {
    state = state.copyWith(isActionPanelVisible: !state.isActionPanelVisible);
  }

  void setActionPanelVisible(bool isVisible) {
    state = state.copyWith(isActionPanelVisible: isVisible);
  }

  void watchAdForCurrentChapter() {
    final book = state.slectedBook;
    if (book == null) return;
    final chapterIndex = book.selectedChapter;
    final chapters = [...book.chapters];
    
    // Find the first locked chapter starting from current or after
    int targetIndex = -1;
    for (int i = chapterIndex; i < chapters.length; i++) {
      if (chapters[i].isLocked) {
        targetIndex = i;
        break;
      }
    }
    
    if (targetIndex == -1) return;
    final chapter = chapters[targetIndex];

    final watchedAds = chapter.watchedAds + 1;
    final shouldUnlock = watchedAds >= chapter.unlockAdsRequired;

    chapters[targetIndex] = chapter.copyWith(
      watchedAds: watchedAds,
      isLocked: shouldUnlock ? false : chapter.isLocked,
    );

    state = state.copyWith(slectedBook: book.copyWith(
      chapters: chapters,
      selectedChapter: targetIndex, // Ensure we are targeting this chapter
    ));
  }

  bool unlockChapterWithStones(int cost) {
    final book = state.slectedBook;
    if (book == null) return false;
    
    final chapterIndex = book.selectedChapter;
    final chapters = [...book.chapters];
    
    // Find the first locked chapter
    int targetIndex = -1;
    for (int i = chapterIndex; i < chapters.length; i++) {
      if (chapters[i].isLocked) {
        targetIndex = i;
        break;
      }
    }
    
    if (targetIndex == -1) return false;

    chapters[targetIndex] = chapters[targetIndex].copyWith(
      isLocked: false,
    );

    state = state.copyWith(slectedBook: book.copyWith(
      chapters: chapters,
      selectedChapter: targetIndex,
    ));
    return true;
  }
}
