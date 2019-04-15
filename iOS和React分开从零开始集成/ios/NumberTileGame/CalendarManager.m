//
//  CalendarManager.m
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/1.
//

#import "CalendarManager.h"
#import <React/RCTLog.h>
#import <React/RCTConvert.h>




@implementation CalendarManager
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(addEventV0:(NSString *)name location:(NSString *)location){
    RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

RCT_EXPORT_METHOD(addEventV2:(NSString *)name location:(NSString *)location date:(nonnull NSNumber *)secondsSinceUnixEpoch)
{
    NSDate *date = [RCTConvert NSDate:secondsSinceUnixEpoch];
    NSLog(@"%@",[date description]);
}


RCT_REMAP_METHOD(addEventV1, details:(NSDictionary *)details)
{
    NSString *location = [RCTConvert NSString:details[@"location"]];
    NSDate *time = [RCTConvert NSDate:details[@"time"]];
     NSLog(@"%@-------%@",[time description],location);
}
/*
 * native至少要调用一次callback。否则会导致内存泄露
 */
RCT_EXPORT_METHOD(findEventsV0:(RCTResponseSenderBlock)callback)
{
    NSDictionary *dic = @{
                          @"one":@"one",
                          @"two":@"two"
                          };
    NSString *str = [self DataTOjsonString:dic];
    NSArray *events = @[[NSNull null],str];
    callback(events);
}
/*
 *重定义js方法名
 */
RCT_REMAP_METHOD(findEvents,findEventsWithResolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSDictionary *dic = @{
                          @"one":@"one",
                          @"two":@"two"
                          };
    NSString *str = [self DataTOjsonString:dic];
    if (false) {
        resolve(str);
    } else {
        NSError *error = [NSError errorWithDomain:@"domain" code:100 userInfo:@{}];
        reject(@"no_events", @"There were no events", error);
    }
}
/*
 在js中使用枚举类型
 */
RCT_EXPORT_METHOD(updateMyEnumState:(MyEnumState)animation
                  completion:(RCTResponseSenderBlock)callback){
    NSString *str;
    if(animation == MyEnumStateOne){
        str = @"MyEnumStateOne";
    }else if(animation == MyEnumStateTwo){
        str = @"MyEnumStateTwo";
    }else if(animation == MyEnumStateThree){
        str = @"MyEnumStateThree";
    }
    NSArray *events = @[[NSNull null],str];
    callback(events);
}

/*
 *导出属性
 */
- (NSDictionary *)constantsToExport{
    return @{
             @"firstDayOfTheWeek": @"Monday",
             @"one" : @(MyEnumStateOne),
             @"two" : @(MyEnumStateTwo),
             @"three" : @(MyEnumStateThree)
             };
}



-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
