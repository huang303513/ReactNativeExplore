/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View,TouchableOpacity,Dimensions} from 'react-native';
import FlatList from 'react-native-fast-list';
import RNSReactNativeBridge from 'react-native-bridge';
import dataList from './home';


const normalTemplate = {
  rect:[0,10,-8,-10],//上左宽高
  bgColor:[123, 5, 25, 1],// r g b a
  cornerRadius: 5,  //圆角
  content:{
    type: 'view',//View
  },
  child:[
    {
      rect:[8,8,-8,null],
      size:[128, null],
      bgColor:[255, 255, 255, 1],
      tag:1001,
      content:{
        type:'imageView',//UIImageView
        contentIndex:1,//从1开始
      },
    },{
      rect:[8,{f:'left',t:'right',o:'8',r:1001},-8,-8],
      bgColor:[255, 255, 255, 1],
      content:{
        type:'view',
      },
      child:[
        {//标题
          rect:[0,0,null,0],
          bgColor:[255, 255, 255, 1],
          tag:1003,
          content: {
            type: 'text',
            align:'left',
            font: 'Pingfang SC',
            fontSize: 11,
            contentIndex: 2,
          },
        },
        // {//desc
        //   rect:[{f:'top',t:'bottom','o': 5, r: 1003},0,null, 0],
        //   tag:1004,
        //   content: {
        //     type: 'text',
        //     align:'left',
        //     font: 'Pingfang SC',
        //     fontSize: 11,
        //     contentIndex: 3,
        //   },
        // },{//优惠券背景
        //   rect:[{f:'top',t:'bottom','o': 5, r: 1004},0,null, null],
        //   size:[70, 20],
        //   tag:1005,
        //   content:{
        //     type:'imageView',
        //     contentIndex:4,
        //   },
        // },
        {//右下角
          rect:[null,null,0, 0],
          size:[null,20],
          tag:1006,
          bgColor:[25, 25, 255, 1],
          content:{
            type:'text',
            contentIndex: 3,
            align:'right',
          },
        }
      ],
    }
  ],
};

const secondTemplate = {
  rect:[0,10,-8,-10],//上左宽高
  bgColor:[123, 5, 25, 1],// r g b a
  cornerRadius: 5,  //圆角
  content:{
    type: 'view',//View
  },
  child:[
    {
      rect:[8,8,-8,null],
      size:[128, null],
      bgColor:[255, 255, 255, 1],
      tag:1001,
      content:{
        type:'imageView',//UIImageView
        contentIndex:1,//从1开始
      },
    },{
      rect:[8,{f:'left',t:'right',o:'8',r:1001},-8,-8],
      bgColor:[255, 255, 255, 1],
      content:{
        type:'view',
      },
      child:[
        {//标题
          rect:[0,0,null,0],
          bgColor:[255, 55, 255, 1],
          tag:1003,
          content: {
            type: 'text',
            align:'left',
            font: 'Pingfang SC',
            fontSize: 11,
            contentIndex: 2,
          },
        },
        // {//desc
        //   rect:[{f:'top',t:'bottom','o': 5, r: 1003},0,null, 0],
        //   tag:1004,
        //   content: {
        //     type: 'text',
        //     align:'left',
        //     font: 'Pingfang SC',
        //     fontSize: 11,
        //     contentIndex: 3,
        //   },
        // },{//优惠券背景
        //   rect:[{f:'top',t:'bottom','o': 5, r: 1004},0,null, null],
        //   size:[70, 20],
        //   tag:1005,
        //   content:{
        //     type:'imageView',
        //     contentIndex:4,
        //   },
        // },
        {//右下角
          rect:[null,null,0, 0],
          size:[null,20],
          tag:1006,
          bgColor:[25, 25, 25, 1],
          content:{
            type:'text',
            contentIndex: 3,
            align:'right',
          },
        }
      ],
    }
  ],
};
// import ToastExample from './ToastExample';
// import ProgressBar from './progressbar';

export default class App extends Component {

  constructor(props){
    super(props);
    this.state = {
      refreshing: false,
      numColumns: 1,
      fullListLoaded: false,
      data: dataList,
    }
  }

  getView() {
    return <View style={styles.xx}>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text> Hello </Text>
    </View>;
  }

  getView1() {
    return <View>
      <Text style={styles.welcome}>We大法师t Native!</Text>
      <Text style={styles.welcome}>We大法师t Native!</Text>
      <Text style={styles.welcome}>We大法师t Native!</Text>
      <Text style={styles.welcome}>We大法师t Native!</Text>
    </View>;
  }

  scrollToOffset = () => {
    // ToastExample.show("Awesome", ToastExample.SHORT);
    this._UI.scrollToOffset({offset:0});
  }

  render() {
    const {data, refreshing,fullListLoaded, numColumns} = this.state;

    let result = []
    data.map((item,index) =>{
      const imageUrl = item.imageUrl;
      const title = item.title;
      if (index%3 === 0) {
        result.push(["second", imageUrl, title,'Test Test']);
      }else{
        result.push(["normal", imageUrl, title,'Test Test']);
      }
    });

    return (
      <View style={styles.container}>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text style={styles.welcome}>Welcome to React Native!</Text>
      <Text> Hello </Text>
        {(Platform.OS === 'ios') && 
        <FlatList style={styles.flatList}
          ref={r=>{this._UI = r;}}
          rowTemplate={{
            normal: normalTemplate,
            second: secondTemplate,
          }}
          // renderItem={(numColumns === 1)?'RNSHomeCell':'RNSCategoryCollectionViewCell'}
          ListHeaderComponent={this.getView()}
          ListFooterComponent={this.getView1()}
          data={result}
          onClickItem={this.onClickItem}
          onRefresh={this.onRefresh}
          onEndReached={this.onEndReached}
          onScroll={this.onScroll}
          onScrollBeginDrag={this.onScrollBeginDrag}//开始拖动
          pullToRefresh={true}//default is true
          rowHeight={149}//collection must
          showFreeBuy={false}//default is false, tableview only
          fullListLoaded={fullListLoaded}
          isCurrentVersionOnline={true}
          numColumns={numColumns}//collection only, default 2
          refreshing={refreshing}
        />}
        {/* <ProgressBar progress={0} indeterminate={true} style={styles.progressBar}></ProgressBar> */}
        {/* <TouchableOpacity
                    style={styles.scrollToTop}
                    onPress={this.scrollToOffset}>
          </TouchableOpacity> */}
      </View>
    )
  }

  onClickItem = (e) => {
    const SCREEN_WIDTH = Dimensions.get('window').width;
    const SCREEN_HEIGHT = Dimensions.get('window').height;
    console.log("SCREEN_WIDTH===" + SCREEN_WIDTH + "===SCREEN_HEIGHT===" + SCREEN_HEIGHT);
    console.log("点击索引==>" + e.nativeEvent.index);
  }

  onScroll(e){
    console.log("滚动事件===>" + e.nativeEvent.contentOffset);
  }

  onScrollBeginDrag(e){
    console.log("开始拖动===>" + e.nativeEvent.contentOffset);
  }

  onRefresh = () =>{
    this.setState({
      refreshing:true,
    })
    let temp = dataList;
    setTimeout(() =>{
      this.setState({
        data: temp,
        refreshing:false,
      })
    },5000);
  }

  onEndReached = () =>{
    this.setState({
      refreshing:true,
    })
    const {data} = this.state;
    
    let temp = data.concat(dataList).concat(dataList);
    setTimeout(() =>{
      this.setState({
        data: temp,
        refreshing:false,
        fullListLoaded: temp.length>=300?true:false,
      })
    },1000);
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'red',
  },
  flatList:{
    backgroundColor: '#F6F7F9',
    // backgroundColor:'green',
    flex: 1,
    marginTop: 0,
    marginBottom: 0,
  },
  xx: {
    marginTop:20,
    paddingBottom: 30,
  },
  scrollToTop:{
    width:30,
    height:30,
    backgroundColor:'blue',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    // margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    // marginBottom: 5,
  },
  progressBar: {
    height: 50,
    // flex: 1,
    margin: 20,
    width: Dimensions.get('window').width - 2 * 20,
  },
});
