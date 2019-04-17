//
//  RNSConvertView.h
//  RNSFastList
//
//  Created by huangchengdu on 2019/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RNSTableViewCell;
@interface RNSTemplateConvert : NSObject

- (instancetype)initWithCell:(RNSTableViewCell *)cell;

- (void)convertTemplateToView:(NSArray *)templates params:(NSArray *)params;

@end

NS_ASSUME_NONNULL_END
