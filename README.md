# PhoneAuth

A new Flutter project with Firebase Phone auth

## How to Run
#### Install flutter
This project uses [flutter](https://flutter.dev/) so download the flutter sdk and setup your environment by following the instructions [here](https://flutter.dev/docs/get-started/install)  
This project was built using the following version, make sure you use a compatible environment
```
Flutter 1.17.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision e6b34c2b5c (9 weeks ago) • 2020-05-02 11:39:18 -0700
Engine • revision 540786dd51
Tools • Dart 2.8.1
```
#### Connect your device
Connect an android device to your computer
#### Cd to project directory
Change your current working directory to the project directory. That is the directory containing this README file
```
cd ./
```
#### Get flutter dependencies
```
flutter pub get
```
#### Run
To run in debug mode run
```
flutter run
```
To run in profile mode run (only for physical devices)
```
flutter run --profile
```
To run in release mode run (only for physical devices)
```
flutter run --release
```
This will run your app in the device connected to your computer

## How to Install
You can also build an apk and install it on your phone
#### Generate an apk
```
flutter build apk
mv build/app/outputs/apk/release/app-release.apk app.apk
```
#### Install the apk
```
adb install app.apk
```