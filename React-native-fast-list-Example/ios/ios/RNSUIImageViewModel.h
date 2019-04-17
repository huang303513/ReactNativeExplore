//
//  RNSUIImageViewModel.h
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSUIViewModel.h"
#import "RNSModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNSUIImageViewModel : RNSUIViewModel<RNSModelProtocol>

@property(nonatomic, assign)UIViewContentMode resizeMode;

@end

NS_ASSUME_NONNULL_END
