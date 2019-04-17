import {
    Platform,
    Dimensions,
    PixelRatio,
} from 'react-native';

// screen
const SCREEN_WIDTH = Dimensions.get('window').width;
const SCREEN_HEIGHT = Dimensions.get('window').height;

export const isIOS = Platform.OS === 'ios';

// iPhoneX
const X_WIDTH = 375;
const X_HEIGHT = 812;

// iphonexr iphonexs max
const XR_WIDTH = 414;
const XR_HEIGHT = 896;

export const isIPhoneX = isIOS
    && ((SCREEN_HEIGHT === X_HEIGHT && SCREEN_WIDTH === X_WIDTH)
    || (SCREEN_HEIGHT === X_WIDTH && SCREEN_WIDTH === X_HEIGHT)
    || (SCREEN_HEIGHT === XR_HEIGHT && SCREEN_WIDTH === XR_WIDTH));

// iPhone5
const IPHONE5_WIDTH = 320;
const IPHONE5_HEIGHT = 568;
const pixelRatio = PixelRatio.getFontScale();

export const isIPhone5 = isIOS
    && ((SCREEN_HEIGHT <= IPHONE5_HEIGHT && SCREEN_WIDTH === IPHONE5_WIDTH)
        || (SCREEN_HEIGHT <= IPHONE5_WIDTH && SCREEN_WIDTH === IPHONE5_HEIGHT));

export const isAndroid = Platform.OS === 'android';

export const isAndroid6OrAbove = isAndroid && Number(Platform.Version) >= 23;


export const selectStyles = (styles = {}) => {
    const {
        ios,
        iPhoneX,
        iPhone5,
        android,
        ...common
    } = styles;

    if (isIPhoneX && iPhoneX) {
        return Object.assign({}, common, ios, iPhoneX);
    }

    if (isIPhone5 && iPhone5) {
        return Object.assign({}, common, ios, iPhone5);
    }

    if (isIOS && ios) {
        return Object.assign({}, common, ios);
    }

    if (isAndroid && android) {
        return Object.assign({}, common, android);
    }

    return common;
};

export const getDarkContentStatusBarColor = (color) => {
    if (isAndroid6OrAbove) {
        return color;
    }
    return '#000000';
};

export const getZoomIndex = (value) => {
    const current = SCREEN_WIDTH / 375;
    return current * value;
};

export const getTextSize = value => (value * pixelRatio + 0.5);
