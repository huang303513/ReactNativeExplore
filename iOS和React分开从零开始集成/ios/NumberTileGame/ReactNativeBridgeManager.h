//
//  ReactNativeBridgeManager.h
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/2.
//

#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

extern NSString *const navigatorPopEvent;

@interface ReactNativeBridgeManager : RCTEventEmitter<RCTBridgeModule>
+(void)emit:(NSString *)emitName args:(NSDictionary *)args;
@end
