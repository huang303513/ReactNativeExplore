import React, { Component } from 'react';
import { StyleSheet, View, Alert, Button, NativeEventEmitter, NativeModules } from 'react-native';
const { ReactNativeBridgeManager } = NativeModules;

//创建自定义事件接口
const nativeManagerEmitter = new NativeEventEmitter(ReactNativeBridgeManager);
//导出常量
const EventEmitterManagerEvent = ReactNativeBridgeManager.EventEmitterManagerEvent;


export default class NativeBridge extends Component {
    constructor(props) {
        super(props);
        this.subscription = null;
    }
    _addListener() {
        // 调用原生模块 postNotificationEvent方法
        ReactNativeBridgeManager.postNotificationEvent('张杨事件传递');
    }
    _removeListener() {
        Alert.alert(global.name);
        // this.subscription.remove();
    }
    componentDidMount(){
        this.subscription = nativeManagerEmitter.addListener(
            EventEmitterManagerEvent,
            (reminder) => {
                Alert.alert(reminder);
            }
        );
        this.subscription = nativeManagerEmitter.addListener(
            "EventReminder",
            (reminder) => {
                Alert.alert(reminder);
            }
        );
    }
    componentWillUnmount(){
        // this.subscription.remove();
    }
    render() {
        return (<View>
            <Button onPress={this._addListener} title="添加native事件监听"></Button>
            <Button onPress={this._removeListener} title="移除native事件监听" color="#841584"></Button>
        </View>);
    }
}

