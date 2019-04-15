//
//  RCTConvert+Mapkit.h
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/3.
//

#import <React/RCTConvert.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <React/RCTConvert+CoreLocation.h>

@interface RCTConvert (Mapkit)
+ (MKCoordinateSpan)MKCoordinateSpan:(id)json;
+ (MKCoordinateRegion)MKCoordinateRegion:(id)json;
@end
