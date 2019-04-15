//
//  ReactNativeBridgeManager.m
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/2.
//

#import "ReactNativeBridgeManager.h"
#import <React/RCTLog.h>

NSString *const kEventEmitterManagerEvent  = @"EventEmitterManagerEvent";
 bool hasListener;
NSString *const navigatorPopEvent  = @"navigatorPopEvent";
bool hasListener;
@interface ReactNativeBridgeManager()
{
   
}
@end;

@implementation ReactNativeBridgeManager

@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();

-(void)startObserving{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calendarEventReminderReceived:) name:@"name" object:nil];
    hasListener = YES;
}
- (void)stopObserving{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    hasListener = NO;
}

RCT_EXPORT_METHOD(postNotificationEvent:(NSString *)name)
{
    RCTLogInfo(@"postNotificationEvent->:%@",name);
    [self sendEventWithName:kEventEmitterManagerEvent body:name];
}

RCT_EXPORT_METHOD(pop:(NSString *)name){
      [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}

- (NSArray<NSString *> *)supportedEvents{
    return @[@"EventReminder",kEventEmitterManagerEvent,navigatorPopEvent];
}

- (NSDictionary<NSString *, NSString *> *)constantsToExport {
    return @{
             @"EventEmitterManagerEvent": kEventEmitterManagerEvent,
             @"navigatorPopEvent":navigatorPopEvent
             };
}

- (void)calendarEventReminderReceived:(NSNotification *)notification{
//    NSString *eventName = notification.userInfo[@"name"];
    if(hasListener){
        NSString *str = [ReactNativeBridgeManager DataTOjsonString:@{@"name": @"huang"}];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self sendEventWithName:@"EventReminder" body:str];
        });
    }
}

+(void)emit:(NSString *)emitName args:(NSDictionary *)args{
    NSString *str = [self DataTOjsonString:args];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"name" object:str];
}

+(NSString*)DataTOjsonString:(id)object
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
