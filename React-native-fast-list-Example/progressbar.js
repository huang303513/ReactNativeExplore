import React, {Component} from 'react';
import { NativeModules, requireNativeComponent, View } from 'react-native';

// var iface = {
//   name: 'ProgressBar',
// //   propTypes: {
// //     progress: PropTypes.number,
// //     indeterminate: PropTypes.bool,
// //     ...View.propTypes // include the default view properties
// //   },
// };

class ProgressBar1 extends Component{
    constructor(props){
        super(props);
    }
}


var ProgressBar = requireNativeComponent('ProgressBar', ProgressBar1);

export default ProgressBar;