import React ,{Component} from 'react';
import MapView from './MapView.js';
import {Alert} from 'react-native'

export default class MapViewModule extends Component{
    onRegionChange(event) {
        Alert.alert(JSON.stringify(event));
        // Do stuff with event.region.latitude, etc.
    }
    render(){
        var region = {
            latitude:31.22841,
            longitude: 121.357499,
            latitudeDelta: 0.05,
            longitudeDelta: 0.05,
          };
        return (<MapView zoomEnabled={false} region={region} style={{ flex: 1 }} onRegionChange={this.onRegionChange}>

        </MapView>);
    }
}