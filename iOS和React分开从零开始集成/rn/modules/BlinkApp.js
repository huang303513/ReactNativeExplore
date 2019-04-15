import React, { Component } from 'react';
import { AppRegistry,StyleSheet, Text, View } from 'react-native';

class Blink extends Component {
  constructor(props) {
    super(props);
    this.state = {isShowingText: true};
    // console.log("hehe" + JSON.stringify(props));
    // Toggle the state every second
    setInterval(() => {
      this.setState(previousState => {
        return { isShowingText: !previousState.isShowingText };
      });
    }, 1000);
  }

  render() {
    let display = this.state.isShowingText ? this.props.text : ' ';
    return (
      <Text style = {[styles.red,styles.bigBlue]}>{display}</Text>
    );
  }
}

export default class BlinkApp extends Component {
  render() {
    return (
      <View>
        <Blink style={styles.red} text='I love to blink' />
        <Blink style={styles.bigBlue} text='Yes blinking is so great' />
        <Blink style = {[styles.red,styles.bigBlue]} text='Why did they ever take this out of HTML' />
        <Blink text='Look at me look at me look at me' />
      </View>
    );
  }
}

let styles = StyleSheet.create({
  bigBlue:{
    color:'blue',
    fontWeight:'bold',
    fontSize:30
  },
  red:{
    color:'red'
  }
})