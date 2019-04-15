import {requireNativeComponent,Alert} from 'react-native';
import PropTypes from 'prop-types';
import React,{Component} from 'react'; 

class MapView extends Component{
    _onRegionChange = (event) => {
        // debugger;
        console.log(event.nativeEvent);
        console.log(event);
        if (!this.props.onRegionChange) {
          return;
        }
        this.props.onRegionChange(event.nativeEvent);
    }
    render(){
        return <RNTMap {...this.props} onRegionChange={this._onRegionChange}></RNTMap>
    }
}

MapView.propTypes ={
    zoomEnabled:PropTypes.bool,
    region: PropTypes.shape({
        latitude: PropTypes.number.isRequired,
        longitude: PropTypes.number.isRequired,
        latitudeDelta: PropTypes.number.isRequired,
        longitudeDelta: PropTypes.number.isRequired,
      }),
    onRegionChange: PropTypes.func,
};

let RNTMap = requireNativeComponent('RNTMap',MapView);

export default MapView;


//可以什么都不做，直接导出下面这个。则和nativa的mapview对应
// export default requireNativeComponent('RNTMap',null);