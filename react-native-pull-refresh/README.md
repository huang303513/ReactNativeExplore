
# react-native-pull-refresh

## Getting started

`$ npm install react-native-pull-refresh --save`

### Mostly automatic installation

`$ react-native link react-native-pull-refresh`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-pull-refresh` and add `RNSPullRefresh.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNSPullRefresh.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import www.huangchengdu.com.RNSPullRefreshPackage;` to the imports at the top of the file
  - Add `new RNSPullRefreshPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-pull-refresh'
  	project(':react-native-pull-refresh').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-pull-refresh/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-pull-refresh')
  	```


## Usage
```javascript
import RNSPullRefresh from 'react-native-pull-refresh';

// TODO: What to do with the module?
RNSPullRefresh;
```
  