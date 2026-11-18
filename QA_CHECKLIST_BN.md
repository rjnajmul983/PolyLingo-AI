# PolyLingo AI — ফোনে পরীক্ষা করার তালিকা

**প্রজেক্টের বর্তমান অবস্থা:** এই চেকলিস্টের কোনো Android-device টেস্ট এই পরিবেশে চালানো হয়নি।

## ইনস্টল ও মডেল

- [ ] Android 12 বা পরের সংস্করণে APK ইনস্টল হয়
- [ ] প্রথমবার Wi-Fi দিয়ে পাঁচটি ML Kit model download হয়
- [ ] 5/5 installed দেখায়
- [ ] Airplane Mode চালু রেখে ইংরেজি ↔ বাংলা অনুবাদ কাজ করে
- [ ] Airplane Mode চালু রেখে আরবি ↔ উর্দু অনুবাদ কাজ করে
- [ ] Airplane Mode চালু রেখে হিন্দি ↔ বাংলা অনুবাদ কাজ করে
- [ ] ফোন রিস্টার্টের পরও অফলাইন মডেল থাকে

## ভয়েস (শুধু English / Arabic)

- [ ] English offline voice recognition language data ইনস্টল আছে
- [ ] Arabic offline voice recognition language data ইনস্টল আছে
- [ ] ইংরেজিতে কথা বললে টেক্সট আসে এবং অনুবাদ হয়
- [ ] আরবিতে কথা বললে টেক্সট আসে এবং অনুবাদ হয়
- [ ] ইন্টারনেট বন্ধ রেখে voice recognition কাজ করে
- [ ] English offline TTS voice দিয়ে মূল ও অনুবাদ পড়া যায়
- [ ] Arabic offline TTS voice দিয়ে মূল ও অনুবাদ পড়া যায়
- [ ] বাংলা, হিন্দি, উর্দুর জন্য voice output দেখায় না
- [ ] 0.8×, 1×, 1.2× গতি কাজ করে

## ইন্টারফেস

- [ ] বাংলা ও ইংরেজি UI পরিবর্তন করা যায়
- [ ] Dark/Light theme পরিবর্তন করা যায়
- [ ] পাঁচ ভাষার সব দিকের অনুবাদ করা যায়
- [ ] Long-press text → selection menu → PolyLingo AI পাওয়া যায় (সমর্থিত অ্যাপে)
- [ ] Share → PolyLingo AI থেকে লেখা আসে
- [ ] Copy, Paste, Share কাজ করে
- [ ] History এবং Favorites সংরক্ষিত থাকে
- [ ] Clear history-তে Favorites মুছে যায় না
- [ ] Auto language detection বাংলা/হিন্দি/ইংরেজি শনাক্ত করে
- [ ] Arabic/Urdu ambiguity হলে manual language selection কাজ করে
- [ ] Offline correction button ছোট নিয়মসেটের জন্য কাজ করে

## নিরাপত্তা ও ব্যাটারি

- [ ] মাইক্রোফোন অনুমতি কেবল ট্যাপ করার পর চায়
- [ ] Accessibility বা overlay permission চায় না
- [ ] কোনো অপ্রত্যাশিত নেটওয়ার্ক অনুরোধ নেই (মডেল সেটআপ ছাড়া)
- [ ] History ফোনের বাইরে পাঠানো হয় না
- [ ] ভয়েস ব্যবহারের পরে মাইক্রোফোন বন্ধ হয়
- [ ] লম্বা লেখার ক্ষেত্রে মেমোরি/ক্র্যাশ পরীক্ষা
