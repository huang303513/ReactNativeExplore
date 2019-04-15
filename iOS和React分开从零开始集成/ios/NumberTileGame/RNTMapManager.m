//
//  RNTMapManager.m
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/3.
//

#import "RNTMapManager.h"
#import <React/RCTConvert.h>
#import "RCTConvert+Mapkit.h"
#import "RNTMapView.h"

@interface RNTMapManager()<MKMapViewDelegate>

@end;

@implementation RNTMapManager
RCT_EXPORT_MODULE();

//暴露view的属性给js
RCT_EXPORT_VIEW_PROPERTY(zoomEnabled, BOOL);

RCT_EXPORT_VIEW_PROPERTY(onRegionChange, RCTBubblingEventBlock);

//js传递自定义的属性过来
RCT_CUSTOM_VIEW_PROPERTY(region, MKCoordinateRegion, MKMapView)
{
    [view setRegion:json ? [RCTConvert MKCoordinateRegion:json] : defaultView.region animated:YES];
}

-(UIView *)view{
    RNTMapView *map = [RNTMapView new];
    map.delegate = self;
    return map;
}

#pragma mark MKMapViewDelegate
- (void)mapView:(RNTMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    if(!mapView.onRegionChange){
        return;
    }
    MKCoordinateRegion region = mapView.region;
    mapView.onRegionChange(@{
                             @"region": @{
                                     @"latitude": @(region.center.latitude),
                                     @"longitude": @(region.center.longitude),
                                     @"latitudeDelta": @(region.span.latitudeDelta),
                                     @"longitudeDelta": @(region.span.longitudeDelta),
                                     }
                             });
}

@end
