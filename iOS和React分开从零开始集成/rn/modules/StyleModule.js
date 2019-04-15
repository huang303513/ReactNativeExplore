import React, {Component} from 'react';
import {StyleSheet,View,Text} from 'react-native';

export default class StyleModule extends Component{
    constructor(props){
        super(props);
    }
    render(){
        return (
            <View style={styles.father}>
                <View style={styles.red}></View>
                <View style={styles.blue}></View>
                <View style={styles.green}></View>
            </View>
        );
    }
}

let styles = StyleSheet.create({
    father:{
        flex:1,
        flexDirection:'column',
        justifyContent:'center',
        alignItems:'center'
    },
    red:{
        width:50,
        height:40,
        backgroundColor:'red'
    },
    blue:{
        width:50,
        height:40,
        backgroundColor:'blue'
    },
    green:{
        width:50,
        height:40,
        backgroundColor:'green'
    }
});