/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Image,TouchableOpacity,Dimensions} from 'react-native';
import FlatList from './src';
import dataList from './home';
import {getZoomIndex} from './platform.js'
import tbIcon from './tb-icon-1.png'

const SCREEN_WIDTH = Dimensions.get('window').width;
const SCREEN_HEIGHT = Dimensions.get('window').height;

const normalTemplate = [{
  rect:[0,10,getZoomIndex(SCREEN_WIDTH - 20),144],//上左宽高
  backgroundColor:[255, 255, 255, 1],// r g b a
  borderRadius: 5,  //圆角
  type:'view',
},
{
  rect:[16,18,128,128],//上左宽高
  backgroundColor:[255, 255, 255, 1],// r g b a
  content: '{$1}',
  type:'image',
},
{
  rect:[16 + 10,18 + 10,30,30],//上左宽高
  backgroundColor:[25, 255, 255, 1],// r g b a
  content: 'tb-icon-1.png',
  type:'image',
},
{//标题
  rect:[16,160,getZoomIndex(SCREEN_WIDTH - 180),50],//最大高度
  backgroundColor:[55, 55, 255, 1],
  color: [255, 255, 255, 1],
  type: 'text',
  align:'left',
  fontSize: 14,
  content: '----{$2}---',//三种类型  纯字符串   变量带文字  纯变量
}];

const secondTemplate = [{
  rect:[0,10,getZoomIndex(SCREEN_WIDTH - 20),144],//上左宽高
  backgroundColor:[235, 51, 35, 1],// r g b a
  borderRadius: 5,  //圆角
  type:'view',
},
{//标题
  rect:[16,160,getZoomIndex(SCREEN_WIDTH - 180),30],
  backgroundColor:[55, 55, 255, 1],
  type: 'text',
  align:'right',
  content:'你好这是测试',
  fontSize: 11,
  contentIndex: 2,
}
];
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
      <Image style={{width:30,height: 30,backgroundColor:'green'}} source={tbIcon}></Image>
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
