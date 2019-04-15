//
//  RCTConvert+MyEnumState.m
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/2.
//

#import "RCTConvert+MyEnumState.h"
#import "CalendarManager.h"

@implementation RCTConvert (MyEnumState)
RCT_ENUM_CONVERTER(MyEnumState, (@{ @"one" : @(MyEnumStateOne),
                                    @"two" : @(MyEnumStateTwo),
                                    @"three" : @(MyEnumStateThree)}),MyEnumStateOne, integerValue);
@end
