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

@required
-(void)setupCellWithParams:(NSDictionary *)params;

@end



NS_ASSUME_NONNULL_END
