//
//  RNSUILableModel.h
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSUIViewModel.h"
#import "RNSModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNSUILableModel : RNSUIViewModel<RNSModelProtocol>

@property(nonatomic, assign)NSTextAlignment align;
@property(nonatomic, assign)NSInteger fontSize;
@property(nonatomic, strong)UIColor *color;
@end

NS_ASSUME_NONNULL_END
