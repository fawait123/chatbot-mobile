# Pregnancy App

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Requirement
- Android Studio / Visual Studio Code
- Flutter `v.3.19.3`
- Java version OpenJDK `v.11.0.20`

clone this project into your lokal computer
```bash
git clone https://github.com/ridwanlte/apps_consultation_pregnant.git
```

change to directory
```bash
cd apps_consultation_pregnant
```

## installation & Running
install `flutter` package
```bash
flutter pub get
```
Running to debug

## Build to Apk

create keystore
```bash
 keytool -genkey -v -keystore android/app/pregnancy.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias pregnancy
```
then fill in the same form as below
```bash
What is your first and last name?
  [Unknown]:  Pregnancy
What is the name of your organizational unit?
  [Unknown]:  Pregnancy
What is the name of your organization?
  [Unknown]:  Pregnancy
What is the name of your City or Locality?
  [Unknown]:  Jakarta
What is the name of your State or Province?
  [Unknown]:  Indonesia
What is the two-letter country code for this unit?
  [Unknown]:  62
Is CN=Pregnancy, OU=Pregnancy, O=Pregnancy, L=Jakarta, ST=Indonesia, C=62 correct?
  [no]:  y
```

Then create a file named [project]/android/key.properties that contains a reference to your keystore.
```bash
storePassword=2wsx1qaz
keyPassword=2wsx1qaz
keyAlias=pregnancy
storeFile=pregnancy.jks
```
More Information, (https://docs.flutter.dev/deployment/android)

Next, clean flutter dan get dependency
```bash
flutter clean && flutter pub get
```

Finally
```bash
flutter build
```