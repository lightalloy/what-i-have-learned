## Start an app
```bash
react-native start
android avd
react-native run-android
# log
react-native log-android
```

```bash
yarn start
yarn run android
yarn test
```

## Create a new app
```bash
# need to build native code
react-native init AwesomeProject

# no need to build native code
sudo npm install -g create-react-native-app
create-react-native-app TestCreateRNApp
```

## Adding/removing yarn packages
```bash
yarn add react-native-simple-time-picker
yarn remove react-native-simple-time-picker
```
19d2
## Debugging
```bash
# open developer menu
adb shell input keyevent 82
```
Standalone tools: install, start.
```
react-devtools
```
then run the emulator

Troubleshooting -- https://stackoverflow.com/questions/40898934/unable-to-connect-with-remote-debugger

## Running on the device
1) `lsusb`
2) Detect a line of the phone
`Bus 003 Device 010: ID 12d1:1052 Huawei Technologies Co., Ltd.`
3) Grab the first four digits from the device ID:
`12d1`
4) run `echo SUBSYSTEM=="usb", ATTR{idVendor}=="12d1", MODE="0666", GROUP="plugdev" | sudo tee /etc/udev/rules.d/51-android-usb.rules`
5) check that your device is properly connecting to ADB
`adb devices` -- get deviceId
6) Start an app -- `react-native run-android --deviceId 022NKM149H000764`
7) Connecting to the development server
Wi-Fi (android < 5.0)

## [Creating an apk](https://facebook.github.io/react-native/docs/signed-apk-android.html)
1) keytool -genkey -v -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
2) my-release-key.keystore => android/app
3) make config edits (~/.gradle/gradle.properties or android/gradle.properties)
4) `cd android && ./gradlew assembleRelease`



Metro bundler can't listen -- lsof -i -n -P | grep 8081


