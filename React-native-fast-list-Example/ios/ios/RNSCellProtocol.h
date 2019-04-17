//
//  RNSCellProtocol.h
//  AndroidNativeCustomRefreshView
//
//  Created by huangchengdu on 2019/3/7.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RNSCellProtocol <NSObject>

@optional
-(void)setupCellWithParams:(NSArray *)params rowTemplate:(NSDictionary *)rowTemplate;
-(void)setupCellWithParams:(NSDictionary *)params isCurrentVersionOnline:(BOOL)isCurrentVersionOnline;
-(void)setupCellWithParams:(NSDictionary *)params isCurrentVersionOnline:(BOOL)isCurrentVersionOnline showFreeBuy:(BOOL)showFreeBuy;


@end



NS_ASSUME_NONNULL_END
