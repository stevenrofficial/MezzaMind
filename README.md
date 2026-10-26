# MezzaMind 🎧⚡

**MezzaMind** is an ambient functional audio and soundscape mobile application engineered for deep work, late-night coding, and cognitive flow. It blends neural frequency entrainment (Gamma, Beta, Theta, Delta waves) with dynamic procedural soundscapes, distraction-free aesthetics, and an integrated session timer.

---

## Architecture Overview

MezzaMind is built following clean architecture and feature-first separation:

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart           # Dark mode & OLED-optimized color palette
│   │   └── soundscape_presets.dart   # Soundscape presets across 4 neural modes
│   ├── routing/
│   │   └── app_router.dart           # Named route definitions
│   ├── services/
│   │   ├── audio_engine_service.dart # Singleton managing playback, looping, intensity
│   │   └── storage_service.dart      # Persistence for volume, streak, preferences
│   └── theme/
│       └── app_theme.dart            # Plus Jakarta Sans / JetBrains typography
├── features/
│   ├── dashboard/
│   │   └── main_dashboard_screen.dart # Docked container with persistent mini-player
│   ├── player/
│   │   ├── models/                   # Soundscape & SoundscapeMode models
│   │   ├── viewmodels/               # PlayerViewModel
│   │   ├── views/                    # PlayerScreen (Dashboard)
│   │   └── widgets/                  # VisualizerOrb, ModePills, Cards, VolumeSliders
│   ├── timer/
│   │   ├── models/                   # TimerType, TimerStatus, FocusPreset
│   │   ├── viewmodels/               # TimerViewModel (Pomodoro / Open Sprint)
│   │   ├── views/                    # TimerScreen
│   │   └── widgets/                  # TimerCountdownClock
│   └── settings/
│       ├── viewmodels/               # SettingsViewModel
│       └── views/                    # SettingsScreen & Stats Counter
└── main.dart                         # Entry point & Provider injection
```

---

## Core Features Scaffolding

1. **Audio Engine Service (`AudioEngineService`)**
   - Singleton audio orchestrator wrapping `just_audio` and `just_audio_background`.
   - Indefinite looping for ambient soundscapes (`LoopMode.one`).
   - Dynamic scaling combining master output volume and ambient intensity texture.
   - Smooth fadeout transitions for session timer completion.
   - Lock screen & notification media controls configured for iOS and Android.

2. **Main Player Dashboard UI (`PlayerScreen`)**
   - **Central Animated Visualizer Orb**: Multi-ring concentric sonic waves pulsing dynamically during active playback.
   - **Mode Selector**: Instant switching between **Coding Flow** (16Hz Beta), **Deep Focus** (40Hz Gamma), **Zen Relax** (6Hz Theta), and **Deep Sleep** (2Hz Delta).
   - **Dual Control Sliders**: Master Volume and Soundscape Intensity scaling.
   - **Binaural Entrainment Sync**: Fast toggle for binaural frequency entrainment.
   - **Preset Carousel & Cards**: Ambient stream presets with neural frequency tags.

3. **Session Timer (`TimerViewModel` & `TimerScreen`)**
   - Focus presets: 15m (Quick Sprint), 25m (Pomodoro), 45m (Deep Dive), 60m (Architecture), 90m (Ultradian Flow).
   - Switchable between **Countdown** mode and **Open Sprint** (Stopwatch) mode.
   - Optional automatic soundscape fadeout when timer concludes.
   - Local tracking of total deep work minutes and completed sessions.

4. **Settings & Customization (`SettingsScreen`)**
   - Pure OLED Black toggle for maximum contrast on OLED displays.
   - Productivity statistics dashboard.
   - Offline cache and preference reset utilities.

5. **Persistent Mini-Player (`PersistentMiniPlayer`)**
   - Bottom-docked player bar allowing uninterrupted playback control while navigating the Focus Timer or Settings.

---

## Getting Started

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run the App
```bash
# Run on iOS simulator / connected device
flutter run -d ios

# Run on Android emulator / connected device
flutter run -d android

# Run on macOS desktop
flutter run -d macos
```

### 3. Run Analysis & Tests
```bash
flutter analyze
flutter test
```
