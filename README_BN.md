# PolyLingo AI — Android Source Project (v0.1.1)

**Status: source-code prototype. Not a compiled/tested APK.** This repository is a native Kotlin Android project, not a completed production translator. There is no model bundle in this ZIP. The Android SDK/Gradle and network access required to compile/test the APK were not available in the authoring environment.

## User specification

- Device target: Android smartphone, 12 GB RAM / 256 GB storage.
- Text translation: Bengali (`bn`), English (`en`), Arabic (`ar`), Hindi (`hi`), Urdu (`ur`), all directions.
- Speech recognition and pronunciation / TTS: **English and Arabic only**.
- Dark and light themes, Bengali/English interface labels, automatic language identification, text selection integration, history, favorites, copy, share, basic spelling/grammar rules.

## What is actually implemented in source

| Feature | Status / limitation |
|---|---|
| 5-language text translation | ML Kit on-device engine; requires initial language model downloads; not bundled |
| Auto language detection | ML Kit language-id + Unicode script hints; Urdu/Arabic short text can be ambiguous |
| Select text > PolyLingo AI | Android `ACTION_PROCESS_TEXT`; depends on whether the originating app exposes text-selection actions |
| Text sharing into app | Android `ACTION_SEND` text/plain |
| Speech-to-text | Android on-device SpeechRecognizer (Android 12+); English/Arabic only; requires a compatible installed offline recognition engine and language models |
| Voice translation | Recognized English/Arabic speech is passed to the text translator automatically |
| Text-to-speech | Android TextToSpeech, explicitly filters out network-required voices; English/Arabic only; requires offline voice data already installed |
| Spelling/grammar | **Small built-in rule set only**, not comprehensive AI grammar correction |
| History/favorites | Local SQLite database; no cloud backup |
| Copy/share/paste | Implemented |
| Dark/light theme | Implemented with native Android views |
| Floating overlay, accessibility-wide extraction, OCR | **Not implemented**; intentionally avoids intrusive accessibility permission |
| Completely offline from first install | **Not achieved**: translation model packs must be downloaded once; offline speech packs must be installed on phone |
| Production QA | **Not done**: no APK build, instrumentation or device testing in authoring environment |

## Building the project

1. Install Android Studio with Android SDK Platform 35, Android Build Tools 35, JDK 17, and Gradle 8.9.
2. Open the project root (`PolyLingo_AI_Source`) in Android Studio. The repository intentionally does not contain a `gradle-wrapper.jar`; configure **Gradle 8.9** as a local Gradle installation, or generate a wrapper by running `gradle wrapper --gradle-version 8.9` from the project root (with Gradle already installed).
3. Allow Gradle to download dependencies. This is a development-time operation; it does not mean translation texts are uploaded to servers.
4. Build → Build APK(s), or run `gradle assembleDebug`.
5. Output location: `app/build/outputs/apk/debug/app-debug.apk`.
6. For CI: push to a GitHub repository and run the included **Build Android APK** workflow. Its APK artifact is available after a successful workflow run. This workflow has not been executed here.

## First-time app setup

1. Connect to Wi-Fi. Tap **Download all / সব মডেল নামান** to cache all five translation models on-device.
2. Once the app reports `5/5`, text translation can work without connectivity.
3. To use voice input, install the phone's **offline English and Arabic speech recognition** language data if supported by its on-device recognizer.
4. To use pronunciation, install **offline English and Arabic Text-to-Speech voices** in Android TTS settings. The app rejects voices that require network access.
5. Long-press selectable text in supported apps and choose **PolyLingo AI** from the selection menu (may be under the three-dot overflow menu).

## Security and privacy

- Internet permission is only needed for downloading ML Kit language packs. The app does not implement any custom web requests, account login, ads, telemetry, or cloud translation.
- The mic permission is requested only when the user taps Speak.
- `SpeechRecognizer.createOnDeviceSpeechRecognizer()` is used; there is no online fallback.
- The app does not request accessibility, overlay, storage, or background microphone permissions.
- Translation history stays in local SQLite storage. Android backup is disabled.

## Important technical caveats

- ML Kit on-device translation is suitable for casual text; non-English → non-English translation may pivot through English, reducing accuracy.
- ML Kit SDK is free to integrate but is **not an open-source translation model bundle**. Follow Google ML Kit terms and attribution guidelines before redistribution.
- Offline Arabic voice quality depends on the user's installed TTS engine. An Arabic offline voice is **not** packaged in this repository.
- Arabic/Urdu auto-detection is uncertain for very short or mixed-script inputs; manual language selection is supported.
- Do not represent the small correction rules as a complete grammar checker.
- The APK was not built or tested in the authoring environment; integration issues may need to be resolved in Android Studio.

## Official references

- ML Kit on-device translation: https://developers.google.com/ml-kit/language/translation/android
- Supported language codes: https://developers.google.com/ml-kit/language/translation/translation-language-support
- ML Kit language identification: https://developers.google.com/ml-kit/language/identification/android
- Android `ACTION_PROCESS_TEXT`: https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT
- Android `SpeechRecognizer`: https://developer.android.com/reference/android/speech/SpeechRecognizer
- Android TTS voices: https://developer.android.com/reference/android/speech/tts/Voice

## ভবিষ্যৎ উন্নয়ন

প্রথম ইনস্টল থেকেই সম্পূর্ণ অফলাইনে কাজ করার জন্য আলাদাভাবে লাইসেন্সসম্মত multilingual model এবং English/Arabic ASR/TTS model অ্যাপের সঙ্গে প্যাকেজ করতে হবে। এটি বর্তমানে করা হয়নি। আরও নির্ভুল বানান/ব্যাকরণ সংশোধনের জন্য পাঁচ ভাষার উপযুক্ত অফলাইন অভিধান বা মডেল যুক্ত করতে হবে।

## APK build automation

See `BUILD_APK_GITHUB_BN.md` for the prepared GitHub Actions workflow. This project has NOT been compiled into an APK in the current environment.
