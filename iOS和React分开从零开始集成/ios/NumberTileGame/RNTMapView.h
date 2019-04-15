//
//  RNTMapView.h
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/3.
//

#import <MapKit/MapKit.h>
#import <React/RCTComponent.h>

@interface RNTMapView : MKMapView

@property(nonatomic,copy)RCTBubblingEventBlock onRegionChange;

@end
