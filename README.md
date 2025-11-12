# riskready

A new Flutter project.

## Getting Started


# description 
    RiskReady is a mobile-based application designed to support emergency
preparedness and first aid literacy among Filipino communities. The app consolidates essential resources into a user-friendly interface, enabling quick access to life-saving information during critical situations. It features a categorized directory of emergency contacts, including local fire departments, disaster risk reduction offices, and medical hotlines, with options to filter by city, initiate direct calls, and manage
personalized entries. In addition to contact management, RiskReady offers a comprehensive set of first aid guides covering scenarios such as adult CPR, choking, bleeding control, burns, fractures, shock, heat-related illnesses, and poisoning. These guides are structured for rapid comprehension and are accessible offline, ensuring usability in low-connectivity environments. The application also includes a curated
list of safety tips that promote proactive preparedness, such as creating family emergency plans, assembling 72-hour survival kits, securing household hazards, and learning basic first aid and CPR. Navigation is facilitated through a tab-based system, allowing users to switch seamlessly between modules labeled Contacts, First Aid, Tips, Favorites, and More. Designed with cultural relevance in mind and by
combining intuitive design, localized content, and evidence-based practices, RiskReady contributes to the broader goals of public safety, health education, and community resilience.


## How It Works:
1. City Filter: Users can select a city from the dropdown menu (e.g., Davao City, Tagum City, Panabo City) to view all the emergency contacts for that area. 2. Add City: Users can tap the “Add City” icon button on the AppBar to register a
new city not included in the default list. The new city will appear in the dropdown list
automatically. 3. Add Contact: The “Add Contact” floating button allows users to create and save
new emergency contacts under any city. 4. Favorites: Tapping the heart icon beside any contact adds it to the Favorites tab
for faster access.
5. Call Directly: Tapping any contact will automatically launch the phone dialer with
the selected number ready to call. 6. Data Saving: The app uses SharedPreferences to store favorites and custom cities
locally — ensuring that added data remains available even after the app is closed.




## Installation

• Install Flutter SDK from flutter.dev 
• Install VS Code and add Flutter and Dart extensions 
• Install Android Studio to use the Android Emulator 
• Run this in the terminal to check everything:
        flutter doctor

2. Create the Project
Open visual Studio code and run:
        flutter create riskready
        cd riskready

3. Add a Package
In pubspec.yaml, add:

name: riskready
description: "RiskReady Flutter App with custom icon and splash screen."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.9.2

dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.3
  url_launcher: ^6.3.0
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  flutter_launcher_icons: ^0.14.4
  flutter_native_splash: ^2.4.7

flutter:
  uses-material-design: true
  assets:
    - assets/images/logo.png

# ---------------------------
# Launcher Icon Configuration
# ---------------------------
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/logo.png"
  adaptive_icon_background: "#ffffff"
  adaptive_icon_foreground: "assets/images/logo.png"

# ---------------------------
# Splash Screen Configuration
# ---------------------------
flutter_native_splash:
  color: "#ffffff"
  image: assets/images/logo.png
  android: true
  ios: true
  web: false


Then run:
        flutter pub get

4. Write the Code
Open lib/main.dart and paste the main RiskReady code that contains: - Contact class
- City and contact lists
- “Add City” and “Add Contact” dialogs
- Favorites feature

5. Run the App:
        flutter run


or

 1. Clone or download this repository:
   bash
   git clone https://github.com/capotejeverlyshane-cmyk/riskready.git

 2. Navigate into the folder:

        cd riskready

 3. Install dependencies:

        flutter pub get

 4. Run the app:

        flutter run



This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
