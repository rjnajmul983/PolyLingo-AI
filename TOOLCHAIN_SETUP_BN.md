# PolyLingo AI — Toolchain bootstrap and APK build

এই প্রজেক্টের জন্য নির্দিষ্ট Build Toolchain:
- JDK 17 বা তার পরের সংস্করণ
- Android Command-line Tools build `15859902`
- Android SDK Platform 35
- Android Build Tools 35.0.0
- Gradle 8.9
- Android Gradle Plugin 8.7.3 (এর জন্য Gradle 8.9 প্রয়োজন)

## Linux x86_64-এ এক কমান্ডে প্রস্তুতি ও বিল্ড

ইন্টারনেট-সংযুক্ত Linux কম্পিউটারে ZIP extract করে project root-এ:

```bash
chmod +x prepare_and_build.sh
./prepare_and_build.sh
```

স্ক্রিপ্টটি:
1. Android command-line tools ডাউনলোড করে SHA-256 যাচাই করবে।
2. Gradle 8.9 ডাউনলোড করে SHA-256 যাচাই করবে।
3. Android SDK Platform 35, Build Tools 35.0.0 ও Platform Tools ইনস্টল করবে।
4. Android SDK লাইসেন্স গ্রহণ করাবে।
5. প্রজেক্টের static checks ও unit tests চালাবে।
6. Debug APK তৈরি করে `dist/`-এ রাখবে।

**গুরুত্বপূর্ণ:** এই স্ক্রিপ্টটি চালানোর মেশিনে ইন্টারনেট, `curl`, `unzip`, `sha256sum`, `python3` এবং JDK 17+ থাকতে হবে। Android SDK license acceptance স্ক্রিপ্ট চালানোর সময় করা হয়। এটি Linux x86_64-এর জন্য; Android ফোনে সরাসরি চালানোর স্ক্রিপ্ট নয়।

## বর্তমান কাজের পরিবেশের অবস্থা

এই ChatGPT build container-এ Java 21 আছে, কিন্তু Android SDK/Gradle নেই। `dl.google.com`, `services.gradle.org` এবং Maven/Gradle repository-তে DNS resolve ব্যর্থ হওয়ায় এখানে toolchain download এবং APK compilation সম্পন্ন করা যায়নি। তাই কোনো APK-কে build-success বলে দেখানো হচ্ছে না.

## সামঞ্জস্য

AGP 8.7-এর জন্য Gradle 8.9 প্রয়োজন। Gradle 8.9 Java 21-এ চলতে পারে। Android Gradle Plugin-এর ন্যূনতম JDK 17।
