//
//  RNSModelFactory.m
//  Example
//
//  Created by huangchengdu on 2019/4/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RNSModelFactory.h"
#import <YYModel/YYModel.h>
#import "RNSUIViewModel.h"
#import "RNSUIImageViewModel.h"
#import "RNSUILableModel.h"


@implementation RNSModelFactory

+ (id)createModel:(NSDictionary *)params{
  RNSUIViewModel *model;
  NSString *type = params[@"type"];
  if ([type isEqualToString:@"view"]) {
    model = [RNSUIViewModel yy_modelWithJSON:params];
  }else if ([type isEqualToString:@"image"]) {
    model = [RNSUIImageViewModel yy_modelWithJSON:params];
  }else if ([type isEqualToString:@"text"]) {
    model = [RNSUILableModel yy_modelWithJSON:params];
  }
  if (model == nil){
    model = [RNSUIViewModel yy_modelWithJSON:params];
  }
  return model;
}

@end
