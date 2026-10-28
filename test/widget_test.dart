import 'package:flutter_test/flutter_test.dart';
import 'package:mezzamind/core/constants/soundscape_presets.dart';
import 'package:mezzamind/features/player/models/soundscape_mode.dart';

void main() {
  test('Soundscape presets are configured for each focus mode', () {
    expect(SoundscapePresets.all.isNotEmpty, isTrue);

    for (final mode in SoundscapeMode.values) {
      final presets = SoundscapePresets.getByMode(mode);
      expect(presets.isNotEmpty, isTrue,
          reason: 'Mode ${mode.title} should have at least one preset');
    }
  });

  test('Default preset has valid audio stream URL and frequencies', () {
    final defaultItem = SoundscapePresets.defaultSoundscape;
    expect(defaultItem.audioUrl.isNotEmpty, isTrue);
    expect(defaultItem.binauralHz.isNotEmpty, isTrue);
  });
}
