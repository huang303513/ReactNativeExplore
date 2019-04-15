import React, { Component } from 'react';
import { View, Button, Text, StyleSheet, Alert, NativeModules } from 'react-native';
var CalendarManager = NativeModules.CalendarManager;
var ReactNativeBridgeManager = NativeModules.ReactNativeBridgeManager;
let date = new Date();

export default class BridgeModule extends Component {
    _onPressButton() {

        CalendarManager.addEventV0('Birthday Party', '4 Privet Drive, Surrey');
    }
    _onPressButtonOne() {

        CalendarManager.addEventV2(
            'Birthday Party',
            '4 Privet Drive, Surrey',
            date.getTime()
        );
    }
    _onPressButtonTwo() {
        CalendarManager.addEventV1({
            location: '4 Privet Drive, Surrey',
            time: date.getTime(),
            description: '描述',
        });
    }
    _onPressButtonThree() {
        CalendarManager.findEventsV0((error, events) => {
            if (error) {
                console.error(error);
            } else {
                Alert.alert(events);
            }
        });
    }
    async _onPressButtonFour() {
        try {
            var events = await CalendarManager.findEvents().catch(e =>{
                Alert.alert(e && e.code);
                // debugger;
                // console.log("============"  + e);
            });
            if (events) {
                Alert.alert(events);
            }
        } catch (e) {}
        // try {
        //     CalendarManager.findEvents().then(event =>{
        //         debugger;
        //         console.log("--------"+event + "------");
        //     }).catch(e =>{
        //         debugger;
        //         console.log("--------"+e + "------");
        //     });
        // } catch (error) {
        //     debugger;
        //     console.log(error);
        // }
        
    }
    //只有在初始化的时候才有用。其他时候修改值啥的都对js环境没有影响。
    _onPressButtonFive(){
        Alert.alert(CalendarManager.firstDayOfTheWeek);
    }
    _onPressButtonSix(){
        CalendarManager.updateMyEnumState("three",(error, events) => {
            if (error) {
                console.error(error);
            } else {
                Alert.alert(events);
            }
        });
    }
    _onPressButtonSeven(){
    }
    render() {
        return (
            <View style={styles.container}>
                <View style={styles.buttonContainer}>
                    <Button onPress={this._onPressButton} title="调用native方法"></Button>
                </View>
                <View style={styles.buttonContainer}>
                    <Button onPress={this._onPressButtonOne} title="调用native方法" color="#841584"></Button>
                </View>
                <View style={styles.alternativeLayoutButtonContainer}>
                    <Button
                        onPress={this._onPressButtonTwo}
                        title="调用native方法"
                    />
                    <Button
                        onPress={this._onPressButtonThree}
                        title="调用native方法"
                        color="#841584"
                    />
                </View>
                <View style={styles.buttonContainer}>
                    <Button onPress={this._onPressButtonFour} title="调用native的Promise使用"></Button>
                </View>
                <View style={styles.buttonContainer}>
                    <Button onPress={this._onPressButtonFive} title="获取Native常量" color="#841584"></Button>
                </View>
                <View style={styles.buttonContainer}>
                    <Button onPress={this._onPressButtonSix} title="获取Native枚举类型" color="#841584"></Button>
                </View>
                <View style={styles.buttonContainer}>
                    <Button onPress={this._onPressButtonSeven} title="RN不同组件之间发送消息,实现不了" color="#841584"></Button>
                </View>
            </View>
        );
    }
}

let styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center'
    },
    buttonContainer: {
        backgroundColor: 'red',
        margin: 10
    },
    alternativeLayoutButtonContainer: {
        backgroundColor: 'green',
        margin: 10,
        flexDirection: 'row',
        justifyContent: 'space-between'
    }
});