//
//  CalendarManager.h
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/1.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

typedef NS_ENUM(NSInteger,MyEnumState){
    MyEnumStateOne,
    MyEnumStateTwo,
    MyEnumStateThree
};

@interface CalendarManager : NSObject<RCTBridgeModule>


@end
