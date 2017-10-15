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

## Debugging
```bash
# open developer menu
adb shell input keyevent 82
```