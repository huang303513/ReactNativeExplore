import React from 'react';
import {StyleSheet, Text, View,Image} from 'react-native';

export default class RNHighScores extends React.Component {
    render() {
      //从native传过来的信息
      var contents = this.props['scores'].map((score) => (
        <Text key={score.name}>
          {score.name}:{score.value}
          {'\n'}
        </Text>
      ));
      let pic = {
        uri: 'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg'
      };
      return (
        <View style={styles.container}>
          <Text style={styles.highScoresTitle}>2048 High Scores黄成都!</Text>
          <Text style={styles.scores}>{contents}</Text>
          <Image source={pic} style={{width:193,height:110}}></Image>
        </View>
      );
    }
  }
  
  const styles = StyleSheet.create({
    container: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: 'green',
    },
    highScoresTitle: {
      fontSize: 20,
      textAlign: 'center',
      margin: 10,
    },
    scores: {
      textAlign: 'center',
      color: '#333333',
      marginBottom: 5,
    },
  });