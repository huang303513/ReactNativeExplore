//
//  RNSModelFactory.h
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNSModelFactory : NSObject

+ (id)createModel:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
