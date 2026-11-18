# GitHub Actions দিয়ে APK তৈরি — বাংলা নির্দেশনা

এই প্রজেক্টের **APK এখনো কম্পাইল করে যাচাই করা হয়নি**। এখানে GitHub Actions-এর জন্য বিল্ড ফাইল প্রস্তুত করা হয়েছে। GitHub-এ বিল্ড সফল হলে ডাউনলোডযোগ্য debug APK পাওয়া যাবে।

1. GitHub-এ একটি নতুন repository তৈরি করুন (যেমন `PolyLingoAI`)।
2. ZIP extract করে **`PolyLingo_AI_Source_v0.1.1` ফোল্ডারের ভেতরের সব ফাইল** repository-র root-এ আপলোড করুন। `.github/workflows/android.yml` ফাইলটিও রাখতে হবে (লুকানো `.github` ফোল্ডার)।
3. `main` branch-এ commit করুন।
4. GitHub repository → **Actions** → **Build PolyLingo Android APK** → **Run workflow** নির্বাচন করুন। (Push করলেও স্বয়ংক্রিয়ভাবে চলবে।)
5. সবুজ সফল status এলে সেই workflow run-এর **Artifacts** থেকে `PolyLingo_AI_v0.1.1-debug-APK` ডাউনলোড করুন।
6. ZIP extract করলে `PolyLingo_AI_v0.1.1-debug.apk` এবং `SHA256SUMS.txt` পাবেন। APK Android ফোনে ইনস্টল করা যাবে।

## গুরুত্বপূর্ণ

- Debug APK ব্যক্তিগত পরীক্ষা করার জন্য; Play Store-এ প্রকাশের উপযোগী signed release APK নয়।
- Google ML Kit translation model প্রথমবার ডাউনলোড করতে হবে। **ইনস্টল করার মুহূর্ত থেকেই পুরোপুরি অফলাইন নয়।**
- English/Arabic offline speech input ও TTS-এর জন্য ফোনে সংশ্লিষ্ট on-device engine/voice pack থাকতে হবে।
- বানান ও grammar correction এখন ছোট কিছু নিয়মে সীমাবদ্ধ।
- এই চ্যাটের পরিবেশে Android SDK/Gradle এবং প্রয়োজনীয় বাইরের ডাউনলোড অ্যাক্সেস পাওয়া যায়নি। ফলে এখানে বাস্তব APK বিল্ড করা যায়নি।
- কোনো GitHub build ব্যর্থ হলে **Actions → ব্যর্থ step-এর log** পাঠালে সংশ্লিষ্ট code/Gradle error সংশোধন করা যাবে।
