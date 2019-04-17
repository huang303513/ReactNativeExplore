//
//  RNSConvertModel.m
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/16.
//

#import "RNSConvertModel.h"

@implementation Content

@end

@implementation RNSConvertModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
  return @{@"child" : [RNSConvertModel class] };
}

@end
