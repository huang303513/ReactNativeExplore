//
//  RCTConvert+Mapkit.m
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/3.
//

#import "RCTConvert+Mapkit.h"

@implementation RCTConvert (Mapkit)
+ (MKCoordinateSpan)MKCoordinateSpan:(id)json
{
    json = [self NSDictionary:json];
    return (MKCoordinateSpan){
        [self CLLocationDegrees:json[@"latitudeDelta"]],
        [self CLLocationDegrees:json[@"longitudeDelta"]]
    };
}

+ (MKCoordinateRegion)MKCoordinateRegion:(id)json
{
    return (MKCoordinateRegion){
        [self CLLocationCoordinate2D:json],
        [self MKCoordinateSpan:json]
    };
}

@end
